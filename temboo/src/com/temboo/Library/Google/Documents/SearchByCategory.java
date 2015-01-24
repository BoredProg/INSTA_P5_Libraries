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
SearchByCategory

Retrieves a list of all resources in a category you specify.
*/
public class SearchByCategory extends Choreography {

	/**
	Create a new instance of the SearchByCategory Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public SearchByCategory(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Documents/SearchByCategory"));
	}

	/** 
	Set the value of the Category input for this Choreo. 

	@param String - (required, string) The category to list: "document", "spreadsheet", "presentation", "drawing", "folder", "starred", or "trashed". Combine multiple categories with "/".
	*/
	public void setCategory(String value) {
		this.inputs.setInput("Category", value);
	}


	/** 
	Set the value of the MyDocs input for this Choreo. 

	@param Boolean - (optional, boolean) Enter "true" to return resources for the requesting user only. The default is "false" (returns all account resources).
	*/
	public void setMyDocs(Boolean value) {
		this.inputs.setInput("MyDocs", value);
	}

	/** 
	Set the value of the MyDocs input for this Choreo as a String. 

	@param String - (optional, boolean) Enter "true" to return resources for the requesting user only. The default is "false" (returns all account resources).
	*/
	public void setMyDocs(String value) {
		this.inputs.setInput("MyDocs", value);	
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
	Set the value of the Viewed input for this Choreo. 

	@param Boolean - (optional, boolean) Enter "true" to return only viewed resources for the specified category. The default is "false" (viewed and unviewed category resources).
	*/
	public void setViewed(Boolean value) {
		this.inputs.setInput("Viewed", value);
	}

	/** 
	Set the value of the Viewed input for this Choreo as a String. 

	@param String - (optional, boolean) Enter "true" to return only viewed resources for the specified category. The default is "false" (viewed and unviewed category resources).
	*/
	public void setViewed(String value) {
		this.inputs.setInput("Viewed", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public SearchByCategoryResultSet run() {
		JSONObject result = super.runWithResults();
		return new SearchByCategoryResultSet(result);
	}
	
}
