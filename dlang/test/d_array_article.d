module d_array_article;

import std.stdio;
import core.sys;

void main(string[] args) {
  int[] slice = new int[5];

  writeln(&slice, " ", slice.ptr, slice, slice.capacity);
  slice ~= 1;
  slice ~= 1;
  slice ~= 1;
  writeln(&slice, " ", slice.ptr, slice, slice.capacity);
}
