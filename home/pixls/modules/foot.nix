{pkgs, lib, ...}: {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "FantasqueSansMNerdFont:size=10";
        dpi-aware = "yes";
        pad = "5x5";
      };
      cursor = {
        color="1A1826 D9E0EE";
      };
      colors = {
        foreground="E9E0D2"; # Text
        background="08211B"; # Base
        alpha=".85";
        regular0="82B0A5";   # Surface 1
        regular1="EAA09C";   # red
        regular2="7AB49D";   # green
        regular3="F2DDBC";   # yellow
        regular4="8DBAED";   # blue
        regular5="F5CABF";   # pink
        regular6="A1CBC0";   # teal
        regular7="82B0A5";   # Subtext 1
        bright0="1F4E43";    # Surface 2
        bright1="EAA09C";    # red
        bright2="8AA99D";    # green
        bright3="F2DDBC";    # yellow
        bright4="8DBAED";    # blue
        bright5="F5CABF";    # pink
        bright6="A1CBC0";    # teal
        bright7="59A391";    # Subtext 0
      };
    };


  };
}
