# update git submodules
submodules:
  git submodule sync --quiet --recursive
  git submodule update --init --recursive

# lint what is possible to lint
lint:
  yamllint .
