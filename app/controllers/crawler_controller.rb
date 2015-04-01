class CrawlerController < ApplicationController
  def index
    @crawler = Crawler.new
  end
end
