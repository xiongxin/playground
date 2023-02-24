/**
 *
 * Assume the elements of the array are already in order
 * Find the position where value could be added to keep
 * everything in order, and insert it there.
 *
 * Return the position where it was inserted
 *  - Assumes that we have a separate integer (size) indicating how
 *     many elements are in the array
 *  - and that the "true" size of the array is at least one larger
 *      than the current value of that counter
 *
 *  @param array array into which to add an element
 *  @param size  number of data elements in the array. Must be less than
 *               the number of elements allocated for the array.
 *               Incremented upon output from this function.
 *  @param value value to add into the array
 *  @return the position where the element was added
 */
int addInOrder(int* array, int& size, int value) {
  int can_insert_idx = size - 1;  // O(1)

  while (can_insert_idx >= 0 &&
         value < array[can_insert_idx]) {  // cond: O(1) #: size total: O(size)
    array[can_insert_idx + 1] = array[can_insert_idx];  // O(1)
    --can_insert_idx;                                   // O(1)
  }

  array[can_insert_idx + 1] = value;  // O(1)
  ++size;                             // O(1)
  return can_insert_idx + 1;          // O(1)
}
