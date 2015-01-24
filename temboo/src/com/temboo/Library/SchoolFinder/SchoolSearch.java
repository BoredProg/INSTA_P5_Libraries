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
SchoolSearch

Returns a list of school district profiles and related school information for a zip code, city, state, or other criteria in the search parameters.
*/
public class SchoolSearch extends Choreography {

	/**
	Create a new instance of the SchoolSearch Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public SchoolSearch(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/SchoolFinder/SchoolSearch"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) Your School Finder API Key.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the City input for this Choreo. 

	@param String - (conditional, string) The name of a city. Must also be accompanied by the corresponding state parameter.
	*/
	public void setCity(String value) {
		this.inputs.setInput("City", value);
	}


	/** 
	Set the value of the County input for this Choreo. 

	@param String - (conditional, string) The name of a county.
	*/
	public void setCounty(String value) {
		this.inputs.setInput("County", value);
	}


	/** 
	Set the value of the Distance input for this Choreo. 

	@param BigDecimal - (conditional, decimal) A distance in miles from a specific latitude/longitude. The suggested value is around 1.5 miles. Please note that distance is required when using latitude and longitude parameters.
	*/
	public void setDistance(BigDecimal value) {
		this.inputs.setInput("Distance", value);
	}

	/** 
	Set the value of the Distance input for this Choreo as a String. 

	@param String - (conditional, decimal) A distance in miles from a specific latitude/longitude. The suggested value is around 1.5 miles. Please note that distance is required when using latitude and longitude parameters.
	*/
	public void setDistance(String value) {
		this.inputs.setInput("Distance", value);	
	}
	/** 
	Set the value of the DistrictID input for this Choreo. 

	@param String - (optional, string) The internal Education.com id of a school district.
	*/
	public void setDistrictID(String value) {
		this.inputs.setInput("DistrictID", value);
	}


	/** 
	Set the value of the DistrictLEA input for this Choreo. 

	@param String - (optional, string) The NCES Local Education Agency (LEA) id of a school district.
	*/
	public void setDistrictLEA(String value) {
		this.inputs.setInput("DistrictLEA", value);
	}


	/** 
	Set the value of the Latitude input for this Choreo. 

	@param BigDecimal - (conditional, decimal) A latitude which serves as the center for distance searches. Please note that distance is required when using latitude and longitude parameters.
	*/
	public void setLatitude(BigDecimal value) {
		this.inputs.setInput("Latitude", value);
	}

	/** 
	Set the value of the Latitude input for this Choreo as a String. 

	@param String - (conditional, decimal) A latitude which serves as the center for distance searches. Please note that distance is required when using latitude and longitude parameters.
	*/
	public void setLatitude(String value) {
		this.inputs.setInput("Latitude", value);	
	}
	/** 
	Set the value of the Longitude input for this Choreo. 

	@param BigDecimal - (conditional, decimal) A longitude which serves as the center for distance searches. Please note that distance is required when using latitude and longitude parameters.
	*/
	public void setLongitude(BigDecimal value) {
		this.inputs.setInput("Longitude", value);
	}

	/** 
	Set the value of the Longitude input for this Choreo as a String. 

	@param String - (conditional, decimal) A longitude which serves as the center for distance searches. Please note that distance is required when using latitude and longitude parameters.
	*/
	public void setLongitude(String value) {
		this.inputs.setInput("Longitude", value);	
	}
	/** 
	Set the value of the MinResult input for this Choreo. 

	@param BigDecimal - (optional, decimal) Minimum number of search results to return. The search will be expanded in increments of 0.5 miles until the minresult is reached. minResult is only valid for zip code and latitude/longitude requests.
	*/
	public void setMinResult(BigDecimal value) {
		this.inputs.setInput("MinResult", value);
	}

	/** 
	Set the value of the MinResult input for this Choreo as a String. 

	@param String - (optional, decimal) Minimum number of search results to return. The search will be expanded in increments of 0.5 miles until the minresult is reached. minResult is only valid for zip code and latitude/longitude requests.
	*/
	public void setMinResult(String value) {
		this.inputs.setInput("MinResult", value);	
	}
	/** 
	Set the value of the NCES input for this Choreo. 

	@param String - (optional, string) The National Center for Education Statistics (NCES) id of the school you want to find.
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

	@param String - (optional, string) The Education.com id of the school you want to find.
	*/
	public void setSchoolID(String value) {
		this.inputs.setInput("SchoolID", value);
	}


	/** 
	Set the value of the State input for this Choreo. 

	@param String - (conditional, string) The two letter abbreviation of a state e.g. South Caroline should be formatted “SC”.
	*/
	public void setState(String value) {
		this.inputs.setInput("State", value);
	}


	/** 
	Set the value of the Zip input for this Choreo. 

	@param Integer - (conditional, integer) A five digit US postal code.
	*/
	public void setZip(Integer value) {
		this.inputs.setInput("Zip", value);
	}

	/** 
	Set the value of the Zip input for this Choreo as a String. 

	@param String - (conditional, integer) A five digit US postal code.
	*/
	public void setZip(String value) {
		this.inputs.setInput("Zip", value);	
	}
	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public SchoolSearchResultSet run() {
		JSONObject result = super.runWithResults();
		return new SchoolSearchResultSet(result);
	}
	
}
