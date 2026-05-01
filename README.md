Dotfiles
===

# Setup

## 1. Clone the repo

```sh
git clone git@github.com:NickTomlin/dotfiles.git ~/workspace/dotfiles
```

## 2. Install GNU Stow

**Linux (Arch/CachyOS):**
```sh
sudo pacman -S stow
```

**macOS:**
```sh
brew install stow
```

## 3. Link dotfiles

```sh
stow --dir=~/workspace/dotfiles --target=$HOME home
```

Stow creates symlinks in `$HOME` pointing back into the repo. Any conflict (file already exists and isn't a symlink) will be reported — resolve by updating the repo file to match your machine, then re-run.

## 4. Create a machine-local override file

Create `~/.config/shell/local.zsh` for anything machine-specific (not committed):

```zsh
# Example: tool inits that vary per machine
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"
source "$HOME/.cargo/env"
```

## 5. Install core tools

**Shell:**
- [Zim](https://zimfw.sh/docs/install/) — zsh framework (run `zimfw install` after first login)
- `bat`, `fzf`, `zoxide`, `fnm`, `eza` — quality-of-life CLI tools

**macOS only:**
```sh
brew install bat fzf zoxide fnm neovim eza
```

**Linux:**
```sh
# via pacman, cargo, or your preferred method
sudo pacman -S bat fzf neovim eza
cargo install zoxide
```

## Structure

```
home/               # mirrors $HOME — everything here gets symlinked by stow
  .zshrc            # zsh entry point (Zim framework)
  .zimrc            # Zim module list
  .zsh_aliases      # shared aliases
  .gitconfig        # git config (includes ~/.gitconfig.local for machine overrides)
  .tmux.conf        # tmux config
  .config/
    shell/
      prompt.zsh    # minimal two-line prompt (no p10k)
      macos.zsh     # macOS-specific config (Homebrew, pbcopy, etc.)
      linux.zsh     # Linux-specific config (xclip, JetBrains path, etc.)
      local.zsh     # machine-local overrides (gitignored — create per machine)
    ghostty/        # Ghostty terminal config + Catppuccin themes
    bat/            # bat (cat replacement) config + Catppuccin themes
    nvim/           # neovim config
```

## Auditing

Once Stow is set up, every dotfile is a symlink into the repo. Auditing is just:

```sh
git -C ~/workspace/dotfiles status
git -C ~/workspace/dotfiles diff
```
