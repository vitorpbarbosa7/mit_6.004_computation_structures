def add_numbers(a, b):
    return a + b

# Display bytecode for the add_numbers function
import dis
dis.dis(add_numbers)