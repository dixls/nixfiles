{pkgs, lib, config, ...}: 
{
  services.llama-cpp = {
    settings = {
      models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
        "Qwen3.8-27B" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF:UD-IQ4_XS";
          hf-file = "Qwen3.8-27B-UD-IQ4_XS.gguf";
          alias = "Qwen3.8-27B-GGUF IQ4 XS";
          temp = "0.2";
          repeat-penalty = "1.05";
          top-k = "80";
        };
      };
    };
  };
}
