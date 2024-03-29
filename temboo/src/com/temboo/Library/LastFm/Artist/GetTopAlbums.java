package com.temboo.Library.LastFm.Artist;

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
GetTopAlbums

Retrieves the top albums for an artist on Last.fm, ordered by popularity.
*/
public class GetTopAlbums extends Choreography {

	/**
	Create a new instance of the GetTopAlbums Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public GetTopAlbums(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/LastFm/Artist/GetTopAlbums"));
	}

	/** 
	Set the value of the APIKey input for this Choreo. 

	@param String - (required, string) Your Last.fm API Key.
	*/
	public void setAPIKey(String value) {
		this.inputs.setInput("APIKey", value);
	}


	/** 
	Set the value of the Artist input for this Choreo. 

	@param String - (conditional, string) The artist name. Required unless providing MbID.
	*/
	public void setArtist(String value) {
		this.inputs.setInput("Artist", value);
	}


	/** 
	Set the value of the AutoCorrect input for this Choreo. 

	@param Boolean - (optional, boolean) Transform misspelled artist names into correct artist names. The corrected artist name will be returned in the response. Defaults to 0.
	*/
	public void setAutoCorrect(Boolean value) {
		this.inputs.setInput("AutoCorrect", value);
	}

	/** 
	Set the value of the AutoCorrect input for this Choreo as a String. 

	@param String - (optional, boolean) Transform misspelled artist names into correct artist names. The corrected artist name will be returned in the response. Defaults to 0.
	*/
	public void setAutoCorrect(String value) {
		this.inputs.setInput("AutoCorrect", value);	
	}
	/** 
	Set the value of the Limit input for this Choreo. 

	@param Integer - (optional, integer) The number of results to fetch per page. Defaults to 50.
	*/
	public void setLimit(Integer value) {
		this.inputs.setInput("Limit", value);
	}

	/** 
	Set the value of the Limit input for this Choreo as a String. 

	@param String - (optional, integer) The number of results to fetch per page. Defaults to 50.
	*/
	public void setLimit(String value) {
		this.inputs.setInput("Limit", value);	
	}
	/** 
	Set the value of the MbID input for this Choreo. 

	@param String - (conditional, string) The musicbrainz id for the artist. Required unless providing Artist.
	*/
	public void setMbID(String value) {
		this.inputs.setInput("MbID", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public GetTopAlbumsResultSet run() {
		JSONObject result = super.runWithResults();
		return new GetTopAlbumsResultSet(result);
	}
	
}
