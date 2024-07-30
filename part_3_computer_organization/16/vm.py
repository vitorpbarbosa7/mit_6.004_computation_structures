import psutil

def bytes_to_megabytes(bytes):
    return bytes / (1024 * 1024)

# Get virtual memory details
virtual_memory = psutil.virtual_memory()
print("Total Memory (MB):", bytes_to_megabytes(virtual_memory.total))
print("Available Memory (MB):", bytes_to_megabytes(virtual_memory.available))
print("Used Memory (MB):", bytes_to_megabytes(virtual_memory.used))
print("Percentage:", virtual_memory.percent)

# Get process memory details
process = psutil.Process()
memory_info = process.memory_info()
print("Memory Info (in MB):")
print("  RSS (Resident Set Size):", bytes_to_megabytes(memory_info.rss))
print("  VMS (Virtual Memory Size):", bytes_to_megabytes(memory_info.vms))
print("  PFaults (Page Faults):", memory_info.num_page_faults if hasattr(memory_info, 'num_page_faults') else 'N/A')
print("  Page Ins:", memory_info.num_pageins if hasattr(memory_info, 'num_pageins') else 'N/A')
print("Memory Percent:", process.memory_percent())

