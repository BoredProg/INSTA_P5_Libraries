package com.temboo.Library.Facebook.Publishing;

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
CreateEvent

Creates an event.
*/
public class CreateEvent extends Choreography {

	/**
	Create a new instance of the CreateEvent Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public CreateEvent(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Facebook/Publishing/CreateEvent"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The access token retrieved from the final step of the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the EndTime input for this Choreo. 

	@param String - (optional, date) The end time of the event formatted as a ISO-8601 string (i.e 2012-07-04 or 2012-07-04T19:00:00-0700).
	*/
	public void setEndTime(String value) {
		this.inputs.setInput("EndTime", value);
	}


	/** 
	Set the value of the Name input for this Choreo. 

	@param String - (required, string) The name of the event.
	*/
	public void setName(String value) {
		this.inputs.setInput("Name", value);
	}


	/** 
	Set the value of the ProfileID input for this Choreo. 

	@param String - (optional, string) The id of the profile that the event will be created for. Defaults to "me" indicating the authenticated user.
	*/
	public void setProfileID(String value) {
		this.inputs.setInput("ProfileID", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Can be set to xml or json. Defaults to json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the StartTime input for this Choreo. 

	@param String - (required, date) The start time of the event formatted as a ISO-8601 string (i.e 2012-07-04 or 2012-07-04T19:00:00-0700).
	*/
	public void setStartTime(String value) {
		this.inputs.setInput("StartTime", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public CreateEventResultSet run() {
		JSONObject result = super.runWithResults();
		return new CreateEventResultSet(result);
	}
	
}
