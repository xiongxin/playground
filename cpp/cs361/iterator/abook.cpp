/*
 * book.cpp
 *
 *  Created on: May 23, 2018
 *      Author: zeil
 */

#include "abook.h"

#include <algorithm>
#include <cassert>

using namespace std;

Book::Book() : title(), publisher(nullptr), numAuthors(0), isbn() {}

Book::Book(std::string theTitle, const Publisher* publ,
           std::initializer_list<Author> theAuthors, std::string theISBN)
    : title(theTitle),
      publisher(publ),
      numAuthors(theAuthors.size()),
      isbn(theISBN) {
  int i = 0;
  for (const Author& au : theAuthors) {
    authors[i] = au;
    ++i;
  }
}

int Book::getNumberOfAuthors() const { return numAuthors; }

Book::iterator Book::begin() { return authors.begin(); }
Book::const_iterator Book::begin() const { return authors.begin(); }
Book::iterator Book::end() { return authors.begin() + numAuthors; }
Book::const_iterator Book::end() const { return authors.begin() + numAuthors; }

void Book::addAuthor(Author au) {
  assert(numAuthors < MaxAuthors);
  authors[numAuthors] = au;
  ++numAuthors;
}
void Book::removeAuthor(Author au) {
  auto pos = find(begin(), end(), au);
  if (pos != end()) {
    copy(pos + 1, end(), pos);
    --numAuthors;
  }
}
