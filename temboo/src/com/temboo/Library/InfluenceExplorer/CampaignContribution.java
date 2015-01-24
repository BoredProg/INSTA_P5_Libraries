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
CampaignContribution

Retrieve detailed information on political campaign contributions, filtered by date, contributor, state, employer, campaign, etc.
*/
public class CampaignContribution extends Choreography {

	/**
	Create a new instance of the CampaignContribution Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public CampaignContribution(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/InfluenceExplorer/CampaignContribution"));
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

	@param String - (conditional, string) Enter the amount of dollars spent on lobbying.  Valid formats include: 500 (exactly $500); >|500 (greater than, or equal to 500); <|500 (less than or equal to 500).
	*/
	public void setAmount(String value) {
		this.inputs.setInput("Amount", value);
	}


	/** 
	Set the value of the ContributorName input for this Choreo. 

	@param String - (conditional, string) Specfiy the name of an individual, PAC, organization, or employer for which a full-text search will be performed.
	*/
	public void setContributorName(String value) {
		this.inputs.setInput("ContributorName", value);
	}


	/** 
	Set the value of the ContributorsByState input for this Choreo. 

	@param String - (conditional, string) Enter a two-letter state designation from which the contribution is made.
	*/
	public void setContributorsByState(String value) {
		this.inputs.setInput("ContributorsByState", value);
	}


	/** 
	Set the value of the Cycle input for this Choreo. 

	@param String - (conditional, string) Specify a yyyy-formatted election cycle. Example: 2012, or 2008|2012 to limit results between 2008 and 2012.
	*/
	public void setCycle(String value) {
		this.inputs.setInput("Cycle", value);
	}


	/** 
	Set the value of the Date input for this Choreo. 

	@param String - (conditional, string) Specify a date of the contribution in ISO date format.  For example: 2006-08-06.  Or, ><|2006-08-06|2006-09-12 to limit results between specific dates.
	*/
	public void setDate(String value) {
		this.inputs.setInput("Date", value);
	}


	/** 
	Set the value of the OrganizationName input for this Choreo. 

	@param String - (conditional, string) Specify a full-text search on employer, organization, and parent organization.
	*/
	public void setOrganizationName(String value) {
		this.inputs.setInput("OrganizationName", value);
	}


	/** 
	Set the value of the RecipientName input for this Choreo. 

	@param String - (conditional, string) Enter the full-text search on name of PAC or candidate receiving the contribution.
	*/
	public void setRecipientName(String value) {
		this.inputs.setInput("RecipientName", value);
	}


	/** 
	Set the value of the RecipientState input for this Choreo. 

	@param String - (conditional, string) Specify a two-letter state abbreviation for the state in which the recipient of contributions is running a campaign.
	*/
	public void setRecipientState(String value) {
		this.inputs.setInput("RecipientState", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) Indicates the desired format for the response. Accepted values are: json (the default), csv, and xls. Note when specifying xls, restults are returned as Base64 encoded data.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Seat input for this Choreo. 

	@param String - (conditional, string) Specify the type of political office being sought.  Examples: federal:senate (US Senate), federal:president (US President), state:governor.  For more info see documentation.
	*/
	public void setSeat(String value) {
		this.inputs.setInput("Seat", value);
	}


	/** 
	Set the value of the TransactionNamespace input for this Choreo. 

	@param String - (optional, string) Filters on federal or state contributions. Valid namespaces are: urn:fec:transaction (for federal) or urn:nimsp:transaction (for state).
	*/
	public void setTransactionNamespace(String value) {
		this.inputs.setInput("TransactionNamespace", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public CampaignContributionResultSet run() {
		JSONObject result = super.runWithResults();
		return new CampaignContributionResultSet(result);
	}
	
}
