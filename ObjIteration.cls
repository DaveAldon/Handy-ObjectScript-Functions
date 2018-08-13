Class User.ObjIteration
{
  /// Builds the search query dynamically based on a dynamic object passed in that holds the parameters
  ClassMethod BuildSearch(ByRef pSet As %DynamicObject) As %Status
  {
    set pSet = {}
    set pSet.username = "somebody"
    set pSet.children = {}
    set pSet.children.a = "child 1"
    set pSet.children.b = "child 2"
    set pSet.thing = "stuff"

    set obj = pSet.%GetIterator()
    while obj.%GetNext(.key, .val) {
      try {
        set objs = val.%GetIterator()
        set tQuery = tQuery_" and "_key_" in ("
        while objs.%GetNext(.keys, .vals) {	
          set tQuery = tQuery_"'"_vals_"',"
        }
        set tQuery = $zstrip(tQuery,">",",")_")"
        continue
      }
      catch(e) {}
      set tQuery = tQuery_" and "_key_" = '"_val_"'"
    }

    // Run query...
  }
}
