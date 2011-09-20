require 'cwgem-selectserver'

class ClientHandler
  def handle_connection(server,client)
    @server = server
    @client = client

    client_request = parse_client_request
    request_line = client_request.lines.first
    @request_type, @request_path, @request_version = request_line.split(' ')
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
    @body = ""
    path = @server.document_root + @request_path
    # Directory case
    if File.directory?(path)
      if File.exists?(path + "/index.html")
        @body = IO.read(path + "/index.html")
        @status = "200 OK"
      else
        @status = "403 Forbidden"
      end
    # File case
    else
      if File.exists?(path)
        @body = IO.read(path)
        @status = "200 OK"
      else
        @status = "404 Not Found"
      end
    end
  end

  def write_headers
    @client.write "HTTP/1.1 #@status\r\n"
    @client.write "Content-Length: #{@body.bytesize}\r\n" unless @body == ""
  end

  def write_body
    @client.write "\r\n"
    @client.write @body
  end

  def parse_client_request
    line = request = ""
    while line != "\r\n"
      line = @client.readline
      request << line
    end
    request
  end
end

class HttpServer < Cwgem::SelectServer
  attr_reader :document_root

  def initialize(host,port,document_root)
    super(host,port)
    @document_root = document_root
  end
end

server = HttpServer.new("localhost", 3555, File.dirname(File.expand_path(__FILE__)) << '/public')
Signal.trap("USR1") { server.shutdown; server.shutdown_handler; exit }
server.setup_method_handler ClientHandler.new.method(:handle_connection)
server.start
