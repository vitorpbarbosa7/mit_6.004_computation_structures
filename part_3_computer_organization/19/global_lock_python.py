import threading
import time

# Shared resources
shared_list = []
shared_dict = {}

def append_to_list():
    for i in range(5):
        time.sleep(1)  # Simulate a time-consuming operation
        shared_list.append(i)
        print(f"{time.time()}: Appended {i} to list by {threading.current_thread().name}")

def update_dict():
    for i in range(5):
        time.sleep(1)  # Simulate a time-consuming operation
        shared_dict[i] = i * i
        print(f"{time.time()}: Updated dict with key {i} by {threading.current_thread().name}")

# Creating threads
threads = []
for i in range(2):
    t_list = threading.Thread(target=append_to_list, name=f"ListThread-{i}")
    t_dict = threading.Thread(target=update_dict, name=f"DictThread-{i}")
    threads.append(t_list)
    threads.append(t_dict)

# appear to start threads in serial mode
# but actually it runs concurrently (in parallel)
# Starting threads concurrently
for t in threads:
    t.start()

# Waiting for all threads to complete
for t in threads:
    t.join()

print("Final shared list:", shared_list)
print("Final shared dict:", shared_dict)
