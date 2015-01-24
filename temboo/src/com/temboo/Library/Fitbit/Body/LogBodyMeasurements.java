package com.temboo.Library.Fitbit.Body;

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
LogBodyMeasurements

Creates a new log entry for a user's body measurements.
*/
public class LogBodyMeasurements extends Choreography {

	/**
	Create a new instance of the LogBodyMeasurements Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public LogBodyMeasurements(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Fitbit/Body/LogBodyMeasurements"));
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
	Set the value of the Bicep input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's bicep measurement.
	*/
	public void setBicep(BigDecimal value) {
		this.inputs.setInput("Bicep", value);
	}

	/** 
	Set the value of the Bicep input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's bicep measurement.
	*/
	public void setBicep(String value) {
		this.inputs.setInput("Bicep", value);	
	}
	/** 
	Set the value of the Calf input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's calf measurement.
	*/
	public void setCalf(BigDecimal value) {
		this.inputs.setInput("Calf", value);
	}

	/** 
	Set the value of the Calf input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's calf measurement.
	*/
	public void setCalf(String value) {
		this.inputs.setInput("Calf", value);	
	}
	/** 
	Set the value of the ConsumerKey input for this Choreo. 

	@param String - (required, string) The Consumer Key provided by Fitbit.
	*/
	public void setConsumerKey(String value) {
		this.inputs.setInput("ConsumerKey", value);
	}


	/** 
	Set the value of the ConsumerSecret input for this Choreo. 

	@param String - (required, string) The Consumer Secret provided by Fitbit.
	*/
	public void setConsumerSecret(String value) {
		this.inputs.setInput("ConsumerSecret", value);
	}


	/** 
	Set the value of the Date input for this Choreo. 

	@param String - (required, date) The date that corresponds with the new log entry (in the format yyyy-MM-dd).
	*/
	public void setDate(String value) {
		this.inputs.setInput("Date", value);
	}


	/** 
	Set the value of the Forearm input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's forearm measurement.
	*/
	public void setForearm(BigDecimal value) {
		this.inputs.setInput("Forearm", value);
	}

	/** 
	Set the value of the Forearm input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's forearm measurement.
	*/
	public void setForearm(String value) {
		this.inputs.setInput("Forearm", value);	
	}
	/** 
	Set the value of the Hips input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's hips measurement.
	*/
	public void setHips(BigDecimal value) {
		this.inputs.setInput("Hips", value);
	}

	/** 
	Set the value of the Hips input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's hips measurement.
	*/
	public void setHips(String value) {
		this.inputs.setInput("Hips", value);	
	}
	/** 
	Set the value of the Neck input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's neck measurement.
	*/
	public void setNeck(BigDecimal value) {
		this.inputs.setInput("Neck", value);
	}

	/** 
	Set the value of the Neck input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's neck measurement.
	*/
	public void setNeck(String value) {
		this.inputs.setInput("Neck", value);	
	}
	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that you want the response to be in: xml or json. Defaults to json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Thigh input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's thigh measurement.
	*/
	public void setThigh(BigDecimal value) {
		this.inputs.setInput("Thigh", value);
	}

	/** 
	Set the value of the Thigh input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's thigh measurement.
	*/
	public void setThigh(String value) {
		this.inputs.setInput("Thigh", value);	
	}
	/** 
	Set the value of the UserID input for this Choreo. 

	@param String - (optional, string) The user's encoded id. Defaults to "-" (dash) which will return data for the user associated with the token credentials provided.
	*/
	public void setUserID(String value) {
		this.inputs.setInput("UserID", value);
	}


	/** 
	Set the value of the Waist input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's waist measurement.
	*/
	public void setWaist(BigDecimal value) {
		this.inputs.setInput("Waist", value);
	}

	/** 
	Set the value of the Waist input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's waist measurement.
	*/
	public void setWaist(String value) {
		this.inputs.setInput("Waist", value);	
	}
	/** 
	Set the value of the Weight input for this Choreo. 

	@param BigDecimal - (conditional, decimal) The user's weight.
	*/
	public void setWeight(BigDecimal value) {
		this.inputs.setInput("Weight", value);
	}

	/** 
	Set the value of the Weight input for this Choreo as a String. 

	@param String - (conditional, decimal) The user's weight.
	*/
	public void setWeight(String value) {
		this.inputs.setInput("Weight", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public LogBodyMeasurementsResultSet run() {
		JSONObject result = super.runWithResults();
		return new LogBodyMeasurementsResultSet(result);
	}
	
}
