#!/usr/bin/env bash

distDocDir=$(cd $(dirname "$0"); pwd)
originalPath=$(dirname "${distDocDir}")
cd "${originalPath}"

# brew unlink php
# brew link php@7.4

# rm -rf vendor node_modules

mv '__Did_you_run_composer_update.txt' spec/tempfile
composer update --with-all-dependencies
pnpm install --frozen-lockfile
mv spec/tempfile '__Did_you_run_composer_update.txt'

cd spec/run
pnpm install --frozen-lockfile

cd ../run_v8
pnpm install --frozen-lockfile

cd ../run-safari
pnpm install --frozen-lockfile

# brew unlink php@7.4
# brew link php
