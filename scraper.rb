#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

ids = EveryPolitician::Wikidata.wdq('claim[39:18915989]')
ids.shuffle.each_slice(50) do |sliced|
  EveryPolitician::Wikidata.scrape_wikidata(ids: ids, output: false)
end
