Class User.SQLBuilder
{

// Runs SQL based on your parameters, and returns a json object containing the result
// This function exists so that many different, but similiar, queries can use it to 
// reduce clutter, increase reusibility, and make it easier to maintain.

// This is also an example of how to use indirection in order to programmatically create dynamic objects without knowing
// the contents of your sql result set.

ClassMethod SQLBuilder(pSelect, pFrom, pWhere) As %Status {
	try {
		// Dynamic sql definition. We take the raw parameters. It's up to you to send good values
		// First set the select mode to 2, indicating display mode for our result set
		set tSelectMode = 2
		// Instantiate the dynamic sql object
		set tStatement = ##class(%SQL.Statement).%New(tSelectMode)
		// set the size of our array that will hold the statements
		set myquery = 3
		set myquery(1) = pSelect
		set myquery(2) = pFrom
		set myquery(3) = pWhere
		// Dump the array into our prep function
		set qStatus = tStatement.%Prepare(.myquery)
		// Error handling of syntax
		if qStatus'=1 {
			write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit
		}
		// Run the query
		set rset = tStatement.%Execute()
		// Init for parent object
		set tResults = []
		// Loop through the dynamic sql
		while rSet.%Next() {
			// Init child object for holding the values
			set tRow = {}
			// The following iterates over the dynamic sql object and dynamically sets values using indirection
			set tMetadata = rSet.%GetMetadata()
			// Get size of returned object
			set tColumnCount = tMetadata.columns.Count()
			// Loop through the count
			for x=1:1:tColumnCount {
				// Get column at the current increment
				set tColumn = tMetadata.columns.GetAt(x)
				// Get column name at current increment
				set tColumnName = tColumn.colName
				// Using indirection, set the property of our object dynamically based on the name and value of the current increment
				set $PROPERTY(tRow,tColumnName) = $PROPERTY(rSet,tColumnName)
			}
			// Push the entire object to a final set of data
			do tResults.%Push(tRow)
     	}
     	// Send back to caller as json
		return tResults.%ToJSON()
	}
	catch (e) {
		write e.Name
	}
	return $$$OK
}
}
