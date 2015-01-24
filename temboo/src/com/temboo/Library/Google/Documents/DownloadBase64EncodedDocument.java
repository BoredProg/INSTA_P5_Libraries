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
DownloadBase64EncodedDocument

Downloads a document with the title you specify, and returns the content as Base64 encoded data.
*/
public class DownloadBase64EncodedDocument extends Choreography {

	/**
	Create a new instance of the DownloadBase64EncodedDocument Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public DownloadBase64EncodedDocument(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Documents/DownloadBase64EncodedDocument"));
	}

	/** 
	Set the value of the Format input for this Choreo. 

	@param String - (optional, string) The format you want to export the document to, such as "doc", "txt", "pdf", etc.
	*/
	public void setFormat(String value) {
		this.inputs.setInput("Format", value);
	}


	/** 
	Set the value of the Link input for this Choreo. 

	@param String - (conditional, string) Enter the source links for the document to be retrieved. Required unless specifying the Title.
	*/
	public void setLink(String value) {
		this.inputs.setInput("Link", value);
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

	@param String - (conditional, string) The title of the document to download. Required unless specifying the download Link.
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
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public DownloadBase64EncodedDocumentResultSet run() {
		JSONObject result = super.runWithResults();
		return new DownloadBase64EncodedDocumentResultSet(result);
	}
	
}
