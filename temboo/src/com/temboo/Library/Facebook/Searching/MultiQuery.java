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
MultiQuery

Allows you to submit multiple FQL statements and retrieve all the results you need in one request.
*/
public class MultiQuery extends Choreography {

	/**
	Create a new instance of the MultiQuery Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public MultiQuery(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Facebook/Searching/MultiQuery"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The access token retrieved from the final step of the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the Queries input for this Choreo. 

	@param String - (required, json) A JSON dictionary containing multiple queries to execute. See documentation for formatting examples.
	*/
	public void setQueries(String value) {
		this.inputs.setInput("Queries", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Can be set to xml or json. Defaults to json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public MultiQueryResultSet run() {
		JSONObject result = super.runWithResults();
		return new MultiQueryResultSet(result);
	}
	
}
