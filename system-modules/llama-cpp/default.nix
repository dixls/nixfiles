{pkgs, lib, config, ...}: {
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-vulkan;
    settings = {
      host = "0.0.0.0";
      models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
        "Qwen3.6-35B-A3B" = {
          hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
          hf-file = "Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
          alias = "unsloth/Qwen3.6-35B-A3B-GGUF";
          temp = "0.2";
          repeat-penalty = "1.05";
          top-k = "80";
        };
      };
    };
  };
}
