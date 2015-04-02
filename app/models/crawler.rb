class Crawler < ActiveRecord::Base
  METHODS_VALIDS = [:at_css, :css, :xpath, :at_xpath]
  PARAMETRIZE_PATTERN = {links: [{
            link: "http://www2.sabesp.com.br/mananciais/DivulgacaoSiteSabesp.aspx",
            selectors: [{selector:".guardaImgBgDetalhe", attr_name:"index_cantareira_water", method: :at_css}],
            send_emails: [{email:"your-email@your-domain.com", at:"9am", every:"1.day"}]
          }]
        }
  serialize :configuration
  attr_accessor :parametrize

  def initialize(attributes = {})
    super(attributes)
    self.configuration ||= PARAMETRIZE_PATTERN
  end
  #after_find do |record|
  #  record.parametrize = PARAMETRIZE_PATTERN
  #end
  def parametrize #alias
    self.configuration
  end
  def indentation_parametrize
    JSON.pretty_generate self.parametrize
  end
  def sweep_links
    Crawler.sweep_links(@parametrize)
  end
  class << self
    def access(link)
      open(link)
    end
    def get_info(site, arr_selectors)
      document = Nokogiri::HTML(site)
      arr_selectors.inject([]){|ac, selector| 
        meth = :css
        meth = selector[:method].to_sym if selector[:method].present? and METHODS_VALIDS.include?(selector[:method].to_sym)
        ac << selector.merge({value: document.send(meth, selector[:selector]).try(:text) })
        ac
      }
    end
    def sweep_links(param)
      param[:links].each do |config|
        site = Crawler.access(config[:link])
        config[:selectors] = Crawler.get_info(site, config[:selectors])
      end
    end
  end
  before_update do |record|
    record.configuration = eval(record.configuration) if record.configuration.is_a? String
  end
  #before_create do |record|
  #  record.configuration ||= @parametrize
  #end
end
