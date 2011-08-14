class Server
  def self.listen
    puts "Listening on #@ip"
  end
end

class UdpServer < Server
  @ip = "1.2.3.4"
end

class TcpServer < Server
  @ip = "5.6.7.8"
end

UdpServer.listen
TcpServer.listen
