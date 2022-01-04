module before_commit;

// before commit delete *.o and all binary files

// build it : dmd before_commit.d -L-lmagic

// magic lib
import magic;

import std.file;
import std.path;
import std.stdio;
import std.string;

void main(string[] args) {
  auto magic_cookie = magic_open(MAGIC_MIME);
  magic_load(magic_cookie, null);

  foreach (fileName; dirEntries(dirName(thisExePath()), SpanMode.shallow)) {
    if (isFile(fileName)) {
      auto fileType = fromStringz(magic_file(magic_cookie, toStringz(fileName)));
      writeln(fileName, "   ", fileType, "    ", indexOf(fileType, "text"));
      if (indexOf(fileType, "text") < 0 && fileName != thisExePath()) {
        remove(fileName);
      }
    }
  }
}
