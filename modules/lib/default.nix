{ lib, ... }:
with lib;
{
  _module.args.foxlib = {
    reqVar = name: value: {
      assertion = value != null;
      message = "Required variable `${name}` is not set.";
    };

    reqFile = path: {
      assertion = builtins.pathExists path;
      message = "Required file/path `${path}` does not exist.";
    };
  };
}
