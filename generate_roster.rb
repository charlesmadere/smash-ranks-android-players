#!/usr/bin/ruby

require "json"
require_relative "smash_competitor.rb"

PROPER_SPLITS_LENGTH = 13
readFirstLine = false
smashCompetitors = Array.new

File.open("GAR PR Player Roster.csv").each_with_index do |line, index|
	if readFirstLine
		splits = line.split(",")
		smashCompetitor = nil

		if splits.length == PROPER_SPLITS_LENGTH
			smashCompetitor = SmashCompetitor.new(splits)
		end

		if smashCompetitor != nil && smashCompetitor.is_valid
			smashCompetitors.push(smashCompetitor)
		else
			puts "Smash Competitor at line #{index} has some data error(s)"
		end
	else
		readFirstLine = true
	end
end

smashCompetitorsHash = Hash.new

smashCompetitors.each do |smashCompetitor|
	smashCompetitorsHash[smashCompetitor.id] = smashCompetitor.to_json
end

# Convert smashCompetitorsHash to JSON
# Write the JSON out to a local file

puts "wrote out #{smashCompetitorsHash.length} player(s)"
