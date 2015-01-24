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
CreateSharingPermission

Grants a new user read/write access to an existing document.
*/
public class CreateSharingPermission extends Choreography {

	/**
	Create a new instance of the CreateSharingPermission Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public CreateSharingPermission(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Documents/CreateSharingPermission"));
	}

	/** 
	Set the value of the NewUserEmail input for this Choreo. 

	@param String - (required, string) The email address of the user to whom you want to grant permission.
	*/
	public void setNewUserEmail(String value) {
		this.inputs.setInput("NewUserEmail", value);
	}


	/** 
	Set the value of the Password input for this Choreo. 

	@param String - (required, password) A Google App-specific password that you've generated after enabling 2-Step Verification.
	*/
	public void setPassword(String value) {
		this.inputs.setInput("Password", value);
	}


	/** 
	Set the value of the Role input for this Choreo. 

	@param String - (optional, string) The role that will be given to the new user permission (i.e., writer, reader, etc). Defaults to "writer".
	*/
	public void setRole(String value) {
		this.inputs.setInput("Role", value);
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
	public CreateSharingPermissionResultSet run() {
		JSONObject result = super.runWithResults();
		return new CreateSharingPermissionResultSet(result);
	}
	
}
