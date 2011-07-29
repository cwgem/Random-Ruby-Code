require 'net/http'
require 'xml-object'

def fetch(uri_str, limit = 10)
	# You should choose better exception.
	raise ArgumentError, 'HTTP redirect too deep' if limit == 0

	response = Net::HTTP.get_response(URI.parse(uri_str))
	case response
	when Net::HTTPSuccess     then response
	when Net::HTTPRedirection then fetch(response['location'], limit - 1)
	else
		response.error!
	end
end

xml_data = fetch("http://www.slashdot.org/index.rss").body

rss = XMLObject.new(xml_data)

puts rss.channel.title
puts rss.channel.link
puts rss.channel.description

rss.items.each do |item|
	puts item.title
	puts item.link
	puts item.description
end