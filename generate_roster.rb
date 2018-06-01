#!/usr/bin/ruby

require "csv"
require_relative "smash_competitor.rb"
require_relative "utils.rb"

ROSTER_FILE_NAME = "GAR PR Player Roster.csv"
GAR_PR_FILE_NAME = "gar_pr.json"
NOT_GAR_PR_FILE_NAME = "not_gar_pr.json"
PROPER_ROW_LENGTH = 13

readFirstLine = false
smashCompetitors = Array.new

if !File.exist?(ROSTER_FILE_NAME)
	puts "Roster file (#{ROSTER_FILE_NAME}) does not exist!"
	return
end

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

garPrCompetitorsHash = Hash.new

smashCompetitors.each do |smashCompetitor|
	garPrId = smashCompetitor.gar_pr_id

	if garPrId != nil && !garPrId.empty?
		garPrCompetitorsHash[garPrId] = smashCompetitor.to_gar_pr_hash
	end
end

if write_competitors_to_json_file(garPrCompetitorsHash, GAR_PR_FILE_NAME)
	puts "Wrote out #{garPrCompetitorsHash.length} GAR PR player(s)."
else
	puts "Failed to write out GAR PR competitors file."
end

notGarPrCompetitorsHash = Hash.new

smashCompetitors.each do |smashCompetitor|
	notGarPrId = smashCompetitor.not_gar_pr_id

	if notGarPrId != nil && !notGarPrId.empty?
		notGarPrCompetitorsHash[notGarPrId] = smashCompetitor.to_not_gar_pr_hash
	end
end

if write_competitors_to_json_file(notGarPrCompetitorsHash, NOT_GAR_PR_FILE_NAME)
	puts "Wrote out #{notGarPrCompetitorsHash.length} Not GAR PR player(s)."
else
	puts "Failed to write out Not GAR PR competitors file."
end
