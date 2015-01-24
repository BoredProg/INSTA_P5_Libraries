package com.temboo.Library.SchoolFinder;

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
GetTestScores

Returns test scores for a school, district, city or state. 


*/
public class GetTestScores extends Choreography {

	/**
	Create a new instance of the GetTestScores Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public GetTestScores(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/SchoolFinder/GetTestScores"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) Your School Finder API Key.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the DistrictID input for this Choreo. 

	@param String - (conditional, string) The education.com district id.
	*/
	public void setDistrictID(String value) {
		this.inputs.setInput("DistrictID", value);
	}


	/** 
	Set the value of the DistrictLEA input for this Choreo. 

	@param String - (conditional, string) The LEA id of the district.
	*/
	public void setDistrictLEA(String value) {
		this.inputs.setInput("DistrictLEA", value);
	}


	/** 
	Set the value of the NCES input for this Choreo. 

	@param String - (conditional, string) The National Center for Education Statistics (NCES) id of the school.
	*/
	public void setNCES(String value) {
		this.inputs.setInput("NCES", value);
	}


	/** 
	Set the value of the ResponseFormat input for this Choreo. 

	@param String - (optional, string) Format of the response returned by Education.com. Defaluts to XML. JSON is also possible.
	*/
	public void setResponseFormat(String value) {
		this.inputs.setInput("ResponseFormat", value);
	}


	/** 
	Set the value of the SchoolID input for this Choreo. 

	@param String - (conditional, string) The Education.com id of the school you want to find.
	*/
	public void setSchoolID(String value) {
		this.inputs.setInput("SchoolID", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public GetTestScoresResultSet run() {
		JSONObject result = super.runWithResults();
		return new GetTestScoresResultSet(result);
	}
	
}
