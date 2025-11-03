{
  description = "Joshua McNabb's MacOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      # Disable nix-darwin's Nix management (Determinate handles it)
      nix.enable = false;

      # Set primary user (required for user-specific options)
      system.primaryUser = "joshuamcnabb";

      # CLI tools installed via Nix
      # Note: Flakes are enabled by default in Determinate, no need to set experimental-features
      environment.systemPackages = with pkgs; [
        # Build-in packages
        pkgs.mkalias
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
        pnpm
      ];

      # macOS System Preferences
      system.defaults = {
        # Dock settings
        dock.autohide = true;
        dock.orientation = "bottom";
        dock.tilesize = 64;
        dock.largesize = 110;
        dock.magnification = true;
        dock.minimize-to-application = true;
        dock.mineffect = "genie";
        dock.show-recents = false;
        dock.mru-spaces = false;
        
        # Finder settings
        finder.FXPreferredViewStyle = "clmv";  # List view (Nlsv = List, clmv = Column, Flwv = Flow)
        
        # Trackpad settings
        trackpad.Clicking = true;
        trackpad.TrackpadThreeFingerDrag = true;
        
        # Global domain settings (NSGlobalDomain)
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain.InitialKeyRepeat = 25;
        NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
        NSGlobalDomain.AppleInterfaceStyle = "Dark";

        # Menu Settings
        menuExtraClock.ShowSeconds = true;

        # Spaces settings
        spaces.spans-displays = false;
      };

      # Startup settings
      system.startup = {
        chime = false;
      };

      # Homebrew integration for GUI apps
      homebrew = {
        enable = true;
        casks = [
          "bitwarden"
          "wezterm"
          "rectangle"
          "ghostty"
          "cursor"
          "brave-browser"
          "docker-desktop"
          "spotify"
          "tableplus"
          "obsidian"
          "cleanshot"
          "quit-all"
          "yaak"
        ];
        masApps = {
          "ColorSlurp" = 1287239339;
        };
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          # cleanup = "zap"; # This removes the apps not in the list
        };
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

      # Fix .zshrc permissions (should be 644, not 755)
      system.activationScripts.fixZshrcPermissions.text = ''
        echo "fixing .zshrc permissions..." >&2
        chmod 644 /Users/joshuamcnabb/.zshrc 2>/dev/null || true
      '';

      # Rebuild bat cache to ensure themes are loaded
      system.activationScripts.rebuildBatCache.text = ''
        echo "rebuilding bat cache..." >&2
        ${pkgs.bat}/bin/bat cache --build 2>/dev/null || true
      '';

      # Fix issue with Applications not showing up in MacOS Spotlight
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';
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
            home.file.".wezterm.lua".source = ./configs/wezterm/.wezterm.lua;
            
            # Zsh configuration
            home.file.".zshrc".source = ./configs/zsh/.zshrc;
            
            # Starship configuration
            home.file.".config/starship.toml".source = ./configs/starship/starship.toml;
            
            # Cursor configuration
            home.file."Library/Application Support/Cursor/User/settings.json".source = ./configs/cursor/cursor-settings.json;
            home.file."Library/Application Support/Cursor/User/keybindings.json".source = ./configs/cursor/cursor-keybindings.json;
            home.file.".cursor/mcp.json".source = ./configs/cursor/cursor-mcp.json;

            # Bat configuration
            home.file.".config/bat/config".source = ./configs/bat/config;
            home.file.".config/bat/Catppuccin Mocha.tmTheme".source = ./. + "/configs/bat/themes/Catppuccin Mocha.tmTheme";
            home.file.".config/bat/themes" = {
              source = ./configs/bat/themes;
              recursive = true;
            };

            # Git configuration
            home.file.".config/git/ignore".source = ./configs/git/ignore;

            # GitHub CLI configuration
            home.file.".config/gh/config.yml".source = ./configs/gh/config.yml;
            home.file.".config/gh/hosts.yml".source = ./configs/gh/hosts.yml;

            # Ghostty configuration
            home.file.".config/ghostty/config".source = ./configs/ghostty/config;
            home.file.".config/ghostty/themes" = {
              source = ./configs/ghostty/themes;
              recursive = true;
            };
          };
        })
      ];
    };
  };
}
