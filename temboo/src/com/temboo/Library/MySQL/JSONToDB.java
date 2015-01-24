package com.temboo.Library.MySQL;

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
JSONToDB

Performs a batch operation in MySQL with a set of records in JSON format.
*/
public class JSONToDB extends Choreography {

	/**
	Create a new instance of the JSONToDB Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public JSONToDB(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/MySQL/JSONToDB"));
	}

	/** 
	Set the value of the BatchFile input for this Choreo. 

	@param String - (required, json) The records to send to the database for the batch operation.
	*/
	public void setBatchFile(String value) {
		this.inputs.setInput("BatchFile", value);
	}


	/** 
	Set the value of the BatchMode input for this Choreo. 

	@param String - (optional, string) The type of batch operation to perform. Accepted values are: insert, update, or upsert.
	*/
	public void setBatchMode(String value) {
		this.inputs.setInput("BatchMode", value);
	}


	/** 
	Set the value of the DatabaseName input for this Choreo. 

	@param String - (required, string) The name of the database to connect to.
	*/
	public void setDatabaseName(String value) {
		this.inputs.setInput("DatabaseName", value);
	}


	/** 
	Set the value of the Password input for this Choreo. 

	@param String - (required, password) The password for the database user.
	*/
	public void setPassword(String value) {
		this.inputs.setInput("Password", value);
	}


	/** 
	Set the value of the Port input for this Choreo. 

	@param Integer - (optional, integer) The database port. Defaults to 3306.
	*/
	public void setPort(Integer value) {
		this.inputs.setInput("Port", value);
	}

	/** 
	Set the value of the Port input for this Choreo as a String. 

	@param String - (optional, integer) The database port. Defaults to 3306.
	*/
	public void setPort(String value) {
		this.inputs.setInput("Port", value);	
	}
	/** 
	Set the value of the RollbackOnError input for this Choreo. 

	@param Boolean - (optional, boolean) Rollback if error occurs. Set to 1 to enable. Defaults to 0 (false).
	*/
	public void setRollbackOnError(Boolean value) {
		this.inputs.setInput("RollbackOnError", value);
	}

	/** 
	Set the value of the RollbackOnError input for this Choreo as a String. 

	@param String - (optional, boolean) Rollback if error occurs. Set to 1 to enable. Defaults to 0 (false).
	*/
	public void setRollbackOnError(String value) {
		this.inputs.setInput("RollbackOnError", value);	
	}
	/** 
	Set the value of the Server input for this Choreo. 

	@param String - (required, string) The name or IP address of the database server.
	*/
	public void setServer(String value) {
		this.inputs.setInput("Server", value);
	}


	/** 
	Set the value of the TableName input for this Choreo. 

	@param String - (required, string) The database table that the batch operation is to be performed on.
	*/
	public void setTableName(String value) {
		this.inputs.setInput("TableName", value);
	}


	/** 
	Set the value of the Username input for this Choreo. 

	@param String - (required, string) The database username.
	*/
	public void setUsername(String value) {
		this.inputs.setInput("Username", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public JSONToDBResultSet run() {
		JSONObject result = super.runWithResults();
		return new JSONToDBResultSet(result);
	}
	
}
