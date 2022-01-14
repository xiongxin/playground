module block_client;

import std.stdio;
import std.socket;
import core.thread;

void main(string[] args) {
  TcpSocket client = new TcpSocket(new InternetAddress(9003));
  assert(client.isAlive());

  while (true) {
    client.send("I am client!");
    Thread.sleep(dur!("seconds")(3));
  }
}
