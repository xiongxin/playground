module word_count;

import std.file;
import std.stdio;
import std.ascii;
import std.algorithm;

void main(string[] args) {
  ulong totalWords, totalLines, totalChars;
  ulong[string] dictionary;

  writeln("   lines   words   bytes file");

  foreach (arg; args[1 .. $]) {
    ulong wordCount, lineCount, charCount;
    foreach (line; File(arg).byLine()) {
      bool inWord;
      size_t wordStart;

      void tryFinishWord(size_t wordEnd) {
        if (inWord) {
          auto word = line[wordStart .. wordEnd];
          ++dictionary[word.idup];
          inWord = false;
        }
      }

      foreach (i, char c; line) {
        if (std.ascii.isDigit(c)) { //数字

        }
        else if (std.ascii.isAlpha(c)) { //字符
          if (!inWord) {
            wordStart = i;
            inWord = true;
            ++wordCount;
          }
        }
        else // 其他，包括空格，开始计算字符
          tryFinishWord(i);
        ++charCount;
      }

      tryFinishWord(line.length);
      ++lineCount;
    }

    writefln("%8s%8s%8s %s", lineCount, wordCount, charCount, arg);
    totalWords += wordCount;
    totalLines += lineCount;
    totalChars += charCount;
  }

  if (args.length > 2) {
    writefln("-------------------------------------\n%8s%8s%8s total",
      totalLines, totalWords, totalChars);
  }

  writeln("-------------------------------------");
  foreach (word; dictionary.keys.sort) {
    writefln("%3s %s", dictionary[word], word);
  }
}
