#!/bin/zsh
# Temporarily store uncommited changes
git stash

# Verify correct branch
git checkout frog

# If purify-css is installed as an exec, purify bootstrap.min.css
if hash purifycss; then
    echo -n "purify-css was found! Running ..."
    purifycss css/bootstrap.min.css ./*.html --info --min --out \
              css/bootp.css
    if [ $? -eq 0 ]; then
      echo "succeeded!"
      rm css/bootstrap.min.css
      mv css/bootp.css css/bootstrap.min.css
    else
      echo "failed!"
    fi
fi

# Reset to head in case purifycss ran
git reset --hard

# Push the changes to the remote server
rsync -a --filter='P .git/'       \
      --filter='P .gitignore'  \
      --delete-excluded        \
      _site/ website:~/public_html/

if [ "$?" -ne 0 ]; then
    echo "Failed to update the remote website server!"
fi

# Commit changes to master
git add -A
git commit -m "Publish."

# Push
git push origin master:master

# Restoration
git checkout frog
git branch -D master
git stash pop
