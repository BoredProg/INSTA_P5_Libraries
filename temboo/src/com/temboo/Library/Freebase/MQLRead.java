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
MQLRead

Search the Freebase dataset using the Metaweb query language (MQL).
*/
public class MQLRead extends Choreography {

	/**
	Create a new instance of the MQLRead Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public MQLRead(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Freebase/MQLRead"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API Key provided by Freebase.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the AsOfTime input for this Choreo. 

	@param String - (optional, string) Run a query as it would have run at a specific point in time. Timestamps must be entered in the following format: 2007-01-09T22, or 2007-02.
	*/
	public void setAsOfTime(String value) {
		this.inputs.setInput("AsOfTime", value);
	}


	/** 
	Set the value of the Cost input for this Choreo. 

	@param Boolean - (optional, boolean) If cost is set to true, a key is returned in the results, indicating the computational cost incurred by lower levels of the service. Default value: false
	*/
	public void setCost(Boolean value) {
		this.inputs.setInput("Cost", value);
	}

	/** 
	Set the value of the Cost input for this Choreo as a String. 

	@param String - (optional, boolean) If cost is set to true, a key is returned in the results, indicating the computational cost incurred by lower levels of the service. Default value: false
	*/
	public void setCost(String value) {
		this.inputs.setInput("Cost", value);	
	}
	/** 
	Set the value of the Cursor input for this Choreo. 

	@param String - (optional, string) If set. results can be paged.  See examples at: http://wiki.freebase.com/wiki/MQL_Read_Service
	*/
	public void setCursor(String value) {
		this.inputs.setInput("Cursor", value);
	}


	/** 
	Set the value of the EscapeHTMLResults input for this Choreo. 

	@param Boolean - (optional, boolean) Specify whether html results are to be escaped or not.  Default is set to: true.
	*/
	public void setEscapeHTMLResults(Boolean value) {
		this.inputs.setInput("EscapeHTMLResults", value);
	}

	/** 
	Set the value of the EscapeHTMLResults input for this Choreo as a String. 

	@param String - (optional, boolean) Specify whether html results are to be escaped or not.  Default is set to: true.
	*/
	public void setEscapeHTMLResults(String value) {
		this.inputs.setInput("EscapeHTMLResults", value);	
	}
	/** 
	Set the value of the Indent input for this Choreo. 

	@param Boolean - (optional, boolean) Specify whether the JSON results should be indented, or not. Enter true, or false. Default: false. Range of values: 0-10.
	*/
	public void setIndent(Boolean value) {
		this.inputs.setInput("Indent", value);
	}

	/** 
	Set the value of the Indent input for this Choreo as a String. 

	@param String - (optional, boolean) Specify whether the JSON results should be indented, or not. Enter true, or false. Default: false. Range of values: 0-10.
	*/
	public void setIndent(String value) {
		this.inputs.setInput("Indent", value);	
	}
	/** 
	Set the value of the Language input for this Choreo. 

	@param String - (optional, string) Specify the language in which the searches will be performed.  Multiple languages can be specified. Default is: /lang/en
	*/
	public void setLanguage(String value) {
		this.inputs.setInput("Language", value);
	}


	/** 
	Set the value of the Query input for this Choreo. 

	@param String - (required, string) Enter a search query  in a valid MQL JSON format.
	*/
	public void setQuery(String value) {
		this.inputs.setInput("Query", value);
	}


	/** 
	Set the value of the UniqenessFailure input for this Choreo. 

	@param String - (optional, string) Specify how MQL responds to uniqueness failures. Enter hard, or soft.  Default is set to: hard.
	*/
	public void setUniqenessFailure(String value) {
		this.inputs.setInput("UniqenessFailure", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public MQLReadResultSet run() {
		JSONObject result = super.runWithResults();
		return new MQLReadResultSet(result);
	}
	
}
