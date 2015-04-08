class Crawler < ActiveRecord::Base
  METHODS_VALIDS = [:at_css, :css, :xpath, :at_xpath]
  PARAMETRIZE_PATTERN = {links: [{
            link: "http://www2.sabesp.com.br/mananciais/DivulgacaoSiteSabesp.aspx",
            selectors: [{selector:".guardaImgBgDetalhe", attr_name:"index_cantareira_water", method: :at_css}],
            send_emails: [{email:"your-email@your-domain.com", at:"9am", every:"1.day"}]
          }]
        }
  belongs_to :user
  serialize :configuration, Hash
  attr_accessor :parametrize

  def initialize(attributes = {})
    super(attributes)
    self.configuration = PARAMETRIZE_PATTERN if self.configuration.empty?
  end
  #after_find do |record|
  #  record.parametrize = PARAMETRIZE_PATTERN
  #end
  def parametrize #alias
    self.configuration
  end
  def indentation_parametrize
    #JSON.pretty_generate self.parametrize
    ap(self.parametrize)
  end
#  def condiguration=(value)
#    @configuration = clean_parameters(value)
#  end
  def sweep_links
    result = Crawler.sweep_links(self.configuration)
    self.configuration[:links] = result #.with_indifferent_access
    self.configuration
  end
  alias_method :load!, :sweep_links

  def show
    result = self.configuration[:links].map{|i| i['selectors']}.flatten.inject([]){|ac, i| ac<<[i[:attr_name], i[:value]]}
    load! if result.map{|i| i.first}.compact.empty?
    result = self.configuration[:links].map{|i| i['selectors']}.flatten.inject([]){|ac, i| ac<<[i[:attr_name], i[:value]]}
  end
  class << self
    # Split trash code (\n, \t)
    def clean_parameters(value)
      (value||"").split(/[\r\n\t]+/).join(' ')
    end
    def access(link)
      open(link)
    end
    def get_info(site, arr_selectors)
      document = Nokogiri::HTML(site)
      arr_selectors.inject([]){|ac, selector| 
        meth = :css
        meth = selector[:method].to_sym if selector[:method].present? and METHODS_VALIDS.include?(selector[:method].to_sym)
        ac << selector.merge({value: clean_parameters(document.send(meth, selector[:selector]).try(:text)) })
        ac
      }
    end
    def sweep_links(param)
      param = param.with_indifferent_access
      param[:links].each do |config|
        site = Crawler.access(config[:link])
        config[:selectors] = Crawler.get_info(site, config[:selectors])
      end
    end
  end
  before_update do |record|
    #TODO Doesn't permit configuration invalid and inject code
#    record.configuration =  YAML.load(record.configuration).try(:with_indifferent_access) if record.configuration.is_a? String
    record.configuration = eval(record.configuration) if record.configuration.is_a? String
  end
  #before_create do |record|
  #  record.configuration ||= @parametrize
  #end
end
