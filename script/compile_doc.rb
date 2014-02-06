#!/usr/bin/env ruby
require 'nokogiri'
require 'redcarpet'


def preformatted_html
  file = ARGV.first
  RedcarpetCompat.new(File.read(file), :fenced_code_blocks, :disable_indented_code_blocks).to_html
end

def doc
  @doc ||= Nokogiri::HTML::fragment(preformatted_html)
end

doc.css("pre").wrap("<div class='help-callout'></div>")
doc.css("h1").remove
puts doc.to_html
