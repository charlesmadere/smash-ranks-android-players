require "json"
require "uri"

BASE_AVATARS_PATH = "avatars#{File::SEPARATOR}"
BASE_GOOGLE_DRIVE_URL = "https://docs.google.com/uc?id=%s"


# Load mini_magick

require "rubygems"

begin
	gem "mini_magick"
rescue LoadError
	system("gem install mini_magick")
	Gem.clear_paths
	retry
end

require "mini_magick"


# example google drive file link: https://drive.google.com/open?id=1VL2B29WwJCi0MaEEJufUFmha5ktNDDtD
# example google drive file download link: https://drive.google.com/uc?id=1VL2B29WwJCi0MaEEJufUFmha5ktNDDtD

def download_image(url, path)
	if url == nil || url.empty?
		raise "url can't be nil / empty"
	elsif path == nil || path.empty?
		raise "path can't be nil / empty"
	end

	puts "Downloading #{url}..."

	if !File.exist?(BASE_AVATARS_PATH)
		Dir.mkdir(BASE_AVATARS_PATH)
	end

	if !File.exist?(path)
		Dir.mkdir(path)
	end

	originalImage = MiniMagick::Image.open(url) do |b|
		b.format "jpg"
	end

	originalPath = "#{path}#{File::SEPARATOR}original.jpg"
	originalImage.write(originalPath)
	hash = Hash.new
	hash["original"] = originalPath

	if originalImage.dimensions[0] > 80
		smallImage = MiniMagick::Image.open(originalPath)
		smallImage.format "jpg"
		smallImage.resize "80x80>"

		smallPath = "#{path}#{File::SEPARATOR}small.jpg"
		smallImage.write(smallPath)

		hash["small"] = smallPath
	end

	if originalImage.dimensions[0] > 160
		mediumImage = MiniMagick::Image.open(originalPath)
		mediumImage.format "jpg"
		mediumImage.resize "160x160>"

		mediumPath = "#{path}#{File::SEPARATOR}medium.jpg"
		mediumImage.write(mediumPath)

		hash["medium"] = mediumPath
	end

	if originalImage.dimensions[0] > 320
		largeImage = MiniMagick::Image.open(originalPath)
		largeImage.format "jpg"
		largeImage.resize "320x320>"

		largePath = "#{path}#{File::SEPARATOR}large.jpg"
		largeImage.write(largePath)

		hash["large"] = largePath
	end

	return hash
end

def download_image_from_google_drive(playerId, url)
	if url == nil || url.empty?
		return nil
	end

	uri = URI.parse(url)
	query = uri.query

	if query == nil || query.empty?
		return nil
	end

	splits = query.split("=")

	if splits == nil || splits.length == 0
		return nil
	end

	index = splits.index("id")

	if index == nil || index + 1 > splits.length
		return nil
	end

	fileId = splits[index + 1]

	if fileId == nil || fileId.empty?
		return nil
	end

	googleDriveUri = URI.parse(BASE_GOOGLE_DRIVE_URL)
	googleDriveUri.query = "id=#{fileId}"

	filePath = "#{BASE_AVATARS_PATH}#{playerId}"
	return download_image(googleDriveUri.to_s, filePath)
end

def write_competitors_to_json_file(competitorsHash, filePath, fileName)
	if !File.exist?(filePath)
		Dir.mkdir(filePath)
	end

	File.open("#{filePath}#{fileName}", "w") { |file|
		if competitorsHash == nil || competitorsHash.empty?
			file.write("{}")
		else
			file.write(competitorsHash.to_json)
		end
	}
end
