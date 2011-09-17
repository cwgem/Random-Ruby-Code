require 'cwgem-selectserver'

class ClientHandler
  def handle_connection(server,client)
    @server = server
    @client = client

    parse_client_request
    respond_to_request
  end

  def respond_to_request
    build_body
    write_headers
    write_body

    @client.close
    @server.remove_client client
  end

  def build_body
    @body = IO.read(File.dirname(File.expand_path(__FILE__)) << "/test_image.png")
  end

  def write_headers
    @client.write "HTTP/1.1 200 OK\r\n"
    @client.write "Content-Type: image/png\r\n"
    @client.write "Content-Length: #{@body.bytesize}\r\n"
  end

  def write_body
    @client.write "\r\n"
    @client.write @body
  end

  def parse_client_request
    line = ""
    while line != "\r\n"
      line = @client.readline
    end
    line
  end
end

server = Cwgem::SelectServer.new("localhost", 3555)
Signal.trap("USR1") { server.shutdown; server.shutdown_handler; exit }
server.setup_method_handler ClientHandler.new.method(:handle_connection)
server.start
