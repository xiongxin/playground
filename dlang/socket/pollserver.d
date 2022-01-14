import core.sys.posix.netdb;
import core.sys.posix.sys.types;
import core.sys.posix.sys.socket;
import core.stdc.string;
import core.stdc.stdlib;
import core.sys.posix.arpa.inet;
import core.sys.posix.netinet.in_;
import core.sys.posix.signal;
import core.stdc.errno;
import core.sys.posix.sys.wait;
import core.sys.posix.poll;
import core.stdc.stdio;
import core.sys.posix.unistd;

import std.stdio;
import std.string;
import std.algorithm;

enum PORT = "9034";

// Get sockaddr, IPv4 or Ipv6:
void* get_in_addr(sockaddr* sa) {
  if (sa.sa_family == AF_INET) {
    sockaddr_in* si = cast(sockaddr_in*) sa;
    return &si.sin_addr;
  }

  sockaddr_in6* si = cast(sockaddr_in6*) sa;
  return &si.sin6_addr;
}

// Return a listeing socket
int get_listener_socket() {
  int listener; // Listening sokcet descriptor
  int yes = 1; // For socketopt() SO_REUSEADDR, below

  addrinfo hints;
  addrinfo* ai, p;

  // Get us a socket and bind it
  memset(&hints, 0, hints.sizeof);
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE;

  int rv;
  if ((rv = getaddrinfo(null, PORT, &hints, &ai)) != 0) {
    writef("selectserver: %s\n", gai_strerror(rv));
    exit(1);
  }

  for (p = ai; p != null; p = p.ai_next) {
    listener = socket(p.ai_family, p.ai_socktype, p.ai_protocol);
    if (listener < 0) {
      continue;
    }

    // Lose the pesky "address already in use" error message
    setsockopt(listener, SOL_SOCKET, SO_REUSEADDR, &yes, yes.sizeof);

    if (bind(listener, p.ai_addr, p.ai_addrlen) < 0) {
      close(listener);
      continue;
    }

    break;
  }

  // If we got here, it means we didn't get bound
  if (p == null) {
    return -1;
  }

  freeaddrinfo(ai); // All done with this

  // Listen
  if (listen(listener, 10) == -1) {
    return -1;
  }

  return listener;
}

void main(string[] args) {
  int listener; // Listening socket descriptor

  int newfd; // Newly accept()ed socket decriptor
  sockaddr_storage remoteaddr;
  socklen_t addrlen;

  char[256] buf;
  char[INET6_ADDRSTRLEN] remoteIP;

  // Start off with room for 5 connections
  // (We'll relloc as necessary)
  pollfd[] pfds;
  pfds.reserve(5);

  listener = get_listener_socket();
  if (listener == -1) {
    writeln("error getting listening socket");
    exit(1);
  }

  // Add the listener to set
  pfds ~= pollfd(listener, POLLIN);

  for (;;) {
    if (poll(pfds.ptr, pfds.length, -1) == -1) {
      writeln("poll");
      exit(1);
    }
    writeln("pfds = ", pfds);
    // run through the existing connections looking for data to read
    for (int i = 0; i < pfds.length; i++) {

      // Check if someone's ready to read
      if (pfds[i].revents & POLLIN) { // We got one!!
        // If listener is ready to read, handle new connection
        if (pfds[i].fd == listener) {
          addrlen = remoteaddr.sizeof;
          newfd = accept(listener, cast(sockaddr*)&remoteaddr, &addrlen);
          if (newfd == -1) {
            writeln("accept");
          }
          else {
            pfds ~= pollfd(newfd, POLLIN);
            writefln("pollserver: new connection from %s on socket %d",
              fromStringz(inet_ntop(remoteaddr.ss_family, get_in_addr(cast(sockaddr*)&remoteaddr),
                cast(char*) remoteIP, INET_ADDRSTRLEN)), newfd);
          }
        }
        else {
          // If not the listener, we're just a regular client
          int nbytes = cast(int) recv(pfds[i].fd, cast(void*) buf, buf.sizeof, 0);
          int sender_fd = pfds[i].fd;

          if (nbytes <= 0) {
            // Got error or connection closed by client
            if (nbytes == 0) {
              // Connection closed
              writefln("pollserver: socket %d hung up", sender_fd);
            }
            else {
              writeln("recv");
            }

            close(pfds[i].fd); // Bye
            pfds = remove(pfds, i);
          }
          else {
            // We got some good data from a client
            for (int j = 0; j < pfds.length; j++) {
              // Send to everyone!
              int dest_fd = pfds[j].fd;

              // Except the listener and ourselves
              if (dest_fd != listener && dest_fd != sender_fd) {
                if (send(dest_fd, cast(char*) buf, nbytes, 0) == -1) {
                  writeln("send");
                }
              }
            }
          }
        }
      }
    }
  }
}
