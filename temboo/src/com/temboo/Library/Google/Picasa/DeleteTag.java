package com.temboo.Library.Google.Picasa;

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
DeleteTag

Removes a tag from a specified photo in Google Picasa.
*/
public class DeleteTag extends Choreography {

	/**
	Create a new instance of the DeleteTag Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public DeleteTag(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Google/Picasa/DeleteTag"));
	}

	/** 
	Set the value of the AccessToken input for this Choreo. 

	@param String - (optional, string) A valid access token retrieved during the OAuth process. This is required unless you provide the ClientID, ClientSecret, and RefreshToken to generate a new access token.
	*/
	public void setAccessToken(String value) {
		this.inputs.setInput("AccessToken", value);
	}


	/** 
	Set the value of the AlbumId input for this Choreo. 

	@param Integer - (required, integer) The id for the album which has the tagged photo. Note that this can be retrieved by running the ListAlbums Choreo.
	*/
	public void setAlbumId(Integer value) {
		this.inputs.setInput("AlbumId", value);
	}

	/** 
	Set the value of the AlbumId input for this Choreo as a String. 

	@param String - (required, integer) The id for the album which has the tagged photo. Note that this can be retrieved by running the ListAlbums Choreo.
	*/
	public void setAlbumId(String value) {
		this.inputs.setInput("AlbumId", value);	
	}
	/** 
	Set the value of the ClientID input for this Choreo. 

	@param String - (conditional, string) The Client ID provided by Google. Required unless providing a valid AccessToken.
	*/
	public void setClientID(String value) {
		this.inputs.setInput("ClientID", value);
	}


	/** 
	Set the value of the ClientSecret input for this Choreo. 

	@param String - (conditional, string) The Client Secret provided by Google. Required unless providing a valid AccessToken.
	*/
	public void setClientSecret(String value) {
		this.inputs.setInput("ClientSecret", value);
	}


	/** 
	Set the value of the PhotoID input for this Choreo. 

	@param Integer - (required, integer) The id for the photo that has a tag to delete.
	*/
	public void setPhotoID(Integer value) {
		this.inputs.setInput("PhotoID", value);
	}

	/** 
	Set the value of the PhotoID input for this Choreo as a String. 

	@param String - (required, integer) The id for the photo that has a tag to delete.
	*/
	public void setPhotoID(String value) {
		this.inputs.setInput("PhotoID", value);	
	}
	/** 
	Set the value of the RefreshToken input for this Choreo. 

	@param String - (conditional, string) An OAuth Refresh Token used to generate a new access token when the original token is expired. Required unless providing a valid AccessToken.
	*/
	public void setRefreshToken(String value) {
		this.inputs.setInput("RefreshToken", value);
	}


	/** 
	Set the value of the TagID input for this Choreo. 

	@param String - (required, string) The Id (or tag name) for the tag that you want to delete.
	*/
	public void setTagID(String value) {
		this.inputs.setInput("TagID", value);
	}


	/** 
	Set the value of the UserID input for this Choreo. 

	@param String - (optional, string) Google Picasa username. Defaults to 'default' which means the server will use the UserID of the user whose access token was specified.
	*/
	public void setUserID(String value) {
		this.inputs.setInput("UserID", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public DeleteTagResultSet run() {
		JSONObject result = super.runWithResults();
		return new DeleteTagResultSet(result);
	}
	
}
