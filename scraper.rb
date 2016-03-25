#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

ids = EveryPolitician::Wikidata.wdq('claim[39:18915989]')
EveryPolitician::Wikidata.scrape_wikidata(ids: ids, batch_size: 100, output: false)
