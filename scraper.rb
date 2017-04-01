#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

# Position Held = Member of the Hellenic Parliament
member = EveryPolitician::Wikidata.sparql('SELECT ?item WHERE { ?item wdt:P39 wd:Q18915989 . }')

# has Property: "Member of the Hellenic Parliament ID"
withId = EveryPolitician::Wikidata.sparql('SELECT ?item WHERE { ?item wdt:P2278 ?dummy0 . }')

EveryPolitician::Wikidata.scrape_wikidata(ids: member | withId)
