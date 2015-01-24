package com.temboo.Library.Dropbox.Datastore;

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
InsertRecord

Inserts a record into a datastore table.
*/
public class InsertRecord extends Choreography {

	/**
	Create a new instance of the InsertRecord Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public InsertRecord(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Dropbox/Datastore/InsertRecord"));
	}

	/** 
	Set the value of the AccessTokenSecret input for this Choreo. 

	@param String - (required, string) The Access Token Secret retrieved during the OAuth process.
	*/
	public void setAccessTokenSecret(String value) {
		this.inputs.setInput("AccessTokenSecret", value);
	}


	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (required, string) The Access Token retrieved during the OAuth process.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the AppKey input for this Choreo. 

	@param String - (required, string) The App Key provided by Dropbox (AKA the OAuth Consumer Key).
	*/
	public void setAppKey(String value) {
		this.inputs.setInput("AppKey", value);
	}


	/** 
	Set the value of the AppSecret input for this Choreo. 

	@param String - (required, string) The App Secret provided by Dropbox (AKA the OAuth Consumer Secret).
	*/
	public void setAppSecret(String value) {
		this.inputs.setInput("AppSecret", value);
	}


	/** 
	Set the value of the Data input for this Choreo. 

	@param String - (required, json) A JSON-encoded list of name/value pairs to insert into the table.
	*/
	public void setData(String value) {
		this.inputs.setInput("Data", value);
	}


	/** 
	Set the value of the Handle input for this Choreo. 

	@param String - (required, string) The handle of an existing datastore.
	*/
	public void setHandle(String value) {
		this.inputs.setInput("Handle", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Can be set to xml or json. Defaults to json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Revision input for this Choreo. 

	@param String - (conditional, string) The revision to which to apply the delta. If not provided, the Choreo will perform a lookup for the latest revision number.
	*/
	public void setRevision(String value) {
		this.inputs.setInput("Revision", value);
	}


	/** 
	Set the value of the RowID input for this Choreo. 

	@param String - (conditional, string) The row identifier. If not provided, a randomly generated GUID will be inserted for this value.
	*/
	public void setRowID(String value) {
		this.inputs.setInput("RowID", value);
	}


	/** 
	Set the value of the Table input for this Choreo. 

	@param String - (required, string) The name of the datastore table.
	*/
	public void setTable(String value) {
		this.inputs.setInput("Table", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public InsertRecordResultSet run() {
		JSONObject result = super.runWithResults();
		return new InsertRecordResultSet(result);
	}
	
}
