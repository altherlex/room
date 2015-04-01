class Crawler < ActiveRecord::Base
  PARAMETRIZE_PATTERN = {links: [{
            link: "https://www.google.com",
            selectors: [{selector:"#fsl", attr_name:"op_foot"}],
            send_emails: [{email:"your-email@your-domain.com", at:"12pm", every:"1.day"}]
          }]
        }
 # serialize :config
  attr_accessor :parametrize

  #def initialize
  def initialize(attributes = {})
    @parametrize = PARAMETRIZE_PATTERN
    super(attributes)
  end
  def parametrize_str
     @parametrize.inspect
  end
  def self.access(link)
    open(link)
  end
  def self.get_info(site, arr_selectors)
    document = Nokogiri::HTML(site)
    arr_selectors.inject([]){|ac, selector| 
      ac << selector.merge({value: document.css(selector[:selector]).text })
      ac
    }
  end
  def self.sweep_links(param)
    param[:links].each do |config|
      site = Crawler.access(config[:link])
      config[:selectors] = Crawler.get_info(site, config[:selectors])
    end
  end
  def sweep_links
    Crawler.sweep_links(@parametrize)
  end
end
