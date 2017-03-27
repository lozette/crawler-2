# Crawler

A basic web crawler in Ruby. Given a valid site url, this crawler will traverse links on the same domain (but not sub-domains) and print a json report of the site's urls and assets to stdout. It will ignore assets which are not from the same domain.

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
