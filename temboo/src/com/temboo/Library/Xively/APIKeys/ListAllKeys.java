package com.temboo.Library.Xively.APIKeys;

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
ListAllKeys

Returns a JSON or XML representation of all of the user's keys.
*/
public class ListAllKeys extends Choreography {

	/**
	Create a new instance of the ListAllKeys Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public ListAllKeys(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Xively/APIKeys/ListAllKeys"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The master API Key for which you would like to return a list of all the user's keys.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Valid values are "json" (the default) and "xml".
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public ListAllKeysResultSet run() {
		JSONObject result = super.runWithResults();
		return new ListAllKeysResultSet(result);
	}
	
}
