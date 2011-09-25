require 'socket'

server = TCPServer.new("localhost", 3555)

trap('INT') { server.close; exit }

loop do
  Thread.new(server.accept) do | client |
    puts '[Client Connection]'
    data = client.readline
    puts "Got from client: #{data}"
    client.write data
    client.close
    puts "[End Client Connection]"
  end
end
