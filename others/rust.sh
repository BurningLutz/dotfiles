#!/bin/bash

if [ $? -eq 0 ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
