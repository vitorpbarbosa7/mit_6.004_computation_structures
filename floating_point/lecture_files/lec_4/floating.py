

frac = 0b11011011011010000000000
M = 1 + 2**(-1) + 2 **(-2) + 2**(-4) + 2**(-5) + 2**(-7) + 2**(-8) + 2**(-10) + 2**(-11) + 2**(-13)

# single precision
Bias = 127
Exp = 0b10001100
E = 13

s = 0

v = ((-1)**s)*M*2**E

print(v)