#!/bin/bash

cd ~


brew update 
brew install erlang
brew install gleam

# Install rebar3
git clone https://github.com/erlang/rebar3.git
cd rebar3
./bootstrap
./rebar3 local install

cd ~

# Install stack and GHCup
curl -sSL https://get.haskellstack.org/ | sh
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
