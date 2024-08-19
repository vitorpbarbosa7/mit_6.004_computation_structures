import threading
import time
from queue import Queue

# Simulate a real computation-heavy workload
def compute_sum_of_squares(start, end):
    return sum(x * x for x in range(start, end))

def worker_list(shared_list, index, work_size):
    result = compute_sum_of_squares(0, work_size)
    shared_list[index] = result

def run_with_list(n_threads, work_size, iterations):
    shared_list = [None] * n_threads
    threads = []

    start_time = time.time()
    
    for _ in range(iterations):
        for i in range(n_threads):
            t = threading.Thread(target=worker_list, args=(shared_list, i, work_size))
            t.start()
            threads.append(t)

        for t in threads:
            t.join()

    end_time = time.time()
    total_time = end_time - start_time
    return total_time

def worker_queue(q, work_size):
    while not q.empty():
        index = q.get()
        compute_sum_of_squares(0, work_size)
        q.task_done()

def run_with_queue(n_threads, work_size, iterations):
    q = Queue()
    for i in range(n_threads):
        q.put(i)

    threads = []

    start_time = time.time()

    for _ in range(iterations):
        for _ in range(n_threads):
            t = threading.Thread(target=worker_queue, args=(q, work_size))
            t.start()
            threads.append(t)

        q.join()  # Wait until all tasks in the queue are processed

    end_time = time.time()
    total_time = end_time - start_time
    return total_time

# Parameters
n_threads = 10
work_size = 10**6  # Simulate a workload with 1 million computations per thread
iterations = 5  # Number of iterations

# Run the tests
list_time = run_with_list(n_threads, work_size, iterations)
queue_time = run_with_queue(n_threads, work_size, iterations)

print(f"Total time with list: {list_time:.2f} seconds")
print(f"Total time with queue: {queue_time:.2f} seconds")

# Assert the queue-based implementation is faster
assert queue_time < list_time, "Queue-based threads should be faster than list-based threads"
 
