#include <stdio.h>
#include <stdlib.h>

void stack_allocation() {
    int stack_array[5];  // Stack allocation for a fixed-size array
    for (int i = 0; i < 5; i++) {
        stack_array[i] = i * 10;
    }

    printf("Stack Allocation:\n");
    for (int i = 0; i < 5; i++) {
        printf("  stack_array[%d] = %d (address: %p)\n", i, stack_array[i], (void*)&stack_array[i]);
    }
}

void heap_allocation(size_t size) {
    int *heap_array = (int *)malloc(size * sizeof(int));  // Heap allocation for a dynamic-size array
    if (heap_array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    for (size_t i = 0; i < size; i++) {
        heap_array[i] = i * 10;
    }

    printf("Heap Allocation:\n");
    for (size_t i = 0; i < size; i++) {
        printf("  heap_array[%zu] = %d (address: %p)\n", i, heap_array[i], (void*)&heap_array[i]);
    }

    free(heap_array);  // Free the allocated memory
}

int main() {
    stack_allocation();

    size_t size;
    printf("Enter the size of the array for heap allocation: ");
    scanf("%zu", &size);

    heap_allocation(size);

    return 0;
}
