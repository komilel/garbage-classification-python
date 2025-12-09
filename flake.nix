{
  description = "Python ML dev environment with flakes + direnv";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    pythonPackages = pkgs.python313Packages;
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pythonPackages; [
        numpy
        pandas
        scipy
        scikit-learn
        matplotlib
        seaborn
        tensorflow
        keras

        # Jupyter
        jupyterlab
        ipykernel
        notebook
      ];

      PYTHONPATH = ".";

      # Register Jupyter kernel once per project
      # shellHook = ''
      #   if ! [ -d ".venv-kernel" ]; then
      #     mkdir -p .venv-kernel
      #     python -m ipykernel install \
      #       --user \
      #       --name "flake-env" \
      #       --display-name "Python (flake-env)"
      #   fi
      # '';
    };
  };
}
