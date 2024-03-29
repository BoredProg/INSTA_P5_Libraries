package com.temboo.Library.Fitbit.BloodPressure;

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
LogBloodPressure

Creates log entry for a blood pressure measurement.
*/
public class LogBloodPressure extends Choreography {

	/**
	Create a new instance of the LogBloodPressure Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public LogBloodPressure(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Fitbit/BloodPressure/LogBloodPressure"));
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

	@param String - (required, date) The date that corresponds with the log entry (in the format yyyy-MM-dd).
	*/
	public void setDate(String value) {
		this.inputs.setInput("Date", value);
	}


	/** 
	Set the value of the Diastolic input for this Choreo. 

	@param Integer - (required, integer) The diastolic measurement.
	*/
	public void setDiastolic(Integer value) {
		this.inputs.setInput("Diastolic", value);
	}

	/** 
	Set the value of the Diastolic input for this Choreo as a String. 

	@param String - (required, integer) The diastolic measurement.
	*/
	public void setDiastolic(String value) {
		this.inputs.setInput("Diastolic", value);	
	}
	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that you want the response to be in: xml or json. Defaults to json.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the Systolic input for this Choreo. 

	@param Integer - (required, integer) The systolic measurement.
	*/
	public void setSystolic(Integer value) {
		this.inputs.setInput("Systolic", value);
	}

	/** 
	Set the value of the Systolic input for this Choreo as a String. 

	@param String - (required, integer) The systolic measurement.
	*/
	public void setSystolic(String value) {
		this.inputs.setInput("Systolic", value);	
	}
	/** 
	Set the value of the Time input for this Choreo. 

	@param String - (optional, string) Time of the measurement; hours and minutes in the format HH:mm.
	*/
	public void setTime(String value) {
		this.inputs.setInput("Time", value);
	}


	/** 
	Set the value of the UserID input for this Choreo. 

	@param String - (optional, string) The user's encoded id. Defaults to "-" (dash) which will return data for the user associated with the token credentials provided.
	*/
	public void setUserID(String value) {
		this.inputs.setInput("UserID", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public LogBloodPressureResultSet run() {
		JSONObject result = super.runWithResults();
		return new LogBloodPressureResultSet(result);
	}
	
}
