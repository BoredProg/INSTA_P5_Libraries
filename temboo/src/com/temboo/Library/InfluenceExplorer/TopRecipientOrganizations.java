package com.temboo.Library.InfluenceExplorer;

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
TopRecipientOrganizations

Returns the top organizations to which the specified individual has given money.
*/
public class TopRecipientOrganizations extends Choreography {

	/**
	Create a new instance of the TopRecipientOrganizations Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public TopRecipientOrganizations(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/InfluenceExplorer/TopRecipientOrganizations"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API key provided by Sunlight Data Services.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the EntityID input for this Choreo. 

	@param String - (required, string) The ID for the Entity that you want to return information for. This ID can be retrieved by running the SearchByName Choreo.
	*/
	public void setEntityID(String value) {
		this.inputs.setInput("EntityID", value);
	}


	/** 
	Set the value of the Limit input for this Choreo. 

	@param Integer - (optional, integer) The number of resutls to return.
	*/
	public void setLimit(Integer value) {
		this.inputs.setInput("Limit", value);
	}

	/** 
	Set the value of the Limit input for this Choreo as a String. 

	@param String - (optional, integer) The number of resutls to return.
	*/
	public void setLimit(String value) {
		this.inputs.setInput("Limit", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public TopRecipientOrganizationsResultSet run() {
		JSONObject result = super.runWithResults();
		return new TopRecipientOrganizationsResultSet(result);
	}
	
}
