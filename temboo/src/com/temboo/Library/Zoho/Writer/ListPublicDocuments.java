package com.temboo.Library.Zoho.Writer;

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
ListPublicDocuments

Lists all the documents that have been made "public" from a user's Zoho Writer Account.
*/
public class ListPublicDocuments extends Choreography {

	/**
	Create a new instance of the ListPublicDocuments Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public ListPublicDocuments(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Zoho/Writer/ListPublicDocuments"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API Key provided by Zoho
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the Limit input for this Choreo. 

	@param Integer - (optional, integer) Sets the number of documents to be listed.
	*/
	public void setLimit(Integer value) {
		this.inputs.setInput("Limit", value);
	}

	/** 
	Set the value of the Limit input for this Choreo as a String. 

	@param String - (optional, integer) Sets the number of documents to be listed.
	*/
	public void setLimit(String value) {
		this.inputs.setInput("Limit", value);	
	}
	/** 
	Set the value of the LoginID input for this Choreo. 

	@param String - (required, string) Your Zoho username (or login id)
	*/
	public void setLoginID(String value) {
		this.inputs.setInput("LoginID", value);
	}


	/** 
	Set the value of the OrderBy input for this Choreo. 

	@param String - (optional, string) Order documents by createdTime, lastModifiedTime or name.
	*/
	public void setOrderBy(String value) {
		this.inputs.setInput("OrderBy", value);
	}


	/** 
	Set the value of the Password input for this Choreo. 

	@param String - (required, password) Your Zoho password
	*/
	public void setPassword(String value) {
		this.inputs.setInput("Password", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that response should be in. Can be set to xml or json. Defaults to xml.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the SortOrder input for this Choreo. 

	@param String - (optional, string) Sorting order: asc or desc. Default sort order is set to ascending.
	*/
	public void setSortOrder(String value) {
		this.inputs.setInput("SortOrder", value);
	}


	/** 
	Set the value of the StartFrom input for this Choreo. 

	@param Integer - (optional, integer) Sets the initial document number from which the documents will be listed.
	*/
	public void setStartFrom(Integer value) {
		this.inputs.setInput("StartFrom", value);
	}

	/** 
	Set the value of the StartFrom input for this Choreo as a String. 

	@param String - (optional, integer) Sets the initial document number from which the documents will be listed.
	*/
	public void setStartFrom(String value) {
		this.inputs.setInput("StartFrom", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public ListPublicDocumentsResultSet run() {
		JSONObject result = super.runWithResults();
		return new ListPublicDocumentsResultSet(result);
	}
	
}
