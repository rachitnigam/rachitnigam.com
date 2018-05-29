#!/bin/zsh

set -e

current_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
deploy_branch="hugo"
website="website:~/public_html/"

if [[ "$current_branch" != "$deploy_branch" ]]; then
  echo "Error: Must deploy from branch $deploy_branch."
  exit 1
fi

hugo


# If purify-css is installed as an exec, purify bootstrap.min.css
if hash purifycss; then
    CSS_FILE="./public/styles.css"
    TEMP_FILE="./public/temp.css"

    echo -n "purifycss was found! Running ..."
    find public/ -name "*html" -type f | \
      xargs purifycss "$CSS_FILE" --info --min --out "$TEMP_FILE"

    if [ $? -eq 0 ]; then
      echo "succeeded!"
      rm "$CSS_FILE"
      mv "$TEMP_FILE" "$CSS_FILE"
    else
      echo "failed!"
    fi
fi

# Push the changes to the remote server
rsync -a --delete-excluded public/ "$website"

if [ "$?" -ne 0 ]; then
    echo "Failed to update the remote website server!"
fi
