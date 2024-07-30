import psutil
import time

def bytes_to_megabytes(bytes):
    return bytes / (1024 * 1024)

def print_memory_info(process):
    memory_info = process.memory_info()
    print("Memory Info (in MB):")
    print("  RSS (Resident Set Size):", bytes_to_megabytes(memory_info.rss))
    print("  VMS (Virtual Memory Size):", bytes_to_megabytes(memory_info.vms))
    print("  Page Faults:", process.num_page_faults() if hasattr(process, 'num_page_faults') else 'N/A')
    print("  Page Ins:", process.num_pageins() if hasattr(process, 'num_pageins') else 'N/A')
    print("Memory Percent:", process.memory_percent())
    print()

# Simulate some memory usage
def allocate_memory():
    large_list = []
    for i in range(10**6):
        large_list.append(i)
    time.sleep(1)
    del large_list

process = psutil.Process()

# Monitor page faults and page ins over time
for i in range(5):
    print(f"Iteration {i+1}:")
    print_memory_info(process)
    allocate_memory()

