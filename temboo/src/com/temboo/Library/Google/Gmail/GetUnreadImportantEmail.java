package com.temboo.Library.Google.Gmail;

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
GetUnreadImportantEmail

Allows you to access a read-only Gmail feed that contains a list of unread emails that are marked important.
*/
public class GetUnreadImportantEmail extends Choreography {

	/**
	Create a new instance of the GetUnreadImportantEmail Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public GetUnreadImportantEmail(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Gmail/GetUnreadImportantEmail"));
	}

	/** 
	Set the value of the Password input for this Choreo. 

	@param String - (required, password) A Google App-specific password that you've generated after enabling 2-Step Verification. See the Gmailv2 bundle for OAuth.
	*/
	public void setPassword(String value) {
		this.inputs.setInput("Password", value);
	}


	/** 
	Set the value of the ResponseMode input for this Choreo. 

	@param String - (optional, string) Used to simplify the response. Valid values are: simple and verbose. When set to simple, only the message string is returned. Verbose mode returns the full object. Defaults to "simple".
	*/
	public void setResponseMode(String value) {
		this.inputs.setInput("ResponseMode", value);
	}


	/** 
	Set the value of the Username input for this Choreo. 

	@param String - (required, string) Your full Google email address e.g., martha.temboo@gmail.com. See the Gmailv2 bundle for OAuth.
	*/
	public void setUsername(String value) {
		this.inputs.setInput("Username", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public GetUnreadImportantEmailResultSet run() {
		JSONObject result = super.runWithResults();
		return new GetUnreadImportantEmailResultSet(result);
	}
	
}
