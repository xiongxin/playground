module block_server;

import std.stdio;
import std.socket;

void main(string[] args) {
  TcpSocket server = new TcpSocket();
  server.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);

  server.bind(new InternetAddress(9002));
  server.listen(10);
  writeln("Server started...");

  while (true) {
    Socket client = server.accept();
    writeln("Connected by ", client.remoteAddress());
    client.send("Hello");
    while (true) {
      char[1024] buf;
      auto datLength = client.receive(buf);
      writeln("datLength = ", datLength);
      if (datLength == Socket.ERROR) {
        writeln("Connection err.");
        break;
      }
      else if (datLength != 0) {
        writefln("Received %d bytes from %s: \"%s\"",
          datLength,
          client.remoteAddress().toString(),
          buf[0 .. datLength]);
      }
      else {
        try {
          // if the connection closed due to an error, remoteAddress() could fail
          writefln("Connection from %s closed.", client.remoteAddress().toString());
        }
        catch (SocketException) {
          writeln("Connection closed.");
        }

        client.close();
        break;
      }
    }
  }
}
