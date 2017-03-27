require_relative './crawler'

class CliWrapper
  def initialize
    @crawler = Crawler.new
  end

  def crawl(url)
    @crawler.crawl(url)
  end
end
