package com.temboo.Library.MySQL;

/*
Copyright 2014 Temboo, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import processing.data.JSONArray;
import processing.data.JSONObject;
import java.math.BigDecimal;
import com.temboo.core.Choreography.ResultSet;

	
/**
	A ResultSet with methods tailored to the values returned by the ParameterizedQuery Choreo.
	The ResultSet object is used to retrieve the results of a Choreo execution.
*/
public  class ParameterizedQueryResultSet extends ResultSet {
		
	public ParameterizedQueryResultSet(JSONObject doc) {
		super(doc);
	}

	/** 
	Retrieve the value for the "ResultData" output from this Choreo execution

	@return String - The data returned from the database. This output will only contain a value when a SELECT, SHOW, or DESCRIBE statement is provided. Results are returned as JSON or XML depending on the ResponseFormat.
	*/
	public String getResultData() {
		return this.getResultString("ResultData");
	}
	/** 
	Retrieve the value for the "Success" output from this Choreo execution

	@return String - (boolean) Indicates the result of the database command. The value will be "true" when the SQL statement executes successfully.
	*/
	public String getSuccess() {
		return this.getResultString("Success");
	}
}