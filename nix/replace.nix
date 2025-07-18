{ lib }:

let
  processTemplate = template: vars:
    let
      replacements = lib.lists.zipLists
        (lib.attrsets.mapAttrsToList (k: v: "{{${k}}}") vars)
        (lib.attrsets.attrValues vars);
    in
      lib.strings.replaceStrings
        (map (x: x.fst) replacements)
        (map (x: x.snd) replacements)
        template;
in
{
  inherit processTemplate;
}
