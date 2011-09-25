require 'socket'

server = TCPServer.new("localhost", 3555)

trap('INT') { server.close; exit }

# Parent process
loop do
  5.times do
    fork do
      # child process logic here
      trap('INT') { exit }
      loop {
        client = server.accept
        puts '[Client Connection]'
        data = client.readline
        puts "Got from client: #{data}"
        client.write data
        client.close
        puts "[End Client Connection]"
      }
      # end child process logic
    end
  end

  # Parent process logic continues
  Process.waitall
end
