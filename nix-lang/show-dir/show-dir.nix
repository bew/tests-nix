# Used docs:
#
# Builtins reference (not exaustive): https://nixos.org/nix/manual/#ssec-builtins
#
# nixpkgs in lib/attrsets.nix: (all functions for manipulating attributes sets)
#   https://github.com/NixOS/nixpkgs/blob/c7e0e9ed5abd0043e50ee371129fcb8640264fc4/lib/attrsets.nix
#
# nixpkgs in lib/lists.nix: (all functions for manipulating lists)
#   https://github.com/NixOS/nixpkgs/blob/6ff181331874fa1004ef187d97367bd762dc8c46/lib/lists.nix#L1

dirPath:

with builtins;
let
  lib = (import <nixpkgs> {}).lib;

  # type: set of 'filename = filetype;'
  dirContent = readDir dirPath;

  # type: list of '{name = filename; type = filetype;}'
  filesInfo = lib.mapAttrsToList (k: v: {name = k; type = v;}) dirContent;

  fileTypeToChar = fileType:
    let
      mapping = {
        directory = "d";
        symlink = "l";
        regular = "f";
      };
    in mapping.${fileType} or "?";

  traceFileInfo = {type, name}: ret:
    trace "${fileTypeToChar type} '${name}'" ret;

  traceFileInfoAndReturnTrue = info: traceFileInfo info true;

  results = map traceFileInfoAndReturnTrue filesInfo;
in lib.count (x: x) results
