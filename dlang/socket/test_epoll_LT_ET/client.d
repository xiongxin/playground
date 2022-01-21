import std.stdio;
import core.sys.posix.unistd;
import core.sys.posix.netdb;
import core.stdc.string;
import core.stdc.stdlib;
import std.conv;
import core.sys.linux.epoll;
import core.sys.posix.fcntl;
import core.stdc.errno;

import std.algorithm;

enum MAX_INPUT_CHAR = 256;
enum MAX_READ = 256;
enum WRITE_NUM = 8;

struct WRITE_BUFFER {
  WRITE_BUFFER* next;
  int size;
  char* ptr;
  char* buf;
}

struct WB_LIST {
  WRITE_BUFFER* head;
  WRITE_BUFFER* tail;
}

WB_LIST wb_list;

WRITE_BUFFER* new_buffer(int size) {
  WRITE_BUFFER* wb = cast(WRITE_BUFFER*) malloc(WRITE_BUFFER.sizeof);
  wb.size = size;
  wb.buf = cast(char*) malloc(char.sizeof * size);
  wb.ptr = wb.buf;
  wb.next = null;
  return wb;
}

void free_buff(WRITE_BUFFER* wb) {
  free(wb.buf);
  free(wb);
}

int try_connect(string host, string port) {
  addrinfo ai_hits;
  addrinfo* ai_list;

  memset(&ai_hits, 0, ai_hits.sizeof);

  ai_hits.ai_family = AF_INET;
  ai_hits.ai_socktype = SOCK_STREAM;
  ai_hits.ai_protocol = IPPROTO_TCP;

  int status = getaddrinfo(host.ptr, port.ptr, &ai_hits, &ai_list);
  if (status != 0) {
    freeaddrinfo(ai_list);
    return -1;
  }
  writeln(*ai_list);
  int fd = socket(ai_list.ai_family, ai_list.ai_socktype, ai_list.ai_protocol);
  if (fd < 0) {
    freeaddrinfo(ai_list);
    return -1;
  }

  status = connect(fd, ai_list.ai_addr, ai_list.ai_addrlen);
  if (status != 0) {
    freeaddrinfo(ai_list);
    close(fd);
    writeln("connect fail");
    return -1;
  }

  freeaddrinfo(ai_list);
  writeln("connect to server success");
  return fd;
}

void input(int epfd, int fd, int event) {
  writeln("begin input");
  char[MAX_INPUT_CHAR] buf;
  int idx = 0;

  for (;;) {
    int c = getchar();
    if (c == '\n' || idx >= MAX_INPUT_CHAR - 1) {
      break;
    }

    // reset epollout
    if (c == '~') {
      epoll_event e;
      e.events = event & (~EPOLLET);
      e.data.fd = fd;
      epoll_ctl(epfd, EPOLL_CTL_MOD, fd, &e);

      e.events = event | EPOLLOUT;
      epoll_ctl(epfd, EPOLL_CTL_MOD, fd, &e);
      writeln("epollout reset");
      continue;
    }

    buf[idx] = cast(char) c;
    idx++;
  }

  buf[idx] = '\0';

  if (idx > 0) {
    WRITE_BUFFER* wb = new_buffer(idx);
    if (wb_list.head == null) {
      wb_list.head = wb_list.tail = wb;

      epoll_event ee;
      ee.events = event;
      ee.data.fd = fd;

      epoll_ctl(epfd, EPOLL_CTL_MOD, fd, &ee);
    }
    else {
      if (wb_list.head == wb_list.tail) {
        wb_list.head.next = wb;
      }
      wb_list.tail.next = wb;
      wb_list.tail = wb;
    }

    memcpy(wb.buf, buf.ptr, char.sizeof * idx);
  }
  writefln("%s", buf);
  writeln("end input");
}

void ouput(int epfd, int fd, int event) {
  writeln("begin to output");
  WRITE_BUFFER* wb = wb_list.head;
  if (wb) {
    size_t wsize = wb.size - (wb.ptr - wb.buf);
  }
}

void main(string[] args) {

  writeln(WRITE_BUFFER.sizeof);
}
