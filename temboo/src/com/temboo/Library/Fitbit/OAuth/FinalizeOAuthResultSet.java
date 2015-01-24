package com.temboo.Library.Fitbit.OAuth;

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
	A ResultSet with methods tailored to the values returned by the FinalizeOAuth Choreo.
	The ResultSet object is used to retrieve the results of a Choreo execution.
*/
public  class FinalizeOAuthResultSet extends ResultSet {
		
	public FinalizeOAuthResultSet(JSONObject doc) {
		super(doc);
	}

	/** 
	Retrieve the value for the "AccessTokenSecret" output from this Choreo execution

	@return String - (string) The Access Token Secret retrieved during the OAuth process.
	*/
	public String getAccessTokenSecret() {
		return this.getResultString("AccessTokenSecret");
	}
	/** 
	Retrieve the value for the "AccessToken" output from this Choreo execution

	@return String - (string) The Access Token retrieved during the OAuth process.
	*/
	public String getAccessToken() {
		return this.getResultString("AccessToken");
	}
	/** 
	Retrieve the value for the "UserID" output from this Choreo execution

	@return String - (string) The user's encoded id associated with the access token that is being retrieved.
	*/
	public String getUserID() {
		return this.getResultString("UserID");
	}
}