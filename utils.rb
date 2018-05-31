PATH = "json"

def strip_string_quotes(string)
	if string == nil || string.empty?
		return string
	end

	string = string.strip

	if string[0] == "\""
		string = string[1, string.length - 1]
	end

	if string[string.length - 1] == "\""
		string = string[0, string.length - 1]
	end

	return string.strip
end

def write_competitors_to_json_file(competitorsHash, fileName)
	filePath = "#{PATH}#{File::SEPARATOR}#{fileName}"

	if competitorsHash == nil || competitorsHash.empty?
		if File.exists?(filePath)
			File.delete(filePath)
		end

		return true
	end

	competitorsJson = JSON.parse(competitorsHash)
	File.write(filePath, competitorsJson)

	return true
end
