module unistd_test;

import core.sys.posix.unistd;
import core.sys.posix.fcntl;
import core.stdc.stdio;

void main(string[] args) {
    auto fd = open("db.dat", O_RDWR | O_CREAT | S_IWUSR | S_IRUSR);
    write(fd, cast(void*)['a', 'b'], 3);
    close(fd);
    writeln("aaaa");

}
