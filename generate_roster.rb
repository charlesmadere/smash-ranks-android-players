#!/usr/bin/ruby

require "csv"
require_relative "file_utils.rb"
require_relative "smash_competitor.rb"

GAR_PR_FILE_NAME = "gar_pr.json"
GAR_PR_FILE_PATH = "json#{File::SEPARATOR}"
NOT_GAR_PR_FILE_NAME = "not_gar_pr.json"
NOT_GAR_PR_FILE_PATH = "json#{File::SEPARATOR}"
PROPER_ROW_LENGTH = 13
ROSTER_FILE_NAME = "GAR PR Player Roster.csv"


if !File.exist?(ROSTER_FILE_NAME)
	puts "Roster file (#{ROSTER_FILE_NAME}) does not exist!"
	return
end


# This section reads in player data from the CSV file

smashCompetitors = Array.new

CSV.foreach(ROSTER_FILE_NAME, headers: true, skip_blanks: true) do |row|
	smashCompetitor = nil

	if row.length == PROPER_ROW_LENGTH
		smashCompetitor = SmashCompetitor.new(row)
	end

	if smashCompetitor != nil && smashCompetitor.is_valid?
		smashCompetitors.push(smashCompetitor)
	else
		puts "Smash Competitor at line #{index} has data error(s)."
	end
end

puts "Read in #{smashCompetitors.length} player(s)."


# This section creates a Hash of valid GAR PR players and builds up their data into JSON

garPrCompetitorsHash = Hash.new
smashCompetitors.each do |smashCompetitor|
	garPrId = smashCompetitor.gar_pr_id

	if garPrId != nil && !garPrId.empty?
		garPrCompetitorsHash[garPrId] = smashCompetitor.to_gar_pr_hash
	end
end


# This section writes out the GAR PR players to a local JSON file
write_competitors_to_json_file(garPrCompetitorsHash, GAR_PR_FILE_PATH, GAR_PR_FILE_NAME)
puts "Wrote out #{garPrCompetitorsHash.length} GAR PR player(s) to #{GAR_PR_FILE_PATH}#{GAR_PR_FILE_NAME}"


# This section creates a Hash of valid Not GAR PR players and builds up their data into JSON

notGarPrCompetitorsHash = Hash.new
smashCompetitors.each do |smashCompetitor|
	notGarPrId = smashCompetitor.not_gar_pr_id

	if notGarPrId != nil && !notGarPrId.empty?
		notGarPrCompetitorsHash[notGarPrId] = smashCompetitor.to_not_gar_pr_hash
	end
end

# This section writes out the Not GAR PR players to a local JSON file
write_competitors_to_json_file(notGarPrCompetitorsHash, NOT_GAR_PR_FILE_PATH, NOT_GAR_PR_FILE_NAME)
puts "Wrote out #{notGarPrCompetitorsHash.length} Not GAR PR player(s) to #{NOT_GAR_PR_FILE_PATH}#{NOT_GAR_PR_FILE_NAME}"
