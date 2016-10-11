#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

WIKIDATA_SPARQL_URL = 'https://query.wikidata.org/sparql'

def wikidata_sparql(query)
  result = RestClient.get WIKIDATA_SPARQL_URL, params: { query: query, format: 'json' }
  json = JSON.parse(result, symbolize_names: true)
  json[:results][:bindings].map { |res| res[:item][:value].split('/').last }
rescue RestClient::Exception => e
  abort "Wikidata query #{query.inspect} failed: #{e.message}"
end

# Position Held = Member of the Hellenic Parliament
member = wikidata_sparql('SELECT ?item WHERE { ?item wdt:P39 wd:Q18915989 . }')

# has Property: "Member of the Hellenic Parliament ID"
withId = wikidata_sparql('SELECT ?item WHERE { ?item wdt:P2278 ?dummy0 . }')

EveryPolitician::Wikidata.scrape_wikidata(ids: member | withId)
