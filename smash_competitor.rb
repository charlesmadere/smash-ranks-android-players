require "uri"

GAR_PR_HOST = "garpr.com"
NOT_GAR_PR_HOST = "notgarpr.com"

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

	def is_gar_pr_url_valid(url, host)
		# example GAR PR player profile URL: https://www.garpr.com/#/norcal/players/5877eb55d2994e15c7dea982
		# example Not GAR PR player profile URL: https://www.notgarpr.com/#/newjersey/players/545c854e8ab65f127805bd6f

		if url == nil
			return false
		end

		uri = URI.parse(url)

		if uri.host != host
			return false
		end

		path = uri.path
		puts path

		return true
	end
	private :is_gar_pr_url_valid

	def is_valid
		return is_gar_pr_url_valid(@garPrUrl, GAR_PR_HOST) && is_gar_pr_url_valid(@notGarPrUrl, NOT_GAR_PR_HOST)
	end

	def to_json
		if !is_valid
			raise "This SmashCompetitor (#{tag}) is not valid! Refusing to output as JSON."
		end

		# create and return a JSON string
	end

end
