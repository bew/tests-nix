with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "test-crystal-project";

  buildInputs = [
    crystal
  ];

  # src = ./src;
  src = lib.sourceFilesBySuffices ./. [".cr"];

  buildPhase = ''
    ${crystal}/bin/crystal build hello.cr -o compiled-hello
  '';

  installPhase = ''
    cp compiled-hello $out
  '';
}
