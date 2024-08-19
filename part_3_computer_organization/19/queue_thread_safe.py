import queue
import threading
import time
from datetime import datetime

q = queue.Queue()


# each worker runs in a separate thread
# but each worker will really be able to cuncurrently 
# modify the shared queue simulstaneously
def worker(thread_id):
    while True:
        item = q.get()
        if item is None:
            break
        now = datetime.now().strftime('%H:%M:%S.%f')
        print(f'[{now}] Thread-{thread_id} processing item {item}')
        time.sleep(0.5)  # Simulate work
        q.task_done()

# Create worker threads
threads = []
for i in range(4):
    t = threading.Thread(target=worker, args=(i,))
    t.start()
    threads.append(t)

# Add items to the queue
for item in range(10):
    q.put(item)

# Block until all items are processed
q.join()

# Stop workers
for _ in range(4):
    q.put(None)
for t in threads:
    t.join()
