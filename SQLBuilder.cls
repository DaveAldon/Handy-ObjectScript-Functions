Class User.SQLBuilder
{
/// Runs SQL based on your parameters, and returns a json object containing the result. This function exists so that many different, but similiar, queries can use it
/// to reduce clutter, increase reusibility, and make it easier to maintain.
ClassMethod SQLBuilder(pSelect, pFrom, pWhere) As %Status {
	try {
		// Dynamic sql definition. We take the raw parameters. It's up to you to send good values
		SET tStatement = ##class(%SQL.Statement).%New()
		SET myquery = 3
		SET myquery(1) = pSelect
		SET myquery(2) = pFrom
		SET myquery(3) = pWhere
		SET qStatus = tStatement.%Prepare(.myquery)
		IF qStatus'=1 {
			WRITE "%Prepare failed:" DO $System.Status.DisplayError(qStatus) QUIT
		}
		// Run the query
		set rSet = tStatement.%Execute()
		// Init for parent object
		set tResults = []
		// Loop through the dynamic sql
		WHILE rSet.%Next() {
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
		return tResults.%ToJSON()
	}
	catch (e) {
		write e.Name
	}
}
}
