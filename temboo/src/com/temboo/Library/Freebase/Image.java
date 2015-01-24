package com.temboo.Library.Freebase;

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
Image

Generates a thumbnail for an image from the content database to the requested size. 
*/
public class Image extends Choreography {

	/**
	Create a new instance of the Image Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public Image(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Freebase/Image"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) The API Key provided by Freebase.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the FallbackID input for this Choreo. 

	@param String - (optional, string) Use this second (fallback) image ID, if the primary ID is not available.
	*/
	public void setFallbackID(String value) {
		this.inputs.setInput("FallbackID", value);
	}


	/** 
	Set the value of the ID input for this Choreo. 

	@param String - (required, string) Enter the ID of the entity for which description information will be retrieved. IDs and MIDs can be obtained by running the Search Choreo in this bundle. Example input: /en/bob_dylan
	*/
	public void setID(String value) {
		this.inputs.setInput("ID", value);
	}


	/** 
	Set the value of the MaximumHeight input for this Choreo. 

	@param Integer - (optional, integer) Enter the desired maximum image height in pixels. Integers must be in the following range: (0 --> 4,096)
	*/
	public void setMaximumHeight(Integer value) {
		this.inputs.setInput("MaximumHeight", value);
	}

	/** 
	Set the value of the MaximumHeight input for this Choreo as a String. 

	@param String - (optional, integer) Enter the desired maximum image height in pixels. Integers must be in the following range: (0 --> 4,096)
	*/
	public void setMaximumHeight(String value) {
		this.inputs.setInput("MaximumHeight", value);	
	}
	/** 
	Set the value of the MaximumWidth input for this Choreo. 

	@param Integer - (optional, integer) Enter the desired maximum image width in pixels. Integers must be in the following range: (0 --> 4,096)
	*/
	public void setMaximumWidth(Integer value) {
		this.inputs.setInput("MaximumWidth", value);
	}

	/** 
	Set the value of the MaximumWidth input for this Choreo as a String. 

	@param String - (optional, integer) Enter the desired maximum image width in pixels. Integers must be in the following range: (0 --> 4,096)
	*/
	public void setMaximumWidth(String value) {
		this.inputs.setInput("MaximumWidth", value);	
	}
	/** 
	Set the value of the Mode input for this Choreo. 

	@param String - (optional, string) Specify the method used to crop or scale images.  Available methods include: fill, fillcrop, fillcropmid, fit.
	*/
	public void setMode(String value) {
		this.inputs.setInput("Mode", value);
	}


	/** 
	Set the value of the Pad input for this Choreo. 

	@param Boolean - (optional, boolean) Enter 0, or 1 to specify whether the provided image should be padded to the requested dimensions.
	*/
	public void setPad(Boolean value) {
		this.inputs.setInput("Pad", value);
	}

	/** 
	Set the value of the Pad input for this Choreo as a String. 

	@param String - (optional, boolean) Enter 0, or 1 to specify whether the provided image should be padded to the requested dimensions.
	*/
	public void setPad(String value) {
		this.inputs.setInput("Pad", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public ImageResultSet run() {
		JSONObject result = super.runWithResults();
		return new ImageResultSet(result);
	}
	
}
