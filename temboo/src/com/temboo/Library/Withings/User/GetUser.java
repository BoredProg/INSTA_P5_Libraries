package com.temboo.Library.Withings.User;

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
GetUser

Retrieves information regarding the specified user.
*/
public class GetUser extends Choreography {

	/**
	Create a new instance of the GetUser Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public GetUser(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Withings/User/GetUser"));
	}

	/** 
	Set the value of the AccessTokenSecret input for this Choreo. 

	@param String - (required, string) The Access Token Secret retrieved during the OAuth process.
	*/
	public void setAccessTokenSecret(String value) {
		this.inputs.setInput("AccessTokenSecret", value);
	}


	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The Access Token retrieved during the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the ConsumerKey input for this Choreo. 

	@param String - (required, string) The Consumer Key provided by Withings.
	*/
	public void setConsumerKey(String value) {
		this.inputs.setInput("ConsumerKey", value);
	}


	/** 
	Set the value of the ConsumerSecret input for this Choreo. 

	@param String - (required, string) The Consumer Secret provided by Withings.
	*/
	public void setConsumerSecret(String value) {
		this.inputs.setInput("ConsumerSecret", value);
	}


	/** 
	Set the value of the UserID input for this Choreo. 

	@param String - (required, string) The ID of the user to retrieve.
	*/
	public void setUserID(String value) {
		this.inputs.setInput("UserID", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public GetUserResultSet run() {
		JSONObject result = super.runWithResults();
		return new GetUserResultSet(result);
	}
	
}
