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
Search

Search the Freebase dataset.
*/
public class Search extends Choreography {

	/**
	Create a new instance of the Search Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public Search(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Freebase/Search"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API Key provided by Freebase.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the Domain input for this Choreo. 

	@param String - (optional, string) Enter a comma separated list of domain IDs.
	*/
	public void setDomain(String value) {
		this.inputs.setInput("Domain", value);
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
	Set the value of the Exact input for this Choreo. 

	@param Boolean - (optional, boolean) If set to true, the search query will match only the name and keys exactly. No normalization of any kind will be performed at indexing and query time.Default is set to: false.
	*/
	public void setExact(Boolean value) {
		this.inputs.setInput("Exact", value);
	}

	/** 
	Set the value of the Exact input for this Choreo as a String. 

	@param String - (optional, boolean) If set to true, the search query will match only the name and keys exactly. No normalization of any kind will be performed at indexing and query time.Default is set to: false.
	*/
	public void setExact(String value) {
		this.inputs.setInput("Exact", value);	
	}
	/** 
	Set the value of the Filter input for this Choreo. 

	@param String - (optional, string) Specify an s-expression to filter search results. For more info, see: http://wiki.freebase.com/wiki/Search_Cookbook
	*/
	public void setFilter(String value) {
		this.inputs.setInput("Filter", value);
	}


	/** 
	Set the value of the Indent input for this Choreo. 

	@param Boolean - (optional, boolean) Specify whether the JSON results should be indented, or not. Enter true, or false. Default: false.
	*/
	public void setIndent(Boolean value) {
		this.inputs.setInput("Indent", value);
	}

	/** 
	Set the value of the Indent input for this Choreo as a String. 

	@param String - (optional, boolean) Specify whether the JSON results should be indented, or not. Enter true, or false. Default: false.
	*/
	public void setIndent(String value) {
		this.inputs.setInput("Indent", value);	
	}
	/** 
	Set the value of the Language input for this Choreo. 

	@param String - (optional, string) Specify the language in which the searches will be performed.  Default is set to English: /lang/en
	*/
	public void setLanguage(String value) {
		this.inputs.setInput("Language", value);
	}


	/** 
	Set the value of the Limit input for this Choreo. 

	@param Integer - (optional, integer) Specify the number of results to be retrieved.  Default: 20.
	*/
	public void setLimit(Integer value) {
		this.inputs.setInput("Limit", value);
	}

	/** 
	Set the value of the Limit input for this Choreo as a String. 

	@param String - (optional, integer) Specify the number of results to be retrieved.  Default: 20.
	*/
	public void setLimit(String value) {
		this.inputs.setInput("Limit", value);	
	}
	/** 
	Set the value of the MQLOutput input for this Choreo. 

	@param String - (optional, string) Enter an MQL query to extract entity information.
	*/
	public void setMQLOutput(String value) {
		this.inputs.setInput("MQLOutput", value);
	}


	/** 
	Set the value of the Prefixed input for this Choreo. 

	@param Boolean - (optional, boolean) Specify whether or not search queries are to match results by name prefix. Default value: false.
	*/
	public void setPrefixed(Boolean value) {
		this.inputs.setInput("Prefixed", value);
	}

	/** 
	Set the value of the Prefixed input for this Choreo as a String. 

	@param String - (optional, boolean) Specify whether or not search queries are to match results by name prefix. Default value: false.
	*/
	public void setPrefixed(String value) {
		this.inputs.setInput("Prefixed", value);	
	}
	/** 
	Set the value of the Query input for this Choreo. 

	@param String - (required, string) Enter a search query.
	*/
	public void setQuery(String value) {
		this.inputs.setInput("Query", value);
	}


	/** 
	Set the value of the Start input for this Choreo. 

	@param Integer - (optional, integer) Enter a value to page through results.  Default is set to 0.
	*/
	public void setStart(Integer value) {
		this.inputs.setInput("Start", value);
	}

	/** 
	Set the value of the Start input for this Choreo as a String. 

	@param String - (optional, integer) Enter a value to page through results.  Default is set to 0.
	*/
	public void setStart(String value) {
		this.inputs.setInput("Start", value);	
	}
	/** 
	Set the value of the Type input for this Choreo. 

	@param String - (optional, string) Enter a comma-seperated list of type IDs.
	*/
	public void setType(String value) {
		this.inputs.setInput("Type", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public SearchResultSet run() {
		JSONObject result = super.runWithResults();
		return new SearchResultSet(result);
	}
	
}
