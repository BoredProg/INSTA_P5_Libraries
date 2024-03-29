package com.temboo.Library.GitHub.GistsAPI.Comments;

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
CreateComment

Creates a comment for a specified gist.
*/
public class CreateComment extends Choreography {

	/**
	Create a new instance of the CreateComment Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public CreateComment(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/GitHub/GistsAPI/Comments/CreateComment"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The Access Token retrieved during the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the Body input for this Choreo. 

	@param String - (required, string) The text for the comment.
	*/
	public void setBody(String value) {
		this.inputs.setInput("Body", value);
	}


	/** 
	Set the value of the ID input for this Choreo. 

	@param String - (required, string) The id of the gist to comment on.
	*/
	public void setID(String value) {
		this.inputs.setInput("ID", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public CreateCommentResultSet run() {
		JSONObject result = super.runWithResults();
		return new CreateCommentResultSet(result);
	}
	
}
