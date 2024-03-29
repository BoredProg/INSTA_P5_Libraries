package com.temboo.Library.Amazon.IAM;

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
CreateVirtualMFADevice

Creates a new virtual MFA device for the AWS account.
*/
public class CreateVirtualMFADevice extends Choreography {

	/**
	Create a new instance of the CreateVirtualMFADevice Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public CreateVirtualMFADevice(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Amazon/IAM/CreateVirtualMFADevice"));
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
	Set the value of the Path input for this Choreo. 

	@param String - (optional, string) The path for the virtual MFA device. If it is not included, it defaults to a slash (/).
	*/
	public void setPath(String value) {
		this.inputs.setInput("Path", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) The format that the response should be in. Valid values are "xml" (the default) and "json".
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the VirtualMFADeviceName input for this Choreo. 

	@param String - (required, string) The name of the virtual MFA device. Use with path to uniquely identify a virtual MFA device.
	*/
	public void setVirtualMFADeviceName(String value) {
		this.inputs.setInput("VirtualMFADeviceName", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public CreateVirtualMFADeviceResultSet run() {
		JSONObject result = super.runWithResults();
		return new CreateVirtualMFADeviceResultSet(result);
	}
	
}
