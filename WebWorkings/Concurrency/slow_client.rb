require 'socket'

server = TCPSocket.new('localhost', 3555)

data = 'Content-Type: text/html; charset=UTF-8'
print 'Writing Data: '

data.each_char do | char |
  print char
  server.write char
  sleep 1
end

puts
