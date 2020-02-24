#!/bin/bash

set -euf -o pipefail

current_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
deploy_branch="master"
website=""

if [[ "$current_branch" != "$deploy_branch" ]]; then
  echo "Error: Must deploy from branch \"$deploy_branch\"."
  exit 1
fi

echo "Saving unsaved changes..."
git stash

# Build the website.
hugo49.2

# If purify-css is installed as an exec, purify bootstrap.min.css
which purifycss > /dev/null
if [ $? -eq 0 ]; then
    echo -n "purifycss was found! Running ..."

    CSS_FILE="./public/styles.css"
    find public/ -name "*html" -type f | \
      xargs purifycss "$CSS_FILE" --info --min --out "$CSS_FILE"

    BOOTSTRAP_CSS="./public/css/bootstrap.min.css"
    find public/ -name "*html" -type f | \
      xargs purifycss "$BOOTSTRAP_CSS" --info --min --out "$BOOTSTRAP_CSS"

  else
    echo "purifycss was not found!"
fi

# Move public/ to docs/ for github pages deployment.
cp CNAME public/

git stash pop

cd public/
git add -A
git commit -m 'update'
git push
