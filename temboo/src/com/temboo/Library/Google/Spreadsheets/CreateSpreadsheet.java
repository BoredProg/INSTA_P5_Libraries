package com.temboo.Library.Google.Spreadsheets;

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
CreateSpreadsheet

Creates a Google spreadsheet from a CSV file.
*/
public class CreateSpreadsheet extends Choreography {

	/**
	Create a new instance of the CreateSpreadsheet Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public CreateSpreadsheet(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Spreadsheets/CreateSpreadsheet"));
	}

	/** 
	Set the value of the UploadFile input for this Choreo. 

	@param String - (conditional, multiline) The data to be written to the Google spreadsheet. Should be in CSV format.
	*/
	public void setUploadFile(String value) {
		this.inputs.setInput("UploadFile", value);
	}


	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (optional, string) A valid Access Token retrieved during the OAuth process. This is required when authenticating with OAuth unless providing the ClientID, ClientSecret, and RefreshToken.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the ClientID input for this Choreo. 

	@param String - (optional, string) The Client ID provided by Google. Required when authenticating with OAuth unless providing a valid AccessToken.
	*/
	public void setClientID(String value) {
		this.inputs.setInput("ClientID", value);
	}


	/** 
	Set the value of the ClientSecret input for this Choreo. 

	@param String - (optional, string) The Client Secret provided by Google. Required when authenticating with OAuth unless providing a valid AccessToken.
	*/
	public void setClientSecret(String value) {
		this.inputs.setInput("ClientSecret", value);
	}


	/** 
	Set the value of the Password input for this Choreo. 

	@param String - (conditional, password) A Google App-specific password that you've generated after enabling 2-Step Verification. See Optional Inputs for OAuth.
	*/
	public void setPassword(String value) {
		this.inputs.setInput("Password", value);
	}


	/** 
	Set the value of the RefreshToken input for this Choreo. 

	@param String - (optional, string) An OAuth Refresh Token used to generate a new Access Token when the original token is expired. Required when authenticating with OAuth unless providing a valid AccessToken.
	*/
	public void setRefreshToken(String value) {
		this.inputs.setInput("RefreshToken", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Valid values are: xml (the default) and json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Title input for this Choreo. 

	@param String - (required, string) The name of the new document.
	*/
	public void setTitle(String value) {
		this.inputs.setInput("Title", value);
	}


	/** 
	Set the value of the Username input for this Choreo. 

	@param String - (conditional, string) Your full Google email address e.g., martha.temboo@gmail.com. See Optional Inputs for OAuth.
	*/
	public void setUsername(String value) {
		this.inputs.setInput("Username", value);
	}


	/** 
	Set the value of the WorksheetName input for this Choreo. 

	@param String - (optional, string) The name of the worksheet to be created within the spreadsheet. Defaults to "Sheet 1" when a value is not provided. When authenticating with OAuth, this parameter is ignored.
	*/
	public void setWorksheetName(String value) {
		this.inputs.setInput("WorksheetName", value);
	}


	/** 
	Set the value of the VaultCSVFile input for this Choreo. 

	@param TembooPath - (optional, vault file) The path to a CSV file stored in the vault. This is required unless you are using the UploadFile input variable. 
	*/

	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public CreateSpreadsheetResultSet run() {
		JSONObject result = super.runWithResults();
		return new CreateSpreadsheetResultSet(result);
	}
	
}
