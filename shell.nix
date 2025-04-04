{
  mkShell,
  ladybird,
  ccache,
  clang-tools,
  nodePackages,
  kdePackages,
  pre-commit-install,
  ...
}:
mkShell {
  name = "ladybird-devshell";

  inputsFrom = [
    ladybird
  ];

  packages = [
    ccache
    clang-tools
    nodePackages.prettier
  ];

  # See https://github.com/NixOS/nixpkgs/blob/79a8a723b9/pkgs/by-name/la/ladybird/package.nix#L144-L147
  NIX_LDFLAGS = "-lGL";

  shellHook = ''
    # TODO: Is this still needed?
    # NOTE: This is required to make it find the wayland platform plugin installed
    #       above, but should probably be fixed upstream.
    export QT_PLUGIN_PATH="$QT_PLUGIN_PATH:${kdePackages.qtwayland}/lib/qt-6/plugins"
    export QT_QPA_PLATFORM="wayland;xcb"

    ${pre-commit-install}
  '';
}
