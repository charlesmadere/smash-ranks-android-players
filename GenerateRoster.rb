#!/usr/bin/ruby

readFirstLine = false
players = Array.new

File.open("GAR PR Player Roster.csv").each do |line|
	if readFirstLine
		# Attempt to read a line into a Player object
		# If null is returned, then we know that this Player object is invalid (it's missing
		# some necessary fields / properties)
		# If null is not returned, add this Player to the players array
	else
		readFirstLine = true
	end
end

# Write out the players as JSON into a simple text file

puts "wrote out #{players.length} player(s)"
