#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

member = EveryPolitician::Wikidata.wdq('claim[39:18915989]')
withId = EveryPolitician::Wikidata.wdq('claim[2278]')
EveryPolitician::Wikidata.scrape_wikidata(ids: member | withId, batch_size: 100, output: false)
