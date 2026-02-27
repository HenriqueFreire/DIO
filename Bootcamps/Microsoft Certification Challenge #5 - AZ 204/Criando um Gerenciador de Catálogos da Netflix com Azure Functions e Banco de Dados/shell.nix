{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Azure Functions Core Tools for local development
    azure-functions-core-tools

    # Add language-specific SDKs here based on your function app's language
    # Example for C# Azure Functions:
    # dotnet-sdk_8 # or the appropriate version like dotnet-sdk_6_0, dotnet-sdk_7_0

    # Example for JavaScript/TypeScript Azure Functions:
    # nodejs_20_x # or another LTS version
    nodejs_20
    typescript

    # Example for Python Azure Functions:
    # python3 # and potentially python3Packages.pip, python3Packages.venv
  ];

  # You can add environment variables or shell hooks here if needed
  # shellHook = ''
  #   echo "Welcome to the Azure Functions development environment!"
  # '';
}
