#ifndef Book_H
#define Book_H

#include <array>
#include <initializer_list>
#include <string>

class Author {};
class Publisher;

class Book {
 private:
  std::string title;
  const Publisher* publisher;
  int numAuthors;
  std::string isbn;
  static const int MaxAuthors = 12;
  std::array<Author, MaxAuthors> authors;

 public:
  typedef std::array<Author, MaxAuthors>::iterator iterator;
  typedef std::array<Author, MaxAuthors>::const_iterator const_iterator;

  Book();

  Book(std::string theTitle, const Publisher* publ,
       std::initializer_list<Author> theAuthors, std::string theISBN);

  template <typename Iterator>
  Book(std::string theTitle, const Publisher* publ, Iterator startAuthors,
       Iterator stopAuthors, std::string theISBN);

  std::string getTitle() const { return title; }
  void setTitle(std::string theTitle) { title = theTitle; }

  int getNumberOfAuthors() const;

  iterator begin();
  const_iterator begin() const;
  iterator end();
  const_iterator end() const;

  void addAuthor(Author);
  void removeAuthor(Author);

  const Publisher* getPublisher() const { return publisher; }
  void setPublisher(const Publisher* publ) { publisher = publ; }

  std::string getISBN() const { return isbn; }
  void setISBN(std::string id) { isbn = id; }
};

template <typename Iterator>
Book::Book(std::string theTitle, const Publisher* publ, Iterator startAuthors,
           Iterator stopAuthors, std::string theISBN)
    : title(theTitle), publisher(publ), numAuthors(0), isbn(theISBN) {
  while (startAuthors != stopAuthors) {
    authors[numAuthors] = *startAuthors;
    ++numAuthors;
    ++startAuthors;
  }
}

#endif
