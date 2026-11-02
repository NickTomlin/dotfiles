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

Stow creates symlinks in `$HOME` pointing back into the repo. If a target is already managed by a different symlink, Stow reports a conflict; check that link before replacing it.

## 4. Create a machine-local override file

Create `~/.config/shell/local.zsh` for machine-specific overrides (not committed). Shared tool initialization already lives in the OS-specific shell files; don't repeat it here.

## 5. Install core tools

**Shell:**
- [Zim](https://zimfw.sh/docs/install/) — zsh framework (run `zimfw install` after first login)
- `bat`, `fzf`, `zoxide`, `fnm`, `eza` — quality-of-life CLI tools
- `tree-sitter-cli` (>= 0.26.1) and a C compiler — Neovim parser installation (`npm install -g tree-sitter-cli`)

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
    nvim/           # Neovim config
```

## Pi Herdr fork

Stow installs `home/.pi/agent/extensions/herdr-fork.ts` with the other dotfiles. It adds `/herdr-fork` and `/hf` to Pi.

Restart Pi, then use `/hf [v|vertical|h|horizontal|t|tab] [instructions]`. The default is a focused right-hand pane; `h` opens below and `t` opens a new tab. Instructions are submitted immediately to the new Pi; omitting them leaves it idle. A fork copies the last completed conversation point into a new session and leaves the original Pi session running. Both panes use the same working directory.

## Auditing

Stow links files or whole directories into `$HOME`. Auditing the repo is just:

```sh
git -C ~/workspace/dotfiles status
git -C ~/workspace/dotfiles diff
```
