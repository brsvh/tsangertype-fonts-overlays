{ callPackage, lib, ... }:
with builtins;
with lib;
let
  mkTsangerTypeFontDerivation = callPackage ../mkTsangerTypeFontDerivation.nix { };
in
mkTsangerTypeFontDerivation {
  fontName = "yuyang-w05";
  fontChineseName = "仓耳渔阳体W05";
  allowCommercialUse = true;
}
