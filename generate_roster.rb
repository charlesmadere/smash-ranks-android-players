#!/usr/bin/ruby

require "json"
require_relative "smash_competitor.rb"
require_relative "utils.rb"

ROSTER_FILE_NAME = "GAR PR Player Roster.csv"
GAR_PR_FILE_NAME = "gar_pr.json"
NOT_GAR_PR_FILE_NAME = "not_gar_pr.json"
PROPER_SPLITS_LENGTH = 13

readFirstLine = false
smashCompetitors = Array.new

if !File.exist?(ROSTER_FILE_NAME)
	puts "Roster file (#{ROSTER_FILE_NAME}) does not exist!"
	return
end

File.open(ROSTER_FILE_NAME).each_with_index do |line, index|
	if readFirstLine
		splits = line.split(",")
		smashCompetitor = nil

		if splits.length == PROPER_SPLITS_LENGTH
			smashCompetitor = SmashCompetitor.new(splits)
		end

		if smashCompetitor != nil && smashCompetitor.is_valid?
			smashCompetitors.push(smashCompetitor)
		else
			puts "Smash Competitor at line #{index} has data error(s)."
		end
	else
		readFirstLine = true
	end
end

puts "Read in #{smashCompetitors.length} player(s)."

garPrCompetitorsHash = Hash.new

smashCompetitors.each do |smashCompetitor|
	garPrId = smashCompetitor.gar_pr_id

	if garPrId != nil && !garPrId.empty?
		garPrCompetitorsHash[garPrId] = smashCompetitor.to_gar_pr_json
	end
end

puts garPrCompetitorsHash

if write_competitors_to_json_file(garPrCompetitorsHash, GAR_PR_FILE_NAME)
	puts "Wrote out #{garPrCompetitorsHash.length} GAR PR player(s)."
else
	puts "Failed to write out GAR PR competitors file."
end

notGarPrCompetitorsHash = Hash.new

smashCompetitors.each do |smashCompetitor|
	notGarPrId = smashCompetitor.not_gar_pr_id

	if notGarPrId != nil && !notGarPrId.empty?
		notGarPrCompetitorsHash[notGarPrId] = smashCompetitor.to_not_gar_pr_json
	end
end

if write_competitors_to_json_file(notGarPrCompetitorsHash, NOT_GAR_PR_FILE_NAME)
	puts "Wrote out #{notGarPrCompetitorsHash.length} Not GAR PR player(s)."
else
	puts "Failed to write out Not GAR PR competitors file."
end
