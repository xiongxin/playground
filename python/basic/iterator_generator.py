import sys


class MyNumbers:
  def __iter__(self):
    self.a = 1
    return self
  
  def __next__(self):
    if self.a <= 20:
      x = self.a
      self.a += 1
    return x


myclass = MyNumbers()
myiter = iter(myclass)

while True:
  try:
    print(next(myiter))
  except StopIteration:
    sys.exit(0)
