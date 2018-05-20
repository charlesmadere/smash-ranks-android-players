class SmashCompetitor

	def initialize(splits)
		@garPrUrl = splits[1]
		@notGarPrUrl = splits[2]
		@tag = splits[3]
		@realName = splits[4]
		@main1 = splits[5]
		@main2 = splits[6]
		@main3 = splits[7]
		@twitterUrl = splits[8]
		@twitchUrl = splits[9]
		@youtubeUrl = splits[10]
		@otherUrl = splits[11]
		@avatar = splits[12]
	end

	def is_valid
		return false
	end

	def to_json
		if !is_valid
			raise "This SmashCompetitor (#{tag}) is not valid! Refusing to output as JSON."
		end

		# create and return a JSON string
	end

end
