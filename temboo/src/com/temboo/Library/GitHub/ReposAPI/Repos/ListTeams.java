package com.temboo.Library.GitHub.ReposAPI.Repos;

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
ListTeams

Retrieves a list of teams for the specified repository.
*/
public class ListTeams extends Choreography {

	/**
	Create a new instance of the ListTeams Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public ListTeams(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/GitHub/ReposAPI/Repos/ListTeams"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The Access Token retrieved during the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the Repo input for this Choreo. 

	@param String - (required, string) The name of the repo to list teams for.
	*/
	public void setRepo(String value) {
		this.inputs.setInput("Repo", value);
	}


	/** 
	Set the value of the User input for this Choreo. 

	@param String - (required, string) The GitHub username.
	*/
	public void setUser(String value) {
		this.inputs.setInput("User", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public ListTeamsResultSet run() {
		JSONObject result = super.runWithResults();
		return new ListTeamsResultSet(result);
	}
	
}
