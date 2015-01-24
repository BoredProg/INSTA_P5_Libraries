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
PublishNote

Publishes a note on a given profile.
*/
public class PublishNote extends Choreography {

	/**
	Create a new instance of the PublishNote Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public PublishNote(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Facebook/Publishing/PublishNote"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The access token retrieved from the final step of the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the Message input for this Choreo. 

	@param String - (required, string) The contents of the note.
	*/
	public void setMessage(String value) {
		this.inputs.setInput("Message", value);
	}


	/** 
	Set the value of the ProfileID input for this Choreo. 

	@param String - (optional, string) The id of the profile that the note will be published to. Defaults to "me" indicating the authenticated user.
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
	Set the value of the Subject input for this Choreo. 

	@param String - (required, string) A subject line for the note being created.
	*/
	public void setSubject(String value) {
		this.inputs.setInput("Subject", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public PublishNoteResultSet run() {
		JSONObject result = super.runWithResults();
		return new PublishNoteResultSet(result);
	}
	
}
