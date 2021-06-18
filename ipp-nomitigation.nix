{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs { }}:
with pkgs;

stdenvNoCC.mkDerivation {
  name = "ippcrypto-nomitigation";
  src = fetchFromGitHub {
    owner = "sbellem";
    repo = "linux-sgx";
    rev = "e6036d6edb4371f2acc64c50b7cb51e9dfa439a4";
    # NOTE to get the sha256, use the following command:
    # nix run -f '<nixpkgs>' nix-prefetch-github -c nix-prefetch-github \
    #       --fetch-submodules --rev e6036d6edb4371f2acc64c50b7cb51e9dfa439a4 \
    #       sbellem linux-sgx
    sha256 = "0znallianv3lp3y62cfdgp8gacpw516qg8cjxhz8bj5lv5qghchk";
    fetchSubmodules = true;
  };
  buildInputs = [
    binutils
    autoconf
    automake
    libtool
    ocaml
    ocamlPackages.ocamlbuild
    file
    cmake
    gnum4
    openssl
    gcc
    gnumake
    texinfo
    bison
    flex
    perl
    python3
    git
    nasm
  ];
  dontConfigure = true;
  # sgx expects binutils to be under /usr/local/bin by default
  preBuild = ''
    export BINUTILS_DIR=$binutils/bin
    '';
  buildPhase = ''
    runHook preBuild

    cd external/ippcp_internal/
    make
    
    runHook postBuild
    '';
  postBuild = ''
    mkdir -p $out
    cp -r ./lib $out/lib
    cp -r ./inc $out/inc
    cp -r ./license $out/license
    ls -l ./inc/
  '';
  dontInstall = true;
  dontFixup = true;
}
