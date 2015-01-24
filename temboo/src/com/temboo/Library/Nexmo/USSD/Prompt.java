package com.temboo.Library.Nexmo.USSD;

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
Prompt

Sends a text message to the specified number using USSD protocol.  You can then listen to inbound messages.
*/
public class Prompt extends Choreography {

	/**
	Create a new instance of the Prompt Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public Prompt(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Nexmo/USSD/Prompt"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) Your API Key provided to you by Nexmo.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the APISecret input for this Choreo. 

	@param String - (required, string) Your API Secret provided to you by Nexmo.
	*/
	public void setAPISecret(String value) {
		this.inputs.setInput("APISecret", value);
	}


	/** 
	Set the value of the ClientReference input for this Choreo. 

	@param String - (optional, string) Include a note for your reference. (40 characters max).
	*/
	public void setClientReference(String value) {
		this.inputs.setInput("ClientReference", value);
	}


	/** 
	Set the value of the DeliveryReceipt input for this Choreo. 

	@param Integer - (optional, integer) Set to 1 to receive a Delivery Receipt for this message. Make sure to configure your "Callback URL" in your "API Settings".
	*/
	public void setDeliveryReceipt(Integer value) {
		this.inputs.setInput("DeliveryReceipt", value);
	}

	/** 
	Set the value of the DeliveryReceipt input for this Choreo as a String. 

	@param String - (optional, integer) Set to 1 to receive a Delivery Receipt for this message. Make sure to configure your "Callback URL" in your "API Settings".
	*/
	public void setDeliveryReceipt(String value) {
		this.inputs.setInput("DeliveryReceipt", value);	
	}
	/** 
	Set the value of the From input for this Choreo. 

	@param String - (required, string) The phone number associated with your Nexmo account e.g. 17185551234.
	*/
	public void setFrom(String value) {
		this.inputs.setInput("From", value);
	}


	/** 
	Set the value of the NetworkCode input for this Choreo. 

	@param String - (optional, string) Sends this message to the specifed network operator (MCCMNC).
	*/
	public void setNetworkCode(String value) {
		this.inputs.setInput("NetworkCode", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Valid values are "json" (the default) and "xml".
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Text input for this Choreo. 

	@param String - (conditional, string) Required when Type is "text".  Body of the text message (with a maximum length of 3200 characters)
	*/
	public void setText(String value) {
		this.inputs.setInput("Text", value);
	}


	/** 
	Set the value of the To input for this Choreo. 

	@param String - (required, string) Mobile number in international format, and one recipient per request. (e.g. 447525856424 or 00447525856424 when sending to UK)
	*/
	public void setTo(String value) {
		this.inputs.setInput("To", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public PromptResultSet run() {
		JSONObject result = super.runWithResults();
		return new PromptResultSet(result);
	}
	
}
