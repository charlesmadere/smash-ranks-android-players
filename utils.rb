require "json"

PATH = "json"
	end

def write_competitors_to_json_file(competitorsHash, fileName)
	fileDirectory = "#{PATH}"

	if !File.exist?(fileDirectory)
		Dir.mkdir(fileDirectory)
	end

	filePath = "#{fileDirectory}#{File::SEPARATOR}#{fileName}"

	File.open(filePath, "w") { |file|
		if competitorsHash == nil || competitorsHash.empty?
			file.write("{}")
		else
			file.write(competitorsHash.to_json)
		end
	}
end
