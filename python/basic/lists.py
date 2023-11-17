import operator

for x in [1, 2, 3]:
  print(x, end=' ')

a = [1, 2, 3, 3, 3, 4, 2]
b = [1, 2]
del a[:]
print(len(a))
print(operator.eq(a, b))
