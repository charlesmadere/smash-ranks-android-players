require "uri"
require_relative "file_utils.rb"
require_relative "smash_character.rb"

HTTPS_SCHEME = "https"
GAR_PR_HOST = "garpr.com"
NOT_GAR_PR_HOST = "notgarpr.com"
TWITCH_HOST = "twitch.tv"
TWITTER_HOST = "twitter.com"
YOUTUBE_HOST = "youtube.com"

# example GAR PR player profile URL: https://www.garpr.com/#/norcal/players/5877eb55d2994e15c7dea982
# example Not GAR PR player profile URL: https://www.notgarpr.com/#/newjersey/players/545c854e8ab65f127805bd6f

def safe_strip(string)
	if string == nil
		return nil
	else
		return string.strip
	end
end

def safe_strip_and_downcase(string)
	if string == nil
		return nil
	else
		return string.strip.downcase
	end
end

class SmashCompetitor

	def initialize(splits)
		@garPrUrl = safe_strip_and_downcase(splits[1])
		@notGarPrUrl = safe_strip_and_downcase(splits[12])
		@tag = safe_strip(splits[2])
		@realName = safe_strip(splits[3])
		@main1 = safe_strip_and_downcase(splits[4])
		@main2 = safe_strip_and_downcase(splits[5])
		@main3 = safe_strip_and_downcase(splits[6])
		@twitterUrl = safe_strip(splits[7])
		@twitchUrl = safe_strip(splits[8])
		@youtubeUrl = safe_strip(splits[9])
		@otherUrl = safe_strip(splits[10])
		@avatar = safe_strip(splits[11])
		@agree = safe_strip(splits[13])
	end

	def gar_pr_id
		return get_id_from_gar_pr_url(@garPrUrl, GAR_PR_HOST)
	end

	def get_id_from_gar_pr_url(url, host)
		if url == nil || url.empty?
			return nil
		end

		uri = URI.parse(url)

		if !uri.host.end_with?(host)
			return nil
		end

		fragment = uri.fragment
		lastIndexOfSlash = fragment.rindex("/")

		if lastIndexOfSlash == nil
			return nil
		end

		return fragment[lastIndexOfSlash + 1, fragment.length - 1]
	end
	private :get_id_from_gar_pr_url

	def is_gar_pr_url_valid(url, host)
		id = get_id_from_gar_pr_url(url, host)
		return id != nil && !id.empty?
	end
	private :is_gar_pr_url_valid

	def is_other_url_valid?
		otherUrl = @otherUrl

		if otherUrl == nil || otherUrl.empty?
			return false
		end

		uri = URI.parse(otherUrl)
		return uri.scheme == HTTPS_SCHEME && uri.host != nil && !uri.host.empty?
	end

	def is_twitch_valid?
		url = @twitchUrl

		if url == nil || url.empty?
			return false
		end

		uri = URI.parse(url)
		return uri.scheme == HTTPS_SCHEME && uri.host.end_with?(TWITCH_HOST)
	end
	private :is_twitch_valid?

	def is_twitter_valid?
		url = @twitterUrl

		if url == nil || url.empty?
			return false
		end

		uri = URI.parse(url)
		return uri.scheme == HTTPS_SCHEME && uri.host.end_with?(TWITTER_HOST)
	end
	private :is_twitter_valid?

	def is_youtube_valid?
		url = @youtubeUrl

		if url == nil || url.empty?
			return false
		end

		uri = URI.parse(url)
		return uri.scheme == HTTPS_SCHEME && uri.host.end_with?(YOUTUBE_HOST)
	end
	private :is_youtube_valid?

	def is_valid?
		return (is_gar_pr_url_valid(@garPrUrl, GAR_PR_HOST) ||
						is_gar_pr_url_valid(@notGarPrUrl, NOT_GAR_PR_HOST)) &&
				@tag != nil && !@tag.empty? &&
				@realName != nil && !@realName.empty? &&
				"Agree".casecmp(@agree).zero?
	end

	def not_gar_pr_id
		return get_id_from_gar_pr_url(@notGarPrUrl, NOT_GAR_PR_HOST)
	end

	def to_gar_pr_hash
		hash = to_hash
		hash["id"] = gar_pr_id
		return hash
	end

	def to_hash
		if !is_valid?
			raise "This SmashCompetitor (#{tag}) is not valid! Refusing to output hash."
		end

		hash = Hash.new
		hash["name"] = @realName
		hash["tag"] = @tag

		main1 = get_smash_character(@main1)

		if main1 != nil && !main1.empty?
			mains = Array.new
			mains.push(main1)

			main2 = get_smash_character(@main2)
			main3 = get_smash_character(@main3)

			if main2 != nil && !main2.empty?
				mains.push(main2)
			end

			if main3 != nil && !main3.empty?
				mains.push(main3)
			end

			hash["mains"] = mains
		end

		websites = Hash.new
		addedWebsite = false

		if is_twitch_valid?
			websites["twitch"] = @twitchUrl
			addedWebsite = true
		end

		if is_twitter_valid?
			websites["twitter"] = @twitterUrl
			addedWebsite = true
		end

		if is_youtube_valid?
			websites["youtube"] = @youtubeUrl
			addedWebsite = true
		end

		if is_other_url_valid?
			websites["other"] = @otherUrl
			addedWebsite = true
		end

		if addedWebsite
			hash["websites"] = websites
		end

		if @avatar != nil && !@avatar.empty?
			avatar = nil

			if gar_pr_id != nil 
				avatar = download_image_from_google_drive(gar_pr_id, @avatar)
			elsif not_gar_pr_id != nil
				avatar = download_image_from_google_drive(not_gar_pr_id, @avatar)
			end

			if avatar != nil && !avatar.empty?
				hash["avatar"] = avatar
			end
		end

		return hash
	end
	private :to_hash

	def to_not_gar_pr_hash
		hash = to_hash
		hash["id"] = not_gar_pr_id
		return hash
	end

end
