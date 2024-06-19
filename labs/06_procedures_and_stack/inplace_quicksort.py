

# in -place partition of subarray
#   left is the index of the leftmost element of the subarray
#   right is the index of the rightmost element of the subarray (inclusive)

# so start with left = 0 and right = len(array) + 1 ? 
def partition(array, left, right):
    # choose middle element of the array as pivot
    pivotIndex = (left + right) >> 1 # divide by two, nice, start to use this in my code to look like a total weirdo
    pivotValue = array[pivotIndex]

    # swap array[right] and array[pivotIndex] (the end of the array, as we did in the first tutorial problem exercise)
    # note that we already store array[pivotIndex] in pivotValue
    array[pivotIndex] = array[right]

    # elements smaller or equal than the pivot are moved to the left (smaller indices)
    # keep old left index from that partition we are working with
    storeIndex = left
    # we can only range from left to right because is our current partition of the array to apply the quicksort recursive
    for i in range(left, right):
        temp = array[i]
        if temp <= pivotValue:
            array[i] = array[storeIndex]
            array[storeIndex] = temp
            storeIndex += 1

    # move pivot to its final place
    array[right] = array[storeIndex]
    array[storeIndex] = pivotValue
    return storeIndex


def quicksort(array, left, right):
    if left < right:
        pivotIndex = partition(array, left, right)
        # think that pivotIndex is just the pivotIndex, which once the pivot was chosen, now 
        # values to the left are smaller
        # and values to the right are greater
        # this was done by the partition auxiliar function which does the procedures all in place
        # so we call the quicksort recursively to in all portions of the array, the partitions of it
        # sort it using the same logic
        quicksort(array, left, pivotIndex- 1)
        quicksort(array, pivotIndex + 1, right)


if __name__ == '__main__':

    array = [1,7,2,6,8,3,4]
    quicksort(array, 0, len(array)-1)
    print(array)
    



'''
https://pythontutor.com/render.html#code=%0A%23%20in%20-place%20partition%20of%20subarray%0A%23%20%20%20left%20is%20the%20index%20of%20the%20leftmost%20element%20of%20the%20subarray%0A%23%20%20%20right%20is%20the%20index%20of%20the%20rightmost%20element%20of%20the%20subarray%20%28inclusive%29%0A%0A%23%20so%20start%20with%20left%20%3D%200%20and%20right%20%3D%20len%28array%29%20%2B%201%20%3F%20%0Adef%20partition%28array,%20left,%20right%29%3A%0A%20%20%20%20%23%20choose%20middle%20element%20of%20the%20array%20as%20pivot%0A%20%20%20%20pivotIndex%20%3D%20%28left%20%2B%20right%29%20%3E%3E%201%20%23%20divide%20by%20two,%20nice,%20start%20to%20use%20this%20in%20my%20code%20to%20look%20like%20a%20total%20weirdo%0A%20%20%20%20pivotValue%20%3D%20array%5BpivotIndex%5D%0A%0A%20%20%20%20%23%20swap%20array%5Bright%5D%20and%20array%5BpivotIndex%5D%20%28the%20end%20of%20the%20array,%20as%20we%20did%20in%20the%20first%20tutorial%20problem%20exercise%29%0A%20%20%20%20%23%20note%20that%20we%20already%20store%20array%5BpivotIndex%5D%20in%20pivotValue%0A%20%20%20%20array%5BpivotIndex%5D%20%3D%20array%5Bright%5D%0A%0A%20%20%20%20%23%20elements%20smaller%20or%20equal%20than%20the%20pivot%20are%20moved%20to%20the%20left%20%28smaller%20indices%29%0A%20%20%20%20%23%20keep%20old%20left%20index%20from%20that%20partition%20we%20are%20working%20with%0A%20%20%20%20storeIndex%20%3D%20left%0A%20%20%20%20%23%20we%20can%20only%20range%20from%20left%20to%20right%20because%20is%20our%20current%20partition%20of%20the%20array%20to%20apply%20the%20quicksort%20recursive%0A%20%20%20%20for%20i%20in%20range%28left,%20right%29%3A%0A%20%20%20%20%20%20%20%20temp%20%3D%20array%5Bi%5D%0A%20%20%20%20%20%20%20%20if%20temp%20%3C%3D%20pivotValue%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20array%5Bi%5D%20%3D%20array%5BstoreIndex%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20array%5BstoreIndex%5D%20%3D%20temp%0A%20%20%20%20%20%20%20%20%20%20%20%20storeIndex%20%2B%3D%201%0A%0A%20%20%20%20%23%20move%20pivot%20to%20its%20final%20place%0A%20%20%20%20array%5Bright%5D%20%3D%20array%5BstoreIndex%5D%0A%20%20%20%20array%5BstoreIndex%5D%20%3D%20pivotValue%0A%20%20%20%20return%20storeIndex%0A%0A%0Adef%20quicksort%28array,%20left,%20right%29%3A%0A%20%20%20%20if%20left%20%3C%20right%3A%0A%20%20%20%20%20%20%20%20pivotIndex%20%3D%20partition%28array,%20left,%20right%29%0A%20%20%20%20%20%20%20%20%23%20think%20that%20pivotIndex%20is%20just%20the%20pivotIndex,%20which%20once%20the%20pivot%20was%20chosen,%20now%20%0A%20%20%20%20%20%20%20%20%23%20values%20to%20the%20left%20are%20smaller%0A%20%20%20%20%20%20%20%20%23%20and%20values%20to%20the%20right%20are%20greater%0A%20%20%20%20%20%20%20%20%23%20this%20was%20done%20by%20the%20partition%20auxiliar%20function%20which%20does%20the%20procedures%20all%20in%20place%0A%20%20%20%20%20%20%20%20%23%20so%20we%20call%20the%20quicksort%20recursively%20to%20in%20all%20portions%20of%20the%20array,%20the%20partitions%20of%20it%0A%20%20%20%20%20%20%20%20%23%20sort%20it%20using%20the%20same%20logic%0A%20%20%20%20%20%20%20%20quicksort%28array,%20left,%20pivotIndex-%201%29%0A%20%20%20%20%20%20%20%20quicksort%28array,%20pivotIndex%20%2B%201,%20right%29%0A%0A%0Aif%20__name__%20%3D%3D%20'__main__'%3A%0A%0A%20%20%20%20array%20%3D%20%5B1,7,2,6,8,3,4%5D%0A%20%20%20%20quicksort%28array,%200,%20len%28array%29-1%29%0A%20%20%20%20print%28array%29&cumulative=false&curInstr=136&heapPrimitives=nevernest&mode=display&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false
'''