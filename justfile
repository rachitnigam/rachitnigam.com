zola-version := `cat .zola-version`

# assert the installed zola matches the pinned version in .zola-version
check-zola:
  #!/usr/bin/env bash
  set -eu -o pipefail
  installed="$(zola --version | cut -d ' ' -f 2)"
  if [ "$installed" != "{{zola-version}}" ]; then
    echo "error: zola {{zola-version}} is pinned in .zola-version but zola $installed is installed" >&2
    echo "install the pinned version, or update .zola-version if the bump is intentional" >&2
    exit 1
  fi

# serve the website
serve: check-zola
  zola serve

# build the website
build: check-zola
  zola build

# update the copy of the website on csail servers
sync-csail: build
  rsync -zvhraP --delete public/ csail:public_html
