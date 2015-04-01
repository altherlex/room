#!/usr/bin/env ruby

require "rubygems"
require "open-uri"
require "nokogiri"

gem = ARGV[0]
site = open("https://rubygems.org/gems/#{gem}")
document = Nokogiri::HTML(site)
#version = document.css(".title h3").text
version = document.css("#markup").text

puts "#{gem} version #{version}"
