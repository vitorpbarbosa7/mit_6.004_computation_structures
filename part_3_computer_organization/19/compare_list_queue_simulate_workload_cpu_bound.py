import threading
import time
from queue import Queue

# Workload to simulate CPU-bound tasks
# (very clever ideia ham)
def simulate_workload(work_time):
    start = time.time()
    while time.time() - start < work_time:
        pass  # Busy-wait for the duration of work_time

# Function using threads with a shared list
def worker_list(shared_list, index, work_time):
    simulate_workload(work_time)
    shared_list[index] = time.time()

def run_with_list(n_threads, work_time, iterations):
    shared_list = [None] * n_threads
    threads = []

    start_time = time.time()
    
    for _ in range(iterations):
        for i in range(n_threads):
            t = threading.Thread(target=worker_list, args=(shared_list, i, work_time))
            t.start()
            threads.append(t)

        for t in threads:
            t.join()

    end_time = time.time()
    total_time = end_time - start_time
    return total_time

# Function using threads with a Queue
def worker_queue(q, work_time):
    while not q.empty():
        index = q.get()
        simulate_workload(work_time)
        q.task_done()

def run_with_queue(n_threads, work_time, iterations):
    q = Queue()
    for i in range(n_threads):
        q.put(i)

    threads = []

    start_time = time.time()

    for _ in range(iterations):
        for _ in range(n_threads):
            t = threading.Thread(target=worker_queue, args=(q, work_time))
            t.start()
            threads.append(t)

        q.join()  # Wait until all tasks in the queue are processed

    end_time = time.time()
    total_time = end_time - start_time
    return total_time

# Parameters
n_threads = 10
work_time = 0.5  # Time each thread will simulate work (in seconds)
iterations = 10  # Number of iterations to better expose the GIL issue

# Run the tests
list_time = run_with_list(n_threads, work_time, iterations)
queue_time = run_with_queue(n_threads, work_time, iterations)

print(f"Total time with list: {list_time:.2f} seconds")
print(f"Total time with queue: {queue_time:.2f} seconds")

# Assert the queue-based implementation is faster
assert queue_time < list_time, "Queue-based threads should be faster than list-based threads"
