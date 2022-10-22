{
  description = "Customised iosevka fonts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        callPackage = pkgs.callPackage;
        origin = pkgs.iosevka;
        default = {
          no-cv-ss = true;
          export-glyph-names = false;
          no-ligation = true;
        };
      in {
        packages = {
          # Normal spacing
          iosevka = origin.override {
            set = "custom";
            privateBuildPlan = default // {
              family = "Iosevka";
              spacing = "normal";
              serifs = "sans";
            };
          };

          iosevka-slab = origin.override {
            set = "slab-custom";
            privateBuildPlan = default // {
              family = "Iosevka Slab";
              spacing = "normal";
              serifs = "slab";
            };
          };

          # Fixed spacing
          iosevka-fixed = origin.override {
            set = "fixed-custom";
            privateBuildPlan = default // {
              family = "Iosevka Fixed";
              spacing = "fixed";
              serifs = "sans";
            };
          };

          iosevka-fixed-slab = origin.override {
            set = "fixed-slab-custom";
            privateBuildPlan = default // {
              family = "Iosevka Fixed Slab";
              spacing = "fixed";
              serifs = "slab";
            };
          };

          # Quasi-proportional spacing
          iosevka-aile = origin.override {
            set = "aile-custom";
            privateBuildPlan = default // {
              family = "Iosevka Aile";
              spacing = "quasi-proportional";
              serifs = "sans";
            };
          };

          iosevka-etoile = origin.override {
            set = "etoile-custom";
            privateBuildPlan = default // {
              family = "Iosevka Etoile";
              spacing = "quasi-proportional";
              serifs = "slab";
            };
          };
        };
      }) // {
        overlays.default = final: prev: { iosevka-custom = self.packages.${prev.system}; };
      };
}
