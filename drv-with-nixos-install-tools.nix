let

  nixos-expr = builtins.fetchTarball {
    url = "https://nixos.org/channels/nixos-20.03-small/nixexprs.tar.xz";
    sha256 = "1a5d5qpmakyvqzn99x7p5lc4114mynk9wpz4mrzbixmmp4njxz75";
  };
  nixos = import "${nixos-expr}/nixos" { configuration = {}; };

  nixos-install-tools = with nixos.config.system.build; [
    nixos-generate-config
    nixos-install
    nixos-enter
    manual.manpages
  ];

  nixpkgs = import "${nixos-expr}/nixpkgs" {};
  pkgs = nixpkgs.pkgs;

in nixpkgs.stdenv.mkDerivation {
  name = "nixos-install-tools";
  buildInputs = [ pkgs.nix ] ++ nixos-install-tools;

  TERM = "xterm";
}
