#!/bin/env ruby
# encoding: utf-8

require 'colorize'
require 'nokogiri'
require 'pry'
require 'scraperwiki'
require 'wikidata/fetcher'

require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'

def ids_from_claim(claim_str)
  url = "https://wdq.wmflabs.org/api?q=claim[#{claim_str}]"
  json = JSON.parse(open(url).read, symbolize_names: true)
  json[:items].map { |id| "Q#{id}" }
end

ids_from_claim('39:18915989').each do |id|
  data = WikiData::Fetcher.new(id: id).data or next
  ScraperWiki.save_sqlite([:id], data)
end

require 'rest-client'
warn RestClient.post ENV['MORPH_REBUILDER_URL'], {} if ENV['MORPH_REBUILDER_URL']
