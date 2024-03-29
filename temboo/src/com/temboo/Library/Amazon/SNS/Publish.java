package com.temboo.Library.Amazon.SNS;

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
Publish

Sends a message to a topic's subscribed endpoints.
*/
public class Publish extends Choreography {

	/**
	Create a new instance of the Publish Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public Publish(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Amazon/SNS/Publish"));
	}

	/** 
	Set the value of the AWSAccessKeyId input for this Choreo. 

	@param String - (required, string) The Access Key ID provided by Amazon Web Services.
	*/
	public void setAWSAccessKeyId(String value) {
		this.inputs.setInput("AWSAccessKeyId", value);
	}


	/** 
	Set the value of the AWSSecretKeyId input for this Choreo. 

	@param String - (required, string) The Secret Key ID provided by Amazon Web Services.
	*/
	public void setAWSSecretKeyId(String value) {
		this.inputs.setInput("AWSSecretKeyId", value);
	}


	/** 
	Set the value of the MessageStructure input for this Choreo. 

	@param String - (optional, string) Can be set to 'json' if you are providing a valid JSON object for the Message input variable.
	*/
	public void setMessageStructure(String value) {
		this.inputs.setInput("MessageStructure", value);
	}


	/** 
	Set the value of the Message input for this Choreo. 

	@param String - (required, string) The text for the message you want to send to the topic.
	*/
	public void setMessage(String value) {
		this.inputs.setInput("Message", value);
	}


	/** 
	Set the value of the Subject input for this Choreo. 

	@param String - (optional, string) The "Subject" line of the message when the message is delivered to e-mail endpoints or as a JSON message.
	*/
	public void setSubject(String value) {
		this.inputs.setInput("Subject", value);
	}


	/** 
	Set the value of the TopicArn input for this Choreo. 

	@param String - (required, string) The ARN of the topic you want to publish to.
	*/
	public void setTopicArn(String value) {
		this.inputs.setInput("TopicArn", value);
	}


	/** 
	Set the value of the UserRegion input for this Choreo. 

	@param String - (optional, string) The AWS region that corresponds to the SNS endpoint you wish to access. The default region is "us-east-1". See description below for valid values.
	*/
	public void setUserRegion(String value) {
		this.inputs.setInput("UserRegion", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public PublishResultSet run() {
		JSONObject result = super.runWithResults();
		return new PublishResultSet(result);
	}
	
}
