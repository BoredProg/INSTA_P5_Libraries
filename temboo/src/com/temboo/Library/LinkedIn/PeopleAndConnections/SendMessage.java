package com.temboo.Library.LinkedIn.PeopleAndConnections;

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
SendMessage

Sends a message to a connected member given the member's personID.
*/
public class SendMessage extends Choreography {

	/**
	Create a new instance of the SendMessage Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public SendMessage(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/LinkedIn/PeopleAndConnections/SendMessage"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API Key provided by LinkedIn (AKA the OAuth Consumer Key).
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the AccessTokenSecret input for this Choreo. 

	@param String - (required, string) The Access Token Secret retrieved during the OAuth process (AKA the OAuth User Secret).
	*/
	public void setAccessTokenSecret(String value) {
		this.inputs.setInput("AccessTokenSecret", value);
	}


	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The Access Token retrieved during the OAuth process (AKA the OAuth User Token).
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the Body input for this Choreo. 

	@param String - (required, multiline) Message body. Cannot contain any HTML.
	*/
	public void setBody(String value) {
		this.inputs.setInput("Body", value);
	}


	/** 
	Set the value of the Recipients input for this Choreo. 

	@param String - (required, string) Comma-separated list of recipients by personID. For sending to 'self', put in a tilda (~). Ex.: "~",  "~,XtdrgWytGD".
	*/
	public void setRecipients(String value) {
		this.inputs.setInput("Recipients", value);
	}


	/** 
	Set the value of the SecretKey input for this Choreo. 

	@param String - (required, string) The Secret Key provided by LinkedIn (AKA the OAuth Consumer Secret).
	*/
	public void setSecretKey(String value) {
		this.inputs.setInput("SecretKey", value);
	}


	/** 
	Set the value of the Subject input for this Choreo. 

	@param String - (required, string) Subject line of message.
	*/
	public void setSubject(String value) {
		this.inputs.setInput("Subject", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public SendMessageResultSet run() {
		JSONObject result = super.runWithResults();
		return new SendMessageResultSet(result);
	}
	
}
