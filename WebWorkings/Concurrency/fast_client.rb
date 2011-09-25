require 'socket'

server = TCPSocket.new('localhost', 3555)
server.puts "Hello World"
data = server.read
puts "Got back: #{data}"
