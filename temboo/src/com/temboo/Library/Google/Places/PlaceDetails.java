package com.temboo.Library.Google.Places;

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
PlaceDetails

Retrieve detailed information about places retrieved by the PlaceSearch Choreo.
*/
public class PlaceDetails extends Choreography {

	/**
	Create a new instance of the PlaceDetails Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public PlaceDetails(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Places/PlaceDetails"));
	}

	/** 
	Set the value of the Key input for this Choreo. 

	@param String - (required, string) Enter your Google API key.
	*/
	public void setKey(String value) {
		this.inputs.setInput("Key", value);
	}


	/** 
	Set the value of the Language input for this Choreo. 

	@param String - (optional, string) Set the language in which to return restults.  A list of supported languages is available here: https://spreadsheets.google.com/pub?key=p9pdwsai2hDMsLkXsoM05KQ&gid=1
	*/
	public void setLanguage(String value) {
		this.inputs.setInput("Language", value);
	}


	/** 
	Set the value of the Reference input for this Choreo. 

	@param String - (required, string) Enter a textual identifier that uniquely identifies a place obtained from the PlaceSearch Choreo.
	*/
	public void setReference(String value) {
		this.inputs.setInput("Reference", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that response should be in. Can be set to xml or json. Defaults to json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Sensor input for this Choreo. 

	@param Boolean - (optional, boolean) Indicates whether or not the directions request is from a device with a location sensor. Value must be either 1 or 0. Defaults to 0 (false).
	*/
	public void setSensor(Boolean value) {
		this.inputs.setInput("Sensor", value);
	}

	/** 
	Set the value of the Sensor input for this Choreo as a String. 

	@param String - (optional, boolean) Indicates whether or not the directions request is from a device with a location sensor. Value must be either 1 or 0. Defaults to 0 (false).
	*/
	public void setSensor(String value) {
		this.inputs.setInput("Sensor", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public PlaceDetailsResultSet run() {
		JSONObject result = super.runWithResults();
		return new PlaceDetailsResultSet(result);
	}
	
}
