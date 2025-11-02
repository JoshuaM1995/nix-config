# MacOS Configuration

## Installing Nix Package Manager

1. Install the **Determinate** Nix using the installer: https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer

## Using Nix Darwin to Apply the Configuration

### First Time

```bash
sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch
```

### Afterwards

```bash
sudo darwin-rebuild switch
```

### Updating Managed Apps/Packages

```bash
nix flake update
sudo darwin-rebuild switch
```

## Setting Up Cursor

Import the `cursor.code-profile` file in Cursor by going to **Settings** -> **Profiles** -> **New Profile (Import)** and selecting the file.
