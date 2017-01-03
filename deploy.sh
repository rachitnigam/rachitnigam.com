#!/bin/bash
# Command to deploy hakyll website

# Temporarily store uncommited changes
git stash

# Verify correct branch
git checkout hakyll

# If purify-css is installed as an exec, purify bootstrap.min.css
if hash purifycss; then
    echo "purify-css was found! purifying bootstrap.min.css"
    purifycss css/bootstrap.min.css templates/* --info --min --out \
              css/bootp.css
    rm css/bootstrap.min.css
    mv css/bootp.css css/bootstrap.min.css
fi

# Build new files
stack exec site clean
stack exec site build

# Reset to head in case purifycss ran
git reset --hard

# Get previous files
git fetch --all
git checkout -b master --track origin/master

# Overwrite existing files with new files
rsync -a --filter='P _site/'      \
      --filter='P _cache/'     \
      --filter='P .git/'       \
      --filter='P .gitignore'  \
      --filter='P .stack-work' \
      --delete-excluded        \
      _site/ .

# Commit
git add -A
git commit -m "Publish."

# Push
git push origin master:master

# Restoration
git checkout hakyll
git branch -D master
git stash pop
