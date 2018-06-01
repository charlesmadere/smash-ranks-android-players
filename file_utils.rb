require "json"

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
