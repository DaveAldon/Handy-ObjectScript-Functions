Class User.Foreach
{
// TODO: Add support for multi-dimensional arrays

// Example of how to use the foreach functionality
ClassMethod SampleMethod() as %Status {
	try {
		//set message = {}
		set message(1) = "thing 1"
		set message(2) = "thing 2"
		do ..Foreach(.message, "Action", $this)
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

ClassMethod Foreach(ByRef pVal, pFunc, pClass) As %Status {
	try {
		// We get the key value pairs from our dynamic object
		set tIter = pVal.%GetIterator()
		// Loop through these values and add to our query depending on their contents
		while tIter.%GetNext(.key, .value) {
			if value '= "" {
				// We pass the value to the action
				// TODO: Add ability to capture value and key in a friendly way
				do $classmethod(pClass, pFunc, value)
				//write key_"='"_value_"'",!
			}
		}
	}
	catch (e) {
		try {
			// Element position init
		    set tStruct=""
		    // Loop through the array
		    for {
			    set tStruct=$order(pVal(tStruct))
			    quit:tStruct=""
			    // Perform our action method on each element
			    do $classmethod(pClass, pFunc, pVal(tStruct))
			}
		}
		catch (e) {
			write "Foreach error " _e.Name
		}
	}
	return $$$OK
}

// Iteration over an object
ClassMethod Foreachs(ByRef pVal, pFunc, pClass) As %Status {
	try {
	    // Element position init
	    set tStruct=""
	    // Loop through the array
	    for {
		    set tStruct=$order(pVal(tStruct))
		    quit:tStruct=""
		    // Perform our action method on each element
		    do $classmethod(pClass, pFunc, pVal(tStruct))
		}
	}
	catch (e) {
		write "Foreach error " _e.Name
	}
	return $$$OK
}
}
