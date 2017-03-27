require 'HTTParty'
require 'Nokogiri'
require 'uri'

class Crawler
  def crawl(url)
    if url && !url.empty?
      @output = []
      @url = url
      page = fetch_and_parse_page(url)
      if page && page.xpath("//a|//link|//script")
        crawl_page(page, url)
        puts @output.to_json
      end
    else
      abort("Please provide a valid url, e.g. `./bin/crawler http://www.livestax.com`")
    end
  end

  private

  def fetch_and_parse_page(url)
    begin
      page = HTTParty.get(url)
    rescue SocketError, HTTParty::Error => e
      abort("Something went wrong, please check the url you provided\n#{e}")
    else
      Nokogiri::HTML(page)
    end
  end

  def crawl_page(page, url)
    return if already_crawled(url)
    assets = page.xpath("//script/@src|//link/@href|//img/@src")
    page_info = { "url" => url }
    if assets
      page_info.merge!(
        { "assets" => assets.map{ |asset| asset.to_s if same_domain(asset.to_s) }.compact }
      )
    end
    @output << page_info

    links = page.xpath("//a/@href")
    crawl_sub_links(links) if links
  end

  def crawl_sub_links(links)
    links.each do |link|
      sub_url = link.to_s
      # Trim any trailing slashes off the url before appending relative url paths
      sub_url = "#{@url.gsub(/\/$/, '')}#{sub_url}" if sub_url.start_with?('/')
      if same_domain(sub_url) && !already_crawled(sub_url)
        page = fetch_and_parse_page(sub_url)
        crawl_page(page, sub_url)
      end
    end
  end

  def same_domain(link)
    link.start_with?('/') || link.start_with?(@url)
  end

  def already_crawled(link)
    @output.any? {|hsh| hsh["url"] == link }
  end

end
