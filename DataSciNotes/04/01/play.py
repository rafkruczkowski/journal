print("Hello World")

for i in [1, 2, 3, 4, 5]:
    print(i)
    for j in [1, 2, 3, 4, 5]:
        print(j)
        print(i + j)
    print(i)
print("done")

try:
    print(0 / 0)
except ZeroDivisionError:
    print("cant do that!")
