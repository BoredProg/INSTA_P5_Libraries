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
UploadFile

Uploads MS Word, Excel, or plain text documents to a Google account.
*/
public class UploadFile extends Choreography {

	/**
	Create a new instance of the UploadFile Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public UploadFile(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Documents/UploadFile"));
	}

	/** 
	Set the value of the FileContents input for this Choreo. 

	@param String - (conditional, string) The base64-encoded contents of the file you want to upload. Required unless using the VaultFile alias input (an advnaced option used when running Choreos in the Temboo Designer).
	*/
	public void setFileContents(String value) {
		this.inputs.setInput("FileContents", value);
	}


	/** 
	Set the value of the ContentType input for this Choreo. 

	@param String - (required, string) Enter the content type for the file. Currently, the supported content types are: application/pdf, application/rtf, application/msword, application/vnd.ms-excel, text/plain, and text/csv.
	*/
	public void setContentType(String value) {
		this.inputs.setInput("ContentType", value);
	}


	/** 
	Set the value of the Password input for this Choreo. 

	@param String - (required, password) A Google App-specific password that you've generated after enabling 2-Step Verification.
	*/
	public void setPassword(String value) {
		this.inputs.setInput("Password", value);
	}


	/** 
	Set the value of the Title input for this Choreo. 

	@param String - (required, string) The name for the file you're uploading.
	*/
	public void setTitle(String value) {
		this.inputs.setInput("Title", value);
	}


	/** 
	Set the value of the Username input for this Choreo. 

	@param String - (required, string) Your full Google email address e.g., martha.temboo@gmail.com.
	*/
	public void setUsername(String value) {
		this.inputs.setInput("Username", value);
	}


	/** 
	Set the value of the VaultFile input for this Choreo. 

	@param TembooPath - The path to the Vault file to upload. Required unless using the FileContents input variable instead.
	*/

	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public UploadFileResultSet run() {
		JSONObject result = super.runWithResults();
		return new UploadFileResultSet(result);
	}
	
}
