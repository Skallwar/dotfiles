  { config, pkgs, nixpkgs_unstable, ... }: 
  let
    overlay-unstable = final: prev: {
      unstable = nixpkgs_unstable.legacyPackages.x86_64-linux;
    };
  in
  {
    nixpkgs.overlays = [ overlay-unstable ];
  }
