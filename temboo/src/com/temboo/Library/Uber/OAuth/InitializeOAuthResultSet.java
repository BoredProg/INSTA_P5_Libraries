package com.temboo.Library.Uber.OAuth;

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
	A ResultSet with methods tailored to the values returned by the InitializeOAuth Choreo.
	The ResultSet object is used to retrieve the results of a Choreo execution.
*/
public  class InitializeOAuthResultSet extends ResultSet {
		
	public InitializeOAuthResultSet(JSONObject doc) {
		super(doc);
	}

	/** 
	Retrieve the value for the "AuthorizationURL" output from this Choreo execution

	@return String - (string) The authorization URL that the application's user needs to go to in order to grant access to your application.
	*/
	public String getAuthorizationURL() {
		return this.getResultString("AuthorizationURL");
	}
	/** 
	Retrieve the value for the "CallbackID" output from this Choreo execution

	@return String - (string) An ID used to retrieve the callback data that Temboo stores once your application's user authorizes.
	*/
	public String getCallbackID() {
		return this.getResultString("CallbackID");
	}
}