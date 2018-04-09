Class User.Foreach
{
// TODO: Add support for multi-dimensional arrays

// Example of how to use the foreach functionality
ClassMethod SampleMethod() as %Status {
	try {
		set message(1) = "Hey there"
		set message(2) = "Hey thereeee"
		do ..Foreach($this, "Action", .message)
	}
	catch(e) {
		write "SampleMethod error" _e.Name
	}
	return $$$OK
}

// A method that is called on each iteration
ClassMethod Action(pMes) as %Status {
	try {
		write pMes, !
	}
	catch(e) {
		write "Action error " _e.Name
	}
	return $$$OK
}

// Iteration over an object
ClassMethod Foreach(pClass, pFunc, ByRef pVal) As %Status {
	try {
	    // Element position init
	    set tStruct=""
	    // Loop through the array
	    for {
		    set tStruct=$order(pVal(tStruct))
		    quit:tStruct=""
		    // Perform our action method on each element
		    do $CLASSMETHOD(pClass, pFunc, pVal(tStruct))
		}
	}
	catch (e) {
		write "Foreach error " _e.Name
	}
	return $$$OK
}
}
