### Personal wesite

To build the website:

1. Checkout `hakyll` after cloning the repo.

2. Run `stack build` to build the website.

3. Run `purifycss css/bootstrap.min.css templates/default.html --out css/boot-purified.css`. This step requires [purify-css](https://github.com/purifycss/purifycss) to be installed.

4. Run `stack exec site watch` and go to `localhost:8000` to view the website.
