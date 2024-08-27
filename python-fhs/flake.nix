{
  description = "Python environment using micromamba";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      envWithScript = script:
        (pkgs.buildFHSUserEnv {
          name = "python-env";
          targetPkgs = pkgs:
            with pkgs; [
              micromamba
              just
            ];
          runScript = "${pkgs.writeShellScriptBin "runScript" (''
            export MAMBA_ROOT_PREFIX=./.mamba
            eval "$(micromamba shell hook -s bash)"
            if [ ! -d $MAMBA_ROOT_PREFIX ]; then
              micromamba create -f env.yml
            fi
            micromamba activate python-env
          '' + script)}/bin/runScript";
        })
        .env;
    in {
      devShell = envWithScript "bash";
    });
}
