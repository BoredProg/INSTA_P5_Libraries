package com.temboo.Library.Facebook.Searching;

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
import com.temboo.core.Choreography;
import com.temboo.core.Choreography.ResultSet;
import com.temboo.core.TembooException;
import com.temboo.core.TembooPath;
import com.temboo.core.TembooSession;

/** 
FQL

Allows you to use a SQL-style syntax to query data in the Graph API.
*/
public class FQL extends Choreography {

	/**
	Create a new instance of the FQL Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public FQL(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Facebook/Searching/FQL"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The access token retrieved from the final step of the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the Conditions input for this Choreo. 

	@param String - (required, string) The conditions to use in the WHERE clause of the FQL statement.
	*/
	public void setConditions(String value) {
		this.inputs.setInput("Conditions", value);
	}


	/** 
	Set the value of the Fields input for this Choreo. 

	@param String - (required, string) The fields to return in the response.
	*/
	public void setFields(String value) {
		this.inputs.setInput("Fields", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Can be set to xml or json. Defaults to json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Table input for this Choreo. 

	@param String - (required, string) The table to select records from.
	*/
	public void setTable(String value) {
		this.inputs.setInput("Table", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public FQLResultSet run() {
		JSONObject result = super.runWithResults();
		return new FQLResultSet(result);
	}
	
}
