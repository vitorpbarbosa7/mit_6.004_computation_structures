if we have M1.2**1

and

M2.2**33

to make a addition, what must we do ? 

like, what shift?


the M1 frac, the significand, the mantissa is 

10010001111001011000011

so make the necessary shift 


To add two floating-point numbers in binary, their exponents must be equal. The number with the smaller exponent needs to have its significand (mantissa) shifted right until both exponents are equal. Here's how you would perform the necessary steps for the given numbers:

You are given:

- \( M_1 \cdot 2^1 \)  
- \( M_2 \cdot 2^{33} \)

The goal is to adjust the exponent of \( M_1 \cdot 2^1 \) to match the exponent of \( M_2 \cdot 2^{33} \).

### Step-by-Step Process:

1. **Difference in Exponents**:
   - \( E_1 = 1 \)
   - \( E_2 = 33 \)
   - Difference in exponents: \( 33 - 1 = 32 \)
   
   So, you need to shift the significand of \( M_1 \) to the right by 32 positions to match the exponent of \( 2^{33} \).

2. **Shift \( M_1 \)**:
   - \( M_1 = 10010001111001011000011_2 \)
   - Shift \( M_1 \) right by 32 positions.
   - After the shift, the result of \( M_1 \) becomes very small because most of the bits are pushed out to the right.

### Shifting \( M_1 \) by 32:

- Initially: \( M_1 = 10010001111001011000011_2 \)
- Shifting right by 32 (since \( M_1 \cdot 2^1 \) must match \( M_2 \cdot 2^{33} \)):

After shifting 32 bits right, \( M_1 \) will essentially turn into a very small number because \( M_1 \)'s fraction bits will all be pushed out.

In this case, shifting \( M_1 \) 32 positions to the right will make it:

\[ M_1 \rightarrow 0.00000000000000000000000000000000010010001111001011000011_2 \]

Which becomes practically zero because all the significant bits have been shifted out of the number.

### Addition:

Once the exponents match, you can add the significands:

\[ M_1 \cdot 2^{33} + M_2 \cdot 2^{33} \]

However, after shifting \( M_1 \)'s significand, it is almost negligible compared to \( M_2 \)'s value because \( M_2 \)'s exponent is much larger.

So, the result of adding them is almost equal to \( M_2 \).

### Conclusion:

1. **Shift the smaller exponent's significand**: Shift the significand of the number with the smaller exponent (in this case, \( M_1 \)) to the right until the exponents match.
2. **Perform the addition**: Add the adjusted significands together.
3. **The result will be dominated by the number with the larger exponent** since \( M_1 \)'s significand becomes very small after shifting.

This step-by-step process is how floating-point addition works in hardware. When numbers with significantly different exponents are added, the smaller number often gets "lost" due to the difference in magnitude.
