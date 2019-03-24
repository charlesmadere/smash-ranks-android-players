#!/usr/bin/ruby

require "csv"
require_relative "file_utils.rb"
require_relative "smash_competitor.rb"

GAR_PR_FILE_NAME = "gar_pr.json"
GAR_PR_FILE_PATH = "json#{File::SEPARATOR}"
NOT_GAR_PR_FILE_NAME = "not_gar_pr.json"
NOT_GAR_PR_FILE_PATH = "json#{File::SEPARATOR}"
PROPER_ROW_LENGTH = 15
RESPONSES_FILE_NAME = "GAR PR Player Roster (Responses).csv"
SEEDS_FILE_NAME = "GAR PR Player Roster (Seeds).csv"


smashCompetitors = Array.new

# This section reads in seeds from the CSV file (if it exists)

if File.exist?(SEEDS_FILE_NAME)
	CSV.foreach(SEEDS_FILE_NAME, headers: true, skip_blanks: true) do |row|
		smashCompetitor = nil

		if row.length == PROPER_ROW_LENGTH
			smashCompetitor = SmashCompetitor.new(row)
		end

		if smashCompetitor != nil && smashCompetitor.is_valid?
			smashCompetitors.push(smashCompetitor)
		else
			puts "Smash Competitor seed has data error(s): #{row}"
		end
	end
end

puts "Read in #{smashCompetitors.length} seed(s) from #{SEEDS_FILE_NAME}."


if !File.exist?(RESPONSES_FILE_NAME)
	raise "Roster file (#{RESPONSES_FILE_NAME}) does not exist!"
end


# This section reads in player data from the CSV file

CSV.foreach(RESPONSES_FILE_NAME, headers: true, skip_blanks: true) do |row|
	smashCompetitor = nil

	if row.length == PROPER_ROW_LENGTH
		smashCompetitor = SmashCompetitor.new(row)
	end

	if smashCompetitor != nil && smashCompetitor.is_valid?
		smashCompetitors.push(smashCompetitor)
	else
		puts "Smash Competitor has data error(s): #{row}"
	end
end

puts "Now have #{smashCompetitors.length} after reading from #{RESPONSES_FILE_NAME}."


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
