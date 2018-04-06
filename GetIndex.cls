/// Give a one-dimensional array as a ByRef and a value to find, and receive the first occurrence of its element position as an integer.
/// This currently saves approximately 6 lines of code per use in a class.
/// Input: ByRef Array + Value
/// Output: Position integer
/// Example: set element = GetIndex(.array, "Value"), element will = # of first found index, 0 if not found, and -1 if invalid params
// TODO: Add support for multi-dimensional arrays
ClassMethod GetIndex(ByRef pArray, pFind) As %Integer {
  try {
    // Element position init
    set tStruct=""
    // Loop through the array
      for {
        // Go to the next element
        set tStruct=$order(pArray(tStruct))
        quit:tStruct=""
        if pArray(tStruct) = pFind {
          // Return element position if the value equals the input filter
          return tStruct
        }
      }
  }
  catch (e) {
    // It failed due to the object being invalid
    return 0
  }
  // If we didn't find the value, indicate negative index
  return -1
}
