# serve the website
serve:
  zola serve

# build the website
build:
  zola build

# update the copy of the website on csail servers
sync-csail: build
  rsync -zvhr --delete public/ csail:public_html
