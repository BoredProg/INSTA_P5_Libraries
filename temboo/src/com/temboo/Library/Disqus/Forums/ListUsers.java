package com.temboo.Library.Disqus.Forums;

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
ListUsers

Retrieve a list of active users within a forum.
*/
public class ListUsers extends Choreography {

	/**
	Create a new instance of the ListUsers Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public ListUsers(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Disqus/Forums/ListUsers"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (optional, string) A valid OAuth 2.0 access token.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the Cursor input for this Choreo. 

	@param String - (optional, string) Default is set to null.
	*/
	public void setCursor(String value) {
		this.inputs.setInput("Cursor", value);
	}


	/** 
	Set the value of the Forum input for this Choreo. 

	@param String - (required, string) Forum Short Name (i.e., the subdomain of the Disqus Site URL).  Displays all users contained in that  forum.  If null, users from all forums moderated by the authenticating user will be retrieved.
	*/
	public void setForum(String value) {
		this.inputs.setInput("Forum", value);
	}


	/** 
	Set the value of the Limit input for this Choreo. 

	@param Integer - (optional, integer) The number of records to return. Defaults to 25.
	*/
	public void setLimit(Integer value) {
		this.inputs.setInput("Limit", value);
	}

	/** 
	Set the value of the Limit input for this Choreo as a String. 

	@param String - (optional, integer) The number of records to return. Defaults to 25.
	*/
	public void setLimit(String value) {
		this.inputs.setInput("Limit", value);	
	}
	/** 
	Set the value of the Order input for this Choreo. 

	@param String - (optional, string) The sort order of the results. Valid values are: asc or desc. Default is set to: asc.
	*/
	public void setOrder(String value) {
		this.inputs.setInput("Order", value);
	}


	/** 
	Set the value of the PublicKey input for this Choreo. 

	@param String - (required, string) The Public Key provided by Disqus (AKA the API Key).
	*/
	public void setPublicKey(String value) {
		this.inputs.setInput("PublicKey", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Valid values are: json (the default), jsonp, or rss.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the SinceID input for this Choreo. 

	@param String - (optional, string) A Unix timestamp (or ISO datetime standard) to obtain results from. (e.g. 2014-02-02T01:01:00Z) Default is set to null.
	*/
	public void setSinceID(String value) {
		this.inputs.setInput("SinceID", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public ListUsersResultSet run() {
		JSONObject result = super.runWithResults();
		return new ListUsersResultSet(result);
	}
	
}