Class User.Foreach
  {
  // TODO: Add support for multi-dimensional arrays

  ClassMethod thing(pMes) as %Status {
    try {
      write "It worked!" _ pMes
    }
    catch(e) {
      write "thing error" _e.Name
    }
    return $$$OK
  }

  ClassMethod X() as %Status {
    try {
      set message = "Hey there"
      do ..Foreach($this, "thing", message)
    }
    catch(e) {
      write "X error" _e.Name
    }
    return $$$OK
  }

  ClassMethod Foreach(pClass, pFunc, pVal) As %Status {
    try {
      do $CLASSMETHOD(pClass, pFunc, pVal)
    }
    catch (e) {
      write "Foreach error" _e.Name
    }
    return $$$OK
  }
}
