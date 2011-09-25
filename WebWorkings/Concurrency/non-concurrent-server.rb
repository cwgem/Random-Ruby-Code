require 'socket'

server = TCPServer.new("localhost", 3555)

loop do
  client = server.accept
  puts '[Client Connection]'
  data = client.readline
  puts "Got from client: #{data}"
  client.write data
  client.close
  puts '[End Client Connection]'
end
