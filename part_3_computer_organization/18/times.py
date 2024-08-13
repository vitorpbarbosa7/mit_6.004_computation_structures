import time
import resource
import os

def simulate_cpu_bound_task():
    # Simulate CPU-bound work by doing some heavy computation
    result = 0
    for i in range(1, 10000000):
        result += i * i
    return result

def simulate_io_bound_task():
    # Simulate I/O-bound work by performing file I/O
    with open('temp_file.txt', 'w') as f:
        for i in range(1000000):
            f.write(f"This is line {i}\n")
    
    # Simulate reading the file
    with open('temp_file.txt', 'r') as f:
        lines = f.readlines()

def measure_times():
    # Record the starting resource usage (user and system time)
    user_start, system_start = resource.getrusage(resource.RUSAGE_SELF)[:2]
    
    # Record the starting wall clock time
    real_start = time.time()
    
    # Perform CPU-bound task
    simulate_cpu_bound_task()
    
    # Perform I/O-bound task
    simulate_io_bound_task()

    # Record the ending resource usage (user and system time)
    user_end, system_end = resource.getrusage(resource.RUSAGE_SELF)[:2]
    
    # Record the ending wall clock time
    real_end = time.time()
    
    # Calculate the elapsed times
    user_time_spent = user_end - user_start
    system_time_spent = system_end - system_start
    real_time_spent = real_end - real_start
    
    print(f"User time: {user_time_spent:.4f} seconds")
    print(f"System time: {system_time_spent:.4f} seconds")
    print(f"Total CPU time (User + System): {user_time_spent + system_time_spent:.4f} seconds")
    print(f"Real (Wall clock) time: {real_time_spent:.4f} seconds")
    print(f"Time spent waiting (I/O, etc.): {real_time_spent - (user_time_spent + system_time_spent):.4f} seconds")
    
    # Cleanup
    os.remove('temp_file.txt')

if __name__ == "__main__":
    measure_times()

