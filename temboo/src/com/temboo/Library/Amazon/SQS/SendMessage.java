package com.temboo.Library.Amazon.SQS;

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
SendMessage

Sends a message to a specified queue.
*/
public class SendMessage extends Choreography {

	/**
	Create a new instance of the SendMessage Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public SendMessage(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Amazon/SQS/SendMessage"));
	}

	/** 
	Set the value of the AWSAccessKeyId input for this Choreo. 

	@param String - (required, string) The Access Key ID provided by Amazon Web Services.
	*/
	public void setAWSAccessKeyId(String value) {
		this.inputs.setInput("AWSAccessKeyId", value);
	}


	/** 
	Set the value of the AWSAccountId input for this Choreo. 

	@param Integer - (required, integer) The id for the AWS account associated with the queue you're sending a message to (remove all dashes in the account number).
	*/
	public void setAWSAccountId(Integer value) {
		this.inputs.setInput("AWSAccountId", value);
	}

	/** 
	Set the value of the AWSAccountId input for this Choreo as a String. 

	@param String - (required, integer) The id for the AWS account associated with the queue you're sending a message to (remove all dashes in the account number).
	*/
	public void setAWSAccountId(String value) {
		this.inputs.setInput("AWSAccountId", value);	
	}
	/** 
	Set the value of the AWSSecretKeyId input for this Choreo. 

	@param String - (required, string) The Secret Key ID provided by Amazon Web Services.
	*/
	public void setAWSSecretKeyId(String value) {
		this.inputs.setInput("AWSSecretKeyId", value);
	}


	/** 
	Set the value of the MessageBody input for this Choreo. 

	@param String - (required, string) The message to send. Maximum size is 64 KB.
	*/
	public void setMessageBody(String value) {
		this.inputs.setInput("MessageBody", value);
	}


	/** 
	Set the value of the QueueName input for this Choreo. 

	@param String - (required, string) The name of the queue you want to send a message to.
	*/
	public void setQueueName(String value) {
		this.inputs.setInput("QueueName", value);
	}


	/** 
	Set the value of the UserRegion input for this Choreo. 

	@param String - (optional, string) The AWS region that corresponds to the SQS endpoint you wish to access. The default region is "us-east-1". See description below for valid values.
	*/
	public void setUserRegion(String value) {
		this.inputs.setInput("UserRegion", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public SendMessageResultSet run() {
		JSONObject result = super.runWithResults();
		return new SendMessageResultSet(result);
	}
	
}
