#!/usr/bin/ruby

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

# Write out the smashCompetitors as JSON into a simple text file

puts "wrote out #{smashCompetitors.length} player(s)"
