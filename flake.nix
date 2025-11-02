{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      # Disable nix-darwin's Nix management (Determinate handles it)
      nix.enable = false;

      # Set primary user (required for user-specific options)
      system.primaryUser = "joshuamcnabb";

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
        kubectl
        # Add more tools as needed
      ];

      # macOS System Preferences
      system.defaults = {
        # Dock settings
        dock.autohide = true;
        dock.orientation = "bottom";
        dock.tilesize = 64;
        dock.magnification = true;
        dock."minimize-to-application" = true;
        
        # Finder settings
        finder.FXPreferredViewStyle = "Nlsv";  # List view (Nlsv = List, clmv = Column, Flwv = Flow)
        
        # Trackpad settings
        trackpad.Clicking = true;
        trackpad.TrackpadThreeFingerDrag = true;
        
        # Global domain settings (NSGlobalDomain)
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain.InitialKeyRepeat = 25;
        NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
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

      # Ensure Nix packages are in PATH for use in .zshrc
      environment.pathsToLink = [ "/share/zsh" ];

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
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        ({ pkgs, lib, ... }: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.joshuamcnabb = {
            home.homeDirectory = lib.mkForce "/Users/joshuamcnabb";
            home.stateVersion = "25.05";
            
            # Zsh configuration
            programs.zsh.enable = false;
            
            # WezTerm configuration
            home.file.".wezterm.lua".source = ./configs/.wezterm.lua;
            
            # Zsh configuration
            home.file.".zshrc".source = ./configs/.zshrc;
            
            # Cursor configuration
            home.file."Library/Application Support/Cursor/User/cursor.code-profile".source = ./configs/cursor.code-profile;
            home.file."Library/Application Support/Cursor/User/settings.json".source = ./configs/cursor-settings.json;
            home.file."Library/Application Support/Cursor/User/keybindings.json".source = ./configs/cursor-keybindings.json;
          };
        })
      ];
    };
  };
}
