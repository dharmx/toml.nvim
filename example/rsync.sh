#!/usr/bin/env bash

sources=(
  ./example/config.toml
  ./example/lua/factory.lua
  ./example/lua/plugin.toml
)

destinations=(
  "$XDG_CONFIG_HOME"/nvim/config.toml
  "$XDG_CONFIG_HOME"/nvim/lua/factory.lua
  "$XDG_CONFIG_HOME"/nvim/lua/plugin.toml
)

if [[ ${#sources[@]} -eq ${#destinations[@]} ]]; then
  while read -r index; do
    echo "${sources[$index]} -> ${destinations[$index]}"
    rsync --verbose --update "${sources[$index]}" "${destinations[$index]}"
  done < <(seq 0 $((${#sources[@]} - 1)))
fi
