Class User.SQLInjection
{

// Some simple functions to sanitize different parts of a query

/// Scrubs a string of harmful characters, and any extra characters we pass
ClassMethod SQLiHandlerValue(pQueryString, pOptional As %String = "") As %String
{
	set pQueryString = $replace(pQueryString,"SELECT","ILLEGALVALUE")
	set pQueryString = $replace(pQueryString,"select","ILLEGALVALUE")
	// Removes anything that isn't a letter, number, whitespace
	return $zstrip(pQueryString,"*E'A'N'W",,pOptional)
}

/// Scrubs a string of everything but numerical characters, and any extra characters we pass
ClassMethod SQLiHandlerNumber(pQueryString, pOptional As %String = "") As %String
{
	// Removes anything that isn't a number
	return $zstrip(pQueryString,"*E'N",,pOptional)
}

/// Takes in a field name and checks it in a table of safe values. Helpful if the user needs rights to the field but only when we want
ClassMethod SQLiHandlerKey(pQueryString) As %String
{
	set acceptableList = ["some","fieldname"]
	set iter = acceptableList.%GetIterator()
	set outputKey = "ILLEGALVALUE"
	while iter.%GetNext(.key, .value) {
		if pQueryString = value set outputKey = value
	}
	return outputKey
}

}
