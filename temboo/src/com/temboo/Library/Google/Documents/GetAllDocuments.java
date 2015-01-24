package com.temboo.Library.Google.Documents;

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
GetAllDocuments

Retrieves a list of all documents, files, and collections in a Google account.
*/
public class GetAllDocuments extends Choreography {

	/**
	Create a new instance of the GetAllDocuments Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public GetAllDocuments(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Documents/GetAllDocuments"));
	}

	/** 
	Set the value of the Deleted input for this Choreo. 

	@param Boolean - (optional, boolean) Returns deleted documents when set to "true" (the default). Skips deleted documents when set to "false".
	*/
	public void setDeleted(Boolean value) {
		this.inputs.setInput("Deleted", value);
	}

	/** 
	Set the value of the Deleted input for this Choreo as a String. 

	@param String - (optional, boolean) Returns deleted documents when set to "true" (the default). Skips deleted documents when set to "false".
	*/
	public void setDeleted(String value) {
		this.inputs.setInput("Deleted", value);	
	}
	/** 
	Set the value of the Password input for this Choreo. 

	@param String - (required, password) A Google App-specific password that you've generated after enabling 2-Step Verification.
	*/
	public void setPassword(String value) {
		this.inputs.setInput("Password", value);
	}


	/** 
	Set the value of the Username input for this Choreo. 

	@param String - (required, string) Your full Google email address e.g., martha.temboo@gmail.com.
	*/
	public void setUsername(String value) {
		this.inputs.setInput("Username", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public GetAllDocumentsResultSet run() {
		JSONObject result = super.runWithResults();
		return new GetAllDocumentsResultSet(result);
	}
	
}
