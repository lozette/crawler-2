require 'spec_helper'
require_relative '../lib/crawler'

RSpec.describe Crawler do
  let(:crawler) { described_class.new }

  context "With a valid url" do
    let(:url) { 'http://www.livestax.com/' }
    let(:response) { File.open('spec/livestax.html').read }
    let(:expected) {
      [
        {
          "url":"http://www.livestax.com/",
          "assets": [
            "/assets/stylesheets/style-bb7c40da5a.min.css",
            "//assets/images/touch/apple-touch-icon-144-precomposed.png",
            "/favicon.ico",
            "/assets/images/logo.png",
            "/assets/images/liberate.svg",
            "/assets/images/data.svg",
            "/assets/images/icon-philosophy.svg",
            "/assets/images/icon-bespoke.svg",
            "/assets/images/icon-design-develop.svg",
            "/assets/images/interface.jpg",
            "/assets/images/logo.png",
            "/assets/javascript/index-65eecce907.min.js"
          ]
        }
      ].to_json
    }

    before do
      stub_request(:get, "http://www.livestax.com/").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => response, :headers => {})
    end

    it "Parses a page and returns the expected json output" do
      expect { crawler.crawl(url) }.to output(a_string_including(expected)).to_stdout
    end
  end

  context "With an invalid url" do
    let(:url) { '' }

    it "Throws a friendly error" do
      expect { crawler.crawl(url) }
        .to output("Please provide a valid url, e.g. `./bin/crawler http://www.livestax.com`\n").to_stdout
    end
  end

end
