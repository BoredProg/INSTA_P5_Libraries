package com.temboo.Library.Freebase;

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
Text

Access Freebase topic and schema descriptions.
*/
public class Text extends Choreography {

	/**
	Create a new instance of the Text Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public Text(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Freebase/Text"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API Key provided by Freebase.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the Format input for this Choreo. 

	@param Boolean - (optional, boolean) Specify the retrieved results format.  Enter, html, plan, or raw. Default is set to: raw
	*/
	public void setFormat(Boolean value) {
		this.inputs.setInput("Format", value);
	}

	/** 
	Set the value of the Format input for this Choreo as a String. 

	@param String - (optional, boolean) Specify the retrieved results format.  Enter, html, plan, or raw. Default is set to: raw
	*/
	public void setFormat(String value) {
		this.inputs.setInput("Format", value);	
	}
	/** 
	Set the value of the ID input for this Choreo. 

	@param String - (required, string) Enter the ID of the entity for which description information will be retrieved. IDs and MIDs can be obtained by running the Search Choreo in this bundle. Example input: /en/bob_dylan
	*/
	public void setID(String value) {
		this.inputs.setInput("ID", value);
	}


	/** 
	Set the value of the Language input for this Choreo. 

	@param String - (optional, string) Specify the language in which the searches will be performed. Default is set to English: /lang/en
	*/
	public void setLanguage(String value) {
		this.inputs.setInput("Language", value);
	}


	/** 
	Set the value of the MaximumLength input for this Choreo. 

	@param Integer - (optional, integer) Enter the max number of characters to return with the rage of 0 - 4,294,967,295. Valid only for plan Format. Default is to: 200
	*/
	public void setMaximumLength(Integer value) {
		this.inputs.setInput("MaximumLength", value);
	}

	/** 
	Set the value of the MaximumLength input for this Choreo as a String. 

	@param String - (optional, integer) Enter the max number of characters to return with the rage of 0 - 4,294,967,295. Valid only for plan Format. Default is to: 200
	*/
	public void setMaximumLength(String value) {
		this.inputs.setInput("MaximumLength", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public TextResultSet run() {
		JSONObject result = super.runWithResults();
		return new TextResultSet(result);
	}
	
}
