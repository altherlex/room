require 'spec_helper'

describe Crawler do
  it "initialize crawler with default config" do
     expect(Crawler.new).to eq(true)
  end
end
