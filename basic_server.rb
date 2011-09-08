require 'socket'
include Socket::Constants
socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
sockaddr = Socket.pack_sockaddr_in( 2200, 'localhost' )
socket.bind( sockaddr )
socket.listen( 5 )
socket.accept
