Class User.Foreach
{
// TODO: Add support for multi-dimensional arrays

// Example of how to use the foreach functionality
ClassMethod SampleMethod() as %Status {
	try {
		// Troubleshooting vars for dynamic objects and arrays, activate as needed
		set message = {}
		set message.sidjfdf = "Dynamic 1"
		set message.sdjfs = ""
		set message.sdiofsoi = "Dynamic 2"
		/*
		set message(1) = "thing 1"
		set message(2) = "thing 2"
		*/
		// Pass the object, the function we want run, and our class location to the foreach
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
		if tIter = "" throw
		// Loop through these values and add to our query depending on their contents
		while tIter.%GetNext(.key, .value) {
			// We pass the value to the action
			// TODO: Add ability to capture value and key in a friendly way
			do $classmethod(pClass, pFunc, value)
			//write key_"='"_value_"'",!
		}
		while tIter.%GetNext(.key, .value) {
			// We pass the value to the action
			// TODO: Add ability to capture value and key in a friendly way
			do $classmethod(pClass, pFunc, value)
			//write key_"='"_value_"'",!
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
}
