package com.temboo.Library.Twitter.SuggestedUsers;

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
GetSuggestedUsers

Retrieves users in a given category of the Twitter suggested user list.
*/
public class GetSuggestedUsers extends Choreography {

	/**
	Create a new instance of the GetSuggestedUsers Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public GetSuggestedUsers(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Twitter/SuggestedUsers/GetSuggestedUsers"));
	}

	/** 
	Set the value of the AccessTokenSecret input for this Choreo. 

	@param String - (required, string) The Access Token Secret provided by Twitter or retrieved during the OAuth process.
	*/
	public void setAccessTokenSecret(String value) {
		this.inputs.setInput("AccessTokenSecret", value);
	}


	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The Access Token provided by Twitter or retrieved during the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the ConsumerKey input for this Choreo. 

	@param String - (required, string) The API Key (or Consumer Key) provided by Twitter.
	*/
	public void setConsumerKey(String value) {
		this.inputs.setInput("ConsumerKey", value);
	}


	/** 
	Set the value of the ConsumerSecret input for this Choreo. 

	@param String - (required, string) The API Secret (or Consumer Secret) provided by Twitter.
	*/
	public void setConsumerSecret(String value) {
		this.inputs.setInput("ConsumerSecret", value);
	}


	/** 
	Set the value of the Language input for this Choreo. 

	@param String - (optional, string) Restricts the suggested categories to the requested language. The language must be specified by the appropriate two letter ISO 639-1 code (e.g., en).
	*/
	public void setLanguage(String value) {
		this.inputs.setInput("Language", value);
	}


	/** 
	Set the value of the Members input for this Choreo. 

	@param Boolean - (optional, boolean) When set to true, makes a request to users/suggestions/:slug/members and retrieves the most recent statuses for users that are not protected.
	*/
	public void setMembers(Boolean value) {
		this.inputs.setInput("Members", value);
	}

	/** 
	Set the value of the Members input for this Choreo as a String. 

	@param String - (optional, boolean) When set to true, makes a request to users/suggestions/:slug/members and retrieves the most recent statuses for users that are not protected.
	*/
	public void setMembers(String value) {
		this.inputs.setInput("Members", value);	
	}
	/** 
	Set the value of the Slug input for this Choreo. 

	@param String - (required, string) The short name of  the category (e.g., news, technology, government). These are returned in the response of the GetSuggestedCategories Choreo.
	*/
	public void setSlug(String value) {
		this.inputs.setInput("Slug", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public GetSuggestedUsersResultSet run() {
		JSONObject result = super.runWithResults();
		return new GetSuggestedUsersResultSet(result);
	}
	
}
