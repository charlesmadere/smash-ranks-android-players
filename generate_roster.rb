#!/usr/bin/ruby

require "json"
require_relative "smash_competitor.rb"

FILE_NAME = "GAR PR Player Roster.csv"
PROPER_SPLITS_LENGTH = 13
readFirstLine = false
smashCompetitors = Array.new

if !File.exist?(FILE_NAME)
	puts "Roster file (#{FILE_NAME}) does not exist!"
	return
end

File.open(FILE_NAME).each_with_index do |line, index|
	if readFirstLine
		splits = line.split(",")
		smashCompetitor = nil

		if splits.length == PROPER_SPLITS_LENGTH
			smashCompetitor = SmashCompetitor.new(splits)
		end

		if smashCompetitor != nil && smashCompetitor.is_valid?
			smashCompetitors.push(smashCompetitor)
		else
			puts "Smash Competitor at line #{index} has data error(s)"
		end
	else
		readFirstLine = true
	end
end

garPrCompetitorsHash = Hash.new

smashCompetitors.each do |smashCompetitor|
	garPrId = smashCompetitor.gar_pr_id

	if garPrId != nil && !garPrId.empty?
		garPrCompetitorsHash[garPrId] = smashCompetitor.to_gar_pr_json
	end
end

# Convert garPrCompetitorsHash to JSON
# Write the JSON out to a local file

puts "wrote out #{garPrCompetitorsHash.length} GAR PR player(s)"

# Write out the Not GAR PR players
