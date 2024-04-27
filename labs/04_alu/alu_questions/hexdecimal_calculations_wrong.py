import ctypes


a = 0x12345678
b = 0x12345678

c = 0x7FFFFFFF
d = 0xFFFFFFFF

e = 0x00000005
f = 0xDEADBEEF

g = 0xDEADBEEF
h = 0x00000005

i = 0x80000000
j = 0x00000001


def signed(n):

    na = n & 0xFFFFFFFF
    print(na)

    return ctypes.c_long(na).value

numbers = [a,b,c,d,e,f,g,h,i,j]

for n in numbers:
    print(signed(n))


