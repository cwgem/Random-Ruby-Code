require 'socket'

module Cwgem
  class AsyncSelectServer < TCPServer
    def initialize(host,port)
      super
      @sockets = [self]
      @server_active = true
    end

    def accept_client
      client = self.accept
      client.extend Client
      @sockets << client
    end

    def serve
      catch(:force_shutdown) {
        while @server_active do
          processing_occurred = false
          read_sockets,write_sockets,error_sockets = IO.select(@sockets,@sockets,@sockets)

          error_sockets.each do | error_socket |
            throw :force_shutdown if error_socket == self
            remove_client error_socket
          end

          read_sockets.each do | read_socket |
            if read_socket == self
              accept_client
            elsif read_socket.closed? or read_socket.all_data_read?
              next
            else
              remove_client read_socket if !read_socket.buffer_data
              processing_occurred = true
            end
          end

          write_sockets.each do | write_socket |
            if write_socket.closed?
              next
            elsif write_socket.all_data_read?
              remove_client write_socket if !write_socket.write_data or write_socket.all_data_written?
              processing_occurred = true
            end
          end

          sleep(0.1) if !processing_occurred

        end
      }

      shutdown
    end

    def remove_client(client_socket)
      begin
        client_socket.close unless client_socket.closed?
      rescue
      end
      @sockets.reject! { | socket | socket == client_socket }
    end

    def initiate_shutdown
      @server_active = false
    end

    def shutdown
      @sockets.each do | socket |
        begin
          socket.close unless (socket.closed? or socket == self)
        rescue
          next
        end
      end
      
      begin
        self.close unless self.closed?
      rescue
        return
      end
    end
  end

  module Client
    BUFFER_SIZE = 1024

    def self.extended(base_class)
      base_class.setup
    end

    def setup
      @buffer = []
      @read_complete = false
      @write_complete = false
      @offset = 0
    end

    def buffer_data
      begin
        data = self.readpartial(BUFFER_SIZE)
        @buffer += data.bytes.to_a
        @read_complete = true if data.index("\n")
        return true
      rescue EOFError
        @read_complete = true
        return true
      rescue
        return false
      end
    end

    def write_data
      begin
        end_offset = @offset + BUFFER_SIZE
        self.write @buffer[@offset..end_offset].pack("c*")
        @write_complete = true if end_offset >= @buffer.length
        @offset = end_offset+1
        return true
      rescue SystemCallError,IOError
        return false
      end
    end

    def all_data_read?
      @read_complete
    end

    def all_data_written?
      @write_complete
    end
  end
end

server = Cwgem::AsyncSelectServer.new("localhost", 3555)
trap('INT') { puts "Shutting down server..."; server.initiate_shutdown; exit }
server.serve
