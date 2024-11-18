{
  lib,
  newScope,
  stdenvNoCC,
  xorg,
  ...
}:
let
  inherit (lib)
    attrValues
    concatStringsSep
    filterAttrs
    isDerivation
    makeScope
    ;
in
makeScope newScope (
  self:
  let
    inherit (self)
      callPackage
      ;

    fonts = {
      ZhuqueFangsong = callPackage ./ZhuqueFangsong.nix { };
    };

    combine' =
      name: cond:
      let
        drvs = attrValues (filterAttrs (n: v: isDerivation v && (cond v)) fonts);
      in
      stdenvNoCC.mkDerivation {
        pname = name;

        version = "0-unstable";

        buildInputs = [
          xorg.lndir
        ] ++ drvs;

        unpackPhase = "true";

        installPhase = ''
          runHook preInstall

          mkdir -p $out
          for drv in ${concatStringsSep " " drvs}; do
            ${xorg.lndir}/bin/lndir -silent $drv $out
          done

          runHook postInstall
        '';
      };

    combine = cond: combine' "trionestype-combined-fonts" cond;
  in
  fonts
  // {
    inherit
      combine
      combine'
      ;
  }
)
