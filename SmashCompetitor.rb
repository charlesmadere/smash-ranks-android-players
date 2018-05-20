class SmashCompetitor

	def initialize(splits)
		@garPrUrl = splits[1]
		@notGarPrUrl = splits[2]
		@tag = splits[3]
		@name = splits[4]
		@main1 = splits[5]
		@main2 = splits[6]
		@main3 = splits[7]
		@twitterUrl = splits[8]
		@twitchUrl = splits[9]
		@youtubeUrl = splits[10]
		@otherUrl = splits[11]
		@avatar = splits[12]
	end

end
