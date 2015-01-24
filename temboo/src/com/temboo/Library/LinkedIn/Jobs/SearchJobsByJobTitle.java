package com.temboo.Library.LinkedIn.Jobs;

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
SearchJobsByJobTitle

Retrieve jobs matching specified job title.
*/
public class SearchJobsByJobTitle extends Choreography {

	/**
	Create a new instance of the SearchJobsByJobTitle Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public SearchJobsByJobTitle(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/LinkedIn/Jobs/SearchJobsByJobTitle"));
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
	Set the value of the Count input for this Choreo. 

	@param Integer - (optional, integer) Specify the number of jobs to be returned.  Default is 10.  The maximum is 20.
	*/
	public void setCount(Integer value) {
		this.inputs.setInput("Count", value);
	}

	/** 
	Set the value of the Count input for this Choreo as a String. 

	@param String - (optional, integer) Specify the number of jobs to be returned.  Default is 10.  The maximum is 20.
	*/
	public void setCount(String value) {
		this.inputs.setInput("Count", value);	
	}
	/** 
	Set the value of the JobTitle input for this Choreo. 

	@param Integer - (required, integer) Search by job title.
	*/
	public void setJobTitle(Integer value) {
		this.inputs.setInput("JobTitle", value);
	}

	/** 
	Set the value of the JobTitle input for this Choreo as a String. 

	@param String - (required, integer) Search by job title.
	*/
	public void setJobTitle(String value) {
		this.inputs.setInput("JobTitle", value);	
	}
	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Valid values are: xml (the default) and json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the SecretKey input for this Choreo. 

	@param String - (required, string) The Secret Key provided by LinkedIn (AKA the OAuth Consumer Secret).
	*/
	public void setSecretKey(String value) {
		this.inputs.setInput("SecretKey", value);
	}


	/** 
	Set the value of the Sort input for this Choreo. 

	@param String - (optional, string) Specify the ordering of results. Enter R (for relationship from job to member); DA (dated posted in ascending order); DO (job posted in descending order).
	*/
	public void setSort(String value) {
		this.inputs.setInput("Sort", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public SearchJobsByJobTitleResultSet run() {
		JSONObject result = super.runWithResults();
		return new SearchJobsByJobTitleResultSet(result);
	}
	
}
