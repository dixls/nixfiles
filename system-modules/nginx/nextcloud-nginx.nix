{config, pkgs, ...}:
{

  services.nginx.virtualHosts."cloud.snack.management" = {
    root = webroot;
    useACMEHost = "snack.management";
    locations = {
      "= /robots.txt" = {
        priority = 100;
        extraConfig = ''
          allow all;
          access_log off;
        '';
      };
      "= /" = {
        priority = 100;
        extraConfig = ''
          if ( $http_user_agent ~ ^DavClnt ) {
            return 302 /remote.php/webdav/$is_args$args;
          }
        '';
      };
      "^~ /.well-known" = {
        priority = 210;
        extraConfig = ''
          absolute_redirect off;
          location = /.well-known/carddav {
            return 301 /remote.php/dav/;
          }
          location = /.well-known/caldav {
            return 301 /remote.php/dav/;
          }
          location ~ ^/\.well-known/(?!acme-challenge|pki-validation) {
            return 301 /index.php$request_uri;
          }
          try_files $uri $uri/ =404;
        '';
      };
      "~ ^/(?:build|tests|config|lib|3rdparty|templates|data)(?:$|/)" = {
        priority = 450;
        extraConfig = ''
          return 404;
        '';
      };
      "~ ^/(?:\\.|autotest|occ|issue|indie|db_|console)" = {
        priority = 450;
        extraConfig = ''
          return 404;
        '';
      };
      "~ \\.php(?:$|/)" = {
        priority = 500;
        extraConfig = ''
          # legacy support (i.e. static files and directories in cfg.package)
          rewrite ^/(?!index|remote|public|cron|core\/ajax\/update|status|ocs\/v[12]|updater\/.+|ocs-provider\/.+|.+\/richdocumentscode(_arm64)?\/proxy) /index.php$request_uri;
          include ${config.services.nginx.package}/conf/fastcgi.conf;
          fastcgi_split_path_info ^(.+?\.php)(\\/.*)$;
          set $path_info $fastcgi_path_info;
          try_files $fastcgi_script_name =404;
          fastcgi_param PATH_INFO $path_info;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
          fastcgi_param HTTPS ${if cfg.https then "on" else "off"};
          fastcgi_param modHeadersAvailable true;
          fastcgi_param front_controller_active true;
          fastcgi_pass unix:${fpm.socket};
          fastcgi_intercept_errors on;
          fastcgi_request_buffering ${if cfg.nginx.enableFastcgiRequestBuffering then "on" else "off"};
          fastcgi_read_timeout ${toString cfg.fastcgiTimeout}s;
        '';
      };
      "~ \\.(?:css|js|mjs|svg|gif|ico|jpg|jpeg|png|webp|wasm|tflite|map|html|ttf|bcmap|mp4|webm|ogg|flac)$".extraConfig =
        ''
          try_files $uri /index.php$request_uri;
          expires 6M;
          access_log off;
          location ~ \.mjs$ {
            default_type text/javascript;
          }
          location ~ \.wasm$ {
            default_type application/wasm;
          }
        '';
      "~ ^\\/(?:updater|ocs-provider)(?:$|\\/)".extraConfig = ''
        try_files $uri/ =404;
        index index.php;
      '';
      "/remote" = {
        priority = 1500;
        extraConfig = ''
          return 301 /remote.php$request_uri;
        '';
      };
      "/" = {
        priority = 1600;
        extraConfig = ''
          try_files $uri $uri/ /index.php$request_uri;
        '';
      };
    };
    extraConfig = ''
      index index.php index.html /index.php$request_uri;
      add_header X-Content-Type-Options nosniff;
      add_header X-Robots-Tag "noindex, nofollow";
      add_header X-Permitted-Cross-Domain-Policies none;
      add_header X-Frame-Options sameorigin;
      add_header Referrer-Policy no-referrer;
      ${lib.optionalString (cfg.https) ''
        add_header Strict-Transport-Security "max-age=${toString cfg.nginx.hstsMaxAge}; includeSubDomains" always;
      ''}
      client_max_body_size ${cfg.maxUploadSize};
      fastcgi_buffers 64 4K;
      fastcgi_hide_header X-Powered-By;
      # mirror upstream htaccess file https://github.com/nextcloud/server/blob/v32.0.0/.htaccess#L40-L41
      fastcgi_hide_header Referrer-Policy;
      fastcgi_hide_header X-Content-Type-Options;
      fastcgi_hide_header X-Frame-Options;
      fastcgi_hide_header X-Permitted-Cross-Domain-Policies;
      fastcgi_hide_header X-Robots-Tag;
      gzip on;
      gzip_vary on;
      gzip_comp_level 4;
      gzip_min_length 256;
      gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
      gzip_types application/atom+xml text/javascript application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/wasm application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;
  
      ${lib.optionalString cfg.webfinger ''
        rewrite ^/.well-known/host-meta /public.php?service=host-meta last;
        rewrite ^/.well-known/host-meta.json /public.php?service=host-meta-json last;
      ''}
    '';
  };
}
