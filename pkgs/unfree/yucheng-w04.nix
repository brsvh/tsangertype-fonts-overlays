{ callPackage, lib, ... }:
with builtins;
with lib;
let
  mkTsangerTypeFontDerivation = callPackage ../mkTsangerTypeFontDerivation.nix { };
in
mkTsangerTypeFontDerivation {
  fontName = "yucheng-w04";
  fontChineseName = "仓耳羽辰体W04";
  allowCommercialUse = false;
}
