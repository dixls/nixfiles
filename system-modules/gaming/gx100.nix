{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
}:
let
  version = "0.0.1";

in 
stdenv.mkDerivation {
  name = "hid-gx100-shifter-${version}-${kernel.version}";

  src = fetchFromGithub {
    owner = "giantorth";
    repo = "hid-gx100-shifter";
    rev = version;
  };

  hardeningDisable = [ "pic" ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernelModuleMakeFlags;

  buildFlags = [
    "KVERSION=${kernel.modDirVersion}"
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    install -D hid-gx100-shifter $out/lib/modules/${kernel.modDirVersion}/misc/hid-gx100-shifter.ko
  '';

  meta = {
    maintainers = with lib.maintainers; [ dixls ];
    license = lib.licenses.gpl2Plus;
    platforms = [
      "x86_64-linux"
    ];
    broken = lib.versionOlder kernel.version "5.10";
    description = "HID driver for chinese GX100 shifter";
    homepage = "https://github.com/giantorth/hid-gx100-shifter";
  };
}
