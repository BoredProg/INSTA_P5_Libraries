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
FederalGrants

Returns information about federal grants awarded.
*/
public class FederalGrants extends Choreography {

	/**
	Create a new instance of the FederalGrants Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public FederalGrants(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/InfluenceExplorer/FederalGrants"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API key provided by Sunlight Data Services.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the AgencyName input for this Choreo. 

	@param String - (optional, string) Full-text search on the reported name of the federal agency awarding the grant.
	*/
	public void setAgencyName(String value) {
		this.inputs.setInput("AgencyName", value);
	}


	/** 
	Set the value of the Amount input for this Choreo. 

	@param String - (optional, string) The grant amount. Valid formats include: 500 (exactly $500); >|500 (greater than, or equal to 500); <|500 (less than or equal to 500).
	*/
	public void setAmount(String value) {
		this.inputs.setInput("Amount", value);
	}


	/** 
	Set the value of the AssistanceType input for this Choreo. 

	@param Integer - (optional, integer) A numeric code for the type of grant awarded. See documentation for more details for this parameter.
	*/
	public void setAssistanceType(Integer value) {
		this.inputs.setInput("AssistanceType", value);
	}

	/** 
	Set the value of the AssistanceType input for this Choreo as a String. 

	@param String - (optional, integer) A numeric code for the type of grant awarded. See documentation for more details for this parameter.
	*/
	public void setAssistanceType(String value) {
		this.inputs.setInput("AssistanceType", value);	
	}
	/** 
	Set the value of the FiscalYear input for this Choreo. 

	@param String - (optional, date) The year in which the grant was awarded. A YYYY formatted year. You can also specify a range by separating years with a pipe (i.e. 2008|2012).
	*/
	public void setFiscalYear(String value) {
		this.inputs.setInput("FiscalYear", value);
	}


	/** 
	Set the value of the RecipientName input for this Choreo. 

	@param String - (optional, string) Full-text search on the reported name of the grant recipient.
	*/
	public void setRecipientName(String value) {
		this.inputs.setInput("RecipientName", value);
	}


	/** 
	Set the value of the RecipientState input for this Choreo. 

	@param String - (optional, string) Two-letter abbreviation of the state in which the grant was awarded.
	*/
	public void setRecipientState(String value) {
		this.inputs.setInput("RecipientState", value);
	}


	/** 
	Set the value of the RecipientType input for this Choreo. 

	@param Integer - (optional, integer) The numeric code representing the type of entity that received the grant. See documentation for more details about this parameter.
	*/
	public void setRecipientType(Integer value) {
		this.inputs.setInput("RecipientType", value);
	}

	/** 
	Set the value of the RecipientType input for this Choreo as a String. 

	@param String - (optional, integer) The numeric code representing the type of entity that received the grant. See documentation for more details about this parameter.
	*/
	public void setRecipientType(String value) {
		this.inputs.setInput("RecipientType", value);	
	}
	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) Indicates the desired format for the response. Accepted values are: json (the default), csv, and xls. Note when specifying xls, restults are returned as Base64 encoded data.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public FederalGrantsResultSet run() {
		JSONObject result = super.runWithResults();
		return new FederalGrantsResultSet(result);
	}
	
}
