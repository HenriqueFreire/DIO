{ pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  }
}:

let
  # Compose a custom Android SDK without system images to save space.
  # We only include the components necessary for building and using adb.
  customAndroidSdk = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ "34.0.0" ];
    platformVersions = [ "34" ];
    # By not specifying "system_images", we exclude them from the installation.
  };
in
pkgs.mkShell {
  # Add scrcpy for screen mirroring and use our custom, smaller SDK.
  buildInputs = with pkgs; [
    jdk17
    gradle
    android-studio
    kotlin
    scrcpy # For mirroring a physical device
    nix-ld # For running non-nix binaries

    customAndroidSdk.androidsdk
  ];

  # Set the ANDROID_SDK_ROOT to the path of our custom SDK.
  # The platform-tools (like adb) are automatically added to the PATH
  # by the customAndroidSdk derivation.
  shellHook = ''
    export ANDROID_HOME="${customAndroidSdk.androidsdk}/libexec/android-sdk"
    export ANDROID_SDK_ROOT="$ANDROID_HOME"
    export JAVA_HOME="${pkgs.jdk17}"
    export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/34.0.0/aapt2"
  '';
}