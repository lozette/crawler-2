# Crawler

Requirements:

```
Given a starting URL, it should visit every reachable page under that domain, and should not cross subdomains. For example when crawling “www.google.com” it would not crawl “mail.google.com”.
For each page, it should determine the URLs of every static asset (images, javascript, stylesheets) on that page.
The crawler should output to STDOUT in JSON format listing the URLs of every static asset, grouped by page.
```

A basic web crawler in Ruby. Given a valid site url, this crawler will traverse links on the same domain (but not sub-domains) and print a json report of the site's urls and assets to stdout. It tries to ignore assets which are not from the same domain.

## Installation

Install Ruby any way you wish. See `.ruby-version` for the supported Ruby version (2.3.3)

Then install bundler:

```
gem install bundler
```

Install the project dependencies:
```
bundle install
```

To run the crawler on livestax.com:

```
./bin/crawler http://www.livestax.com
```

To run the tests:

```
bundle exec rspec
```

### Concerns

0. On very large sites the script takes a long time to return anything but does not provide any feedback to assure the user that it's actually doing something.
0. A shallow/deep option would be good; or a way of specifying the depth of links the script should traverse.
0. External assets specified with a leading `//` (to indicate they can be loaded as http or https) are reported as being "local" assets even though they may not be. (See output from `./bin/crawler http://www.lauralifts.com` for an example.)
