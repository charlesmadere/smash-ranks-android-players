#!/usr/bin/ruby

PROPER_SPLITS_LENGTH = 13
readFirstLine = false
smashCompetitors = Array.new

File.open("GAR PR Player Roster.csv").each_with_index do |line, index|
	if readFirstLine
		splits = line.split(',')
		smashCompetitor = nil

		if splits.length == PROPER_SPLITS_LENGTH
			smashCompetitor = SmashCompetitor.initialize(splits)
		end

		if smashCompetitor == nil
			puts "Smash Competitor at line #{index} has some data error(s)"
		else
			smashCompetitors.push(smashCompetitor)
		end

		# Attempt to read a line into a SmashCompetitor object
		# If nil is returned, then we know that this SmashCompetitor object is invalid (it's
		# missing some necessary fields / properties)
		# If nil is not returned, add this SmashCompetitor to the players array
	else
		readFirstLine = true
	end
end

# Write out the smashCompetitors as JSON into a simple text file

puts "wrote out #{smashCompetitors.length} player(s)"
