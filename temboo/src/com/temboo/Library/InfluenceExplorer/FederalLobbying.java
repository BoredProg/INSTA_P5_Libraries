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
FederalLobbying

Obtain detailed lobbying information.
*/
public class FederalLobbying extends Choreography {

	/**
	Create a new instance of the FederalLobbying Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public FederalLobbying(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/InfluenceExplorer/FederalLobbying"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API key provided by Sunlight Data Services.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the Amount input for this Choreo. 

	@param String - (optional, string) Enter the amount of dollars spent on lobbying.  Valid formats include: 500 (exactly $500); >|500 (greater than, or equal to 500); <|500 (less than or equal to 500).
	*/
	public void setAmount(String value) {
		this.inputs.setInput("Amount", value);
	}


	/** 
	Set the value of the ClientParentOrganization input for this Choreo. 

	@param String - (optional, string) Specify a full-text search of a client's parent organizationfor.
	*/
	public void setClientParentOrganization(String value) {
		this.inputs.setInput("ClientParentOrganization", value);
	}


	/** 
	Set the value of the ClientSearch input for this Choreo. 

	@param String - (optional, string) Enter the name of the client for whom this lobbyist is working. This parameter executes a full-text search.
	*/
	public void setClientSearch(String value) {
		this.inputs.setInput("ClientSearch", value);
	}


	/** 
	Set the value of the FilingType input for this Choreo. 

	@param String - (optional, string) Specify the type of filing as identified by CRP.  Example: n, for non-self filer parent.  For more info, go here: http://data.influenceexplorer.com/api/lobbying/
	*/
	public void setFilingType(String value) {
		this.inputs.setInput("FilingType", value);
	}


	/** 
	Set the value of the LobbyistSearch input for this Choreo. 

	@param String - (optional, string) Specify a full-text search of a lobbyist's name.
	*/
	public void setLobbyistSearch(String value) {
		this.inputs.setInput("LobbyistSearch", value);
	}


	/** 
	Set the value of the RegistrantSearch input for this Choreo. 

	@param String - (optional, string) Specify a full-text search of an organization or a person, who is fling the lobbyist registration.
	*/
	public void setRegistrantSearch(String value) {
		this.inputs.setInput("RegistrantSearch", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) Indicates the desired format for the response. Accepted values are: json (the default), csv, and xls. Note when specifying xls, restults are returned as Base64 encoded data.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the TransactionID input for this Choreo. 

	@param String - (optional, string) Enter the report ID given by the Senate Office of Public Records.
	*/
	public void setTransactionID(String value) {
		this.inputs.setInput("TransactionID", value);
	}


	/** 
	Set the value of the TransactionType input for this Choreo. 

	@param String - (optional, string) Enter the type of filing as reported by the Senate Office of Public Records. See here for additional info: http://assets.transparencydata.org.s3.amazonaws.com/docs/transaction_types-20100402.csv
	*/
	public void setTransactionType(String value) {
		this.inputs.setInput("TransactionType", value);
	}


	/** 
	Set the value of the YearFiled input for this Choreo. 

	@param String - (optional, string) Specify the year in which a registration was filed. Use the following format: yyyy. Example: 2011. Logical OR is also possible by using the | (pipe) symbol.  Example: 2008|2012.
	*/
	public void setYearFiled(String value) {
		this.inputs.setInput("YearFiled", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public FederalLobbyingResultSet run() {
		JSONObject result = super.runWithResults();
		return new FederalLobbyingResultSet(result);
	}
	
}
