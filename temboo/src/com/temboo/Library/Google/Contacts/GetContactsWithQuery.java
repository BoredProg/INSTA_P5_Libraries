package com.temboo.Library.Google.Contacts;

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
GetContactsWithQuery

Retrieves the contact or contacts in that account that match a specified query term.
*/
public class GetContactsWithQuery extends Choreography {

	/**
	Create a new instance of the GetContactsWithQuery Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public GetContactsWithQuery(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Contacts/GetContactsWithQuery"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (optional, string) The access token retrieved in the last step of the OAuth process. Access tokens that are expired will be refreshed and returned in the Choreo output.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the ClientID input for this Choreo. 

	@param String - (required, string) The OAuth client ID provided by Google when you register your application.
	*/
	public void setClientID(String value) {
		this.inputs.setInput("ClientID", value);
	}


	/** 
	Set the value of the ClientSecret input for this Choreo. 

	@param String - (required, string) The OAuth client secret provided by Google when you registered your application.
	*/
	public void setClientSecret(String value) {
		this.inputs.setInput("ClientSecret", value);
	}


	/** 
	Set the value of the Query input for this Choreo. 

	@param String - (required, string) The contact criteria to search for, such as name or email address.
	*/
	public void setQuery(String value) {
		this.inputs.setInput("Query", value);
	}


	/** 
	Set the value of the RefreshToken input for this Choreo. 

	@param String - (required, string) The refresh token retrieved in the last step of the OAuth process. This is used when an access token is expired or not provided.
	*/
	public void setRefreshToken(String value) {
		this.inputs.setInput("RefreshToken", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public GetContactsWithQueryResultSet run() {
		JSONObject result = super.runWithResults();
		return new GetContactsWithQueryResultSet(result);
	}
	
}
