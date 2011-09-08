require 'socket'

class SelectChatServer < TCPServer

  def initialize(host,port)
    super host, port
    @sockets = [self]
  end

  def start
    while(1)

      readable_sockets,writable_sockets,exception_sockets = IO.select(@sockets,[], @sockets)

      readable_sockets.each do | read_socket |
        if read_socket == self
          accept_client
        elsif read_socket.closed? or read_socket.eof?
          exit if read_socket == self
          remove_client read_socket
        else
          broadcast_chat_message read_socket
        end
      end

      exception_sockets.each do | err_socket |
        remove_client err_socket
      end

    end
  end

  def accept_client
    client = self.accept
    client.extend(ChatClient)
    client.username = 'test'
    @sockets << client
  end

  def remove_client(client_socket)
    @sockets.reject! { | socket | socket == client_socket }
  end

  def broadcast_chat_message(client_socket)

    chat_message = client_socket.readline
    @sockets.each do | socket | 
      if socket == self or socket == client_socket
        next
      elsif socket.closed?
        remove_client socket
        next
      else
        socket.puts chat_message
      end
    end

  end

end

# an example of a module to provide a custom
# username property to a socket
module ChatClient
  attr_accessor :username
end

server = SelectChatServer.new("localhost", 3829)
server.start
