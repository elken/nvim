# Neovim

<!--toc:start-->

- [Neovim](#neovim)
  - [Dependencies](#dependencies)
  - [Usage](#usage)

<!--toc:end-->

![preview](.github/assets/preview.png)

There are many like it; but this config is mine.

A modular setup based on [lazy.nvim](https://github.com/folke/lazy.nvim)'s
ability to load things "lazily" based on specific conditions, key invocations
or commands.

Due to how fast neovim is already, I've taken a Lazy approach, it
starts up in about 80 milliseconds and that's plenty good enough for me.

## Dependencies

Nothing concrete, I will in time add a healthcheck setup but for now just:

- `neovim` 0.9+
- `git`
- `ripgrep`
- `ranger`
- `gh`
- `xdg-mime`/`xdg-query` (Linux only)
- A C compiler
- `make`

Off the top of my head

## Usage

Clone to `$XDG_CONFIG_HOME/nvim` (usually `~/.config/nvim`) and open nvim. Lazy
will bootstrap everything plugin-wise and once it's done you're good to go!

This also has setup for both [Neovide](https://neovide.dev/) and regular
terminal; the former is where most of my "project" work happens. I use an XDG
desktop file like the below to set this up:

```conf
[Desktop Entry]
Name=Neovide
GenericName=Text Editor
Comment=Edit text files
Exec=env XCURSOR_THEME="Norzdy-cursors" zsh -c "/home/linuxbrew/.linuxbrew/bin/neovide  %F"
Type=Application
Keywords=Text;editor;
Icon=/home/lkn/Pictures/icons/neovide.png
Categories=Utility;TextEditor;
StartupNotify=true
StartupWMClass=neovide
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
```

The `XCURSOR_THEME` setup is needed to ensure that my cursor theme carries
over, then we launch via `zsh` to ensure that `$PATH` and the like are configured
correctly.

As for terminal, that'd be [wezterm](https://wezfurlong.org/wezterm/). Hard to
beat it, does everything I need.
