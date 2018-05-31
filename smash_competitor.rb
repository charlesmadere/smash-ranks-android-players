require "uri"
require_relative "smash_character.rb"
require_relative "utils.rb"

GAR_PR_HOST = "garpr.com"
NOT_GAR_PR_HOST = "notgarpr.com"

class SmashCompetitor

	def initialize(splits)
		@garPrUrl = strip_string_quotes(splits[1]).downcase
		@notGarPrUrl = strip_string_quotes(splits[2]).downcase
		@tag = strip_string_quotes(splits[3])
		@realName = strip_string_quotes(splits[4])
		@main1 = strip_string_quotes(splits[5]).downcase
		@main2 = strip_string_quotes(splits[6]).downcase
		@main3 = strip_string_quotes(splits[7]).downcase
		@twitterUrl = strip_string_quotes(splits[8])
		@twitchUrl = strip_string_quotes(splits[9])
		@youtubeUrl = strip_string_quotes(splits[10])
		@otherUrl = strip_string_quotes(splits[11])
		@avatar = strip_string_quotes(splits[12])
	end

	def gar_pr_id
		return get_id_from_gar_pr_url(@garPrUrl)
	end

	def get_id_from_gar_pr_url(url)
		if url == nil || url.empty?
			return nil
		end

		# TODO
	end
	private :get_id_from_gar_pr_url

	def get_smash_character_string(character)
		if character != nil && !character.empty? && SMASH_CHARACTERS.include?(character)
			return character
		else
			return nil
		end
	end
	private :get_smash_character_string

	def is_gar_pr_url_valid(url, host)
		# example GAR PR player profile URL: https://www.garpr.com/#/norcal/players/5877eb55d2994e15c7dea982
		# example Not GAR PR player profile URL: https://www.notgarpr.com/#/newjersey/players/545c854e8ab65f127805bd6f

		if url == nil || url.empty?
			return false
		end

		uri = URI.parse(url)

		if !uri.host.end_with?(host)
			return false
		end

		path = uri.path

		# TODO

		return true
	end
	private :is_gar_pr_url_valid

	def is_other_url_valid?
		# TODO (this check can be much more stringent)
		return @otherUrl != nil && !@otherUrl.empty?
	end

	def is_twitch_valid?
		# TODO (this check can be much more stringent)
		return @twitchUrl != nil && !@twitchUrl.empty?
	end
	private :is_twitch_valid?

	def is_twitter_valid?
		# TODO (this check can be much more stringent)
		return @twitterUrl != nil && !@twitterUrl.empty?
	end
	private :is_twitter_valid?

	def is_youtube_valid?
		# TODO (this check can be much more stringent)
		return @youtubeUrl != nil && !@youtubeUrl.empty?
	end
	private :is_youtube_valid?

	def is_valid?
		return (is_gar_pr_url_valid(@garPrUrl, GAR_PR_HOST) ||
						is_gar_pr_url_valid(@notGarPrUrl, NOT_GAR_PR_HOST)) &&
				@tag != nil && !@tag.empty? &&
				@realName != nil && !@realName.empty?
	end

	def not_gar_pr_id
		return get_id_from_gar_pr_url(@notGarPrUrl)
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
		hash["name"] = @name
		hash["tag"] = @tag

		avatar = Hash.new
		addedAvatar = false

		if @avatar != nil && !@avatar.empty?
			# TODO
		end

		if addedAvatar
			hash["avatar"] = avatar
		end

		main1 = get_smash_character_string(@main1)
		main2 = get_smash_character_string(@main2)
		main3 = get_smash_character_string(@main3)

		if main1 != nil && !main1.empty?
			mains = Array.new
			mains.push(main1)

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

		return hash
	end
	private :to_hash

	def to_not_gar_pr_hash
		hash = to_hash
		hash["id"] = not_gar_pr_id
		return hash
	end

end
