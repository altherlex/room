require 'spec_helper'
require "rubygems"
require "open-uri"
require "nokogiri"

describe Crawler do
  before :all do 
    @crawler = Crawler.new
  end
  it "simple initialize" do
    #crawler = Crawler.new
    @crawler.should be_an_instance_of Crawler
  end
  it "#parametrize" do
    @crawler.parametrize_str.should be_an_instance_of String
  end
  it "#get_info(site_opened, arr_selectors)" do
    site_opened = open("https://rubygems.org/gems/nokogiri")
    site_opened.should be_an_instance_of Tempfile
    hash_info = Crawler.get_info(site_opened, [{selector:"#markup", attr_name:"desc"}])
    hash_info.should be_an_instance_of Array
    expect(hash_info).not_to be_empty
  end
  it "#get_info (check rubygems/nokogiri site and description for #markup)" do
    site_opened = open("https://rubygems.org/gems/nokogiri")
    hash_info = Crawler.get_info(site_opened, [{selector:"#markup", attr_name:"desc"}])
    #puts hash_info.first[:value].split(/(\r\n)+/).join.inspect
    hash_info.first[:value].split(/(\r\n)+/).join.should include(" is an HTML, XML, SAX, and Reader parser.")
  end
  context 'to many products' do
#1. goo.gl/LEKHth = www.americanas.com.br/produto/122393818/smartphone-motorola-novo-moto-x-desbloqueado-claro-android-4.4.4-kit-kat-tela-5-2-32gb-4g-camera-13mp-preto?chave=dp_celulares-e-telefones_dt1
#2. goo.gl/TwfgFJ = www.ricardoeletro.com.br/Produto/Projetor-Multimidia-Epson-Powerlite-S18-Resolucao-SVGA-1400x1050-3000-Lumens-HDMI/4523-4526-4744-382461
#3. goo.gl/r18Pu6 = http://www.pontofrio.com.br/livros/LiteraturaInfantojuvenil/Juvenil/Livro-Diario-de-um-Banana-Caindo-na-Estrada-Volume-9-Jeff-Kinney-4445410.html?recsource=home-484_5-2-2_9_28531-2&rectype=15290-int
    before :all do
      @PARAM = {links: 
	[
	  {link: "http://goo.gl/LEKHth", selectors: [{selector:".mp-pb-item.mp-pb-to.mp-price", attr_name:"smartphone-motorola-novo-moto-x-desbloqueado"}] },
	  {link: "http://goo.gl/TwfgFJ", selectors: [{selector:"#ProdutoDetalhesPrecoComprarAgoraPrecoDePreco", attr_name:"Projetor-Multimidia-Epson-Powerlite-S18-Resolucao-SVGA-1400x1050-3000-Lumens-HDMI"}] },
	  {link: "http://goo.gl/r18Pu6", selectors: [{selector:"#fsl", attr_name:"Livro-Diario-de-um-Banana-Caindo-na-Estrada"}] },
  	  {link: "http://www.submarino.com.br/produto/122072993/livro-star-wars-kenobi", selectors: [{selector:".mp-pb-item.mp-pb-to.mp-price", attr_name:"livro-star-wars-kenobi"}] }
       ]
     }
    end # before end
    it "#sweep_links (geting 4 products)" do
      Crawler.sweep_links(@PARAM).map{|i| i[:selectors]}.flatten.map{|i| i[:value]}.should have(2).item
    end
  end # context end
end
