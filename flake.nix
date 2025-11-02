{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # Disable nix-darwin's Nix management (Determinate handles it)
      nix.enable = false;

      # CLI tools installed via Nix
      # Note: Flakes are enabled by default in Determinate, no need to set experimental-features
      environment.systemPackages = with pkgs; [
        # Editors & tools
        bat
        eza
        fd
        fzf
        
        # Git tools
        git
        git-lfs
        gh
        
        # Shell enhancements
        starship
        atuin
        zoxide
        direnv
        
        # System utilities
        wget
        
        # Development tools
        nodejs
        kubernetes-cli
        # Add more tools as needed
      ];

      # macOS System Preferences
      system.defaults = {
        # Dock settings
        dock.autohide = true;
        dock.orientation = "bottom";
        
        # Trackpad settings
        trackpad.Clicking = true;
        
        NSGlobalDomain.KeyRepeat = 2;
        # NSGlobalDomain.InitialKeyRepeat = 15;  # Uncomment and adjust if needed
      };

      # Homebrew integration for GUI apps
      homebrew = {
        enable = true;
        casks = [
          "alacritty"
          "bitwarden"
          "ghostty"
          "wezterm"
        ];
        # Optional: clean up apps not in the list
        # onActivation = {
        #   cleanup = "zap";  # Remove apps not listed above
        # };
      };

      # Shell configuration
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Joshuas-MacBook-Pro
    darwinConfigurations."Joshuas-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
