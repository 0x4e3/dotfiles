# lebedev's dotfiles

Inspired by:
* Nikita Sobolev's [dotfiles](https://github.com/sobolevn/dotfiles)
* Sheharyar Naseer's [dotfiles](https://github.com/sheharyarn/dotfiles/)
* [Instant +100% command line productivity boost](https://dev.to/sobolevn/instant-100-command-line-productivity-boost)
* [Using better CLIs](https://dev.to/sobolevn/using-better-clis-6o8)

# Content

What do we have here:

* `brew` dependencies: cli & gui applications, fonts, etc. See [`Brewfile`](./Brewfile) for details
* tools for `python` development
* shell configuration. See [`config`](./config/) for details

## Brewfile

There's a lot of stuff there, so to not to forget something, here is the list of some highlights:

* [`tig`](https://github.com/jonas/tig) - text based ui for git history (read [this](https://habr.com/ru/articles/337644/) or [that](https://jonas.github.io/tig/) to know more)
* [`k9s`](https://k9scli.io) - "Kubernetes CLI To Manage Your Clusters In Style"(c): yet another text based ui, now for kubernetes cluster management
* [`neovim`](https://neovim.io) - vim based text editor
* [`glances`](https://github.com/nicolargo/glances) - console system monitor like `top` and `htop` but with reach set of plugins; [`bashtop`](https://github.com/aristocratos/bashtop) can be a good alternative
* [`httpie`](https://httpie.io/docs/cli/main-features) - `curl` and `wget` replacements with more simple cli and syntax highlighting
* [`thefuck`](https://github.com/nvbn/thefuck) - don't let you to give a single fuck
* [`exa`](https://github.com/ogham/exa) - a modern replacement for the venerable file-listing command-line tool `ls`
* [`fzf`](https://github.com/junegunn/fzf) - command line fuzzy finder
* [`bat`](https://github.com/sharkdp/bat) - `cat` clone with the wings: alternative to the `cat` with syntax highlighting and git integration

## Python

* [`pyenv`](https://github.com/pyenv/pyenv) - `Python` version manager
* [`poetry`](https://python-poetry.org/docs/) - a tool for dependency management and packaging in `Python`

## Shell

* `zsh`
* [`oh-my-zsh`](http://ohmyz.sh/) - an open source, community-driven framework for managing zsh configuration
* [`starship`](https://starship.rs/) - "The minimal, blazing-fast, and infinitely customizable prompt for any shell"(c)

# Getting started

### 1. Install Xcode developer tools

```bash
xcode-select --install

# Set HostName
sudo scutil --set HostName adBook
```

### 2. Clone dotfiles

```bash
git clone https://github.com/0x4e3/dotfiles.git ~/.dotfiles
```

### 3. Run bootstrap script

```bash
cd ~/.dotfiles && bash bootstrap.sh
```

# License

[WTFPL](./LICENSE): do the fuck you want. Enjoy!
