import numpy as np
import time

# Create large arrays
A = np.random.rand(1000000)
B = np.random.rand(1000000)

# Non-vectorized operation
start_time = time.time()
C = []
for i in range(len(A)):
    C.append(A[i] + B[i])
non_vectorized_time = time.time() - start_time

# Vectorized operation
start_time = time.time()
C = A + B
vectorized_time = time.time() - start_time

print(f"Non-vectorized time: {non_vectorized_time:.6f} seconds")
print(f"Vectorized time: {vectorized_time:.6f} seconds")

