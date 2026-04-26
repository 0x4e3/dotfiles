# update git submodules
submodules:
  git submodule sync --quiet --recursive
  git submodule update --init --recursive

# lint what is possible to lint
lint:
  yamllint .

# dump brew installed packages to Brewfile
dump-bundle:
  brew bundle dump --formula --cask --tap --mas --vscode --force --describe --file Brewfile
