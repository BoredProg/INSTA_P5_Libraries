package com.temboo.Library.Google.Documents;

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
import com.temboo.core.Choreography.ResultSet;

	
/**
	A ResultSet with methods tailored to the values returned by the SearchByTitle Choreo.
	The ResultSet object is used to retrieve the results of a Choreo execution.
*/
public  class SearchByTitleResultSet extends ResultSet {
		
	public SearchByTitleResultSet(JSONObject doc) {
		super(doc);
	}

	/** 
	Retrieve the value for the "Response" output from this Choreo execution

	@return String - (xml) The response from the Google Documents API.
	*/
	public String getResponse() {
		return this.getResultString("Response");
	}
	/** 
	Retrieve the value for the "EditMediaLink" output from this Choreo execution

	@return String - (string) The 'resumable-edit-media' link of the document. This link is used when editing the content of an existing Google doc.
	*/
	public String getEditMediaLink() {
		return this.getResultString("EditMediaLink");
	}
	/** 
	Retrieve the value for the "EditMetaDataLink" output from this Choreo execution

	@return String - (string) The 'edit' link of the document. This link is used when editing the metadata of an existing Google doc.
	*/
	public String getEditMetaDataLink() {
		return this.getResultString("EditMetaDataLink");
	}
	/** 
	Retrieve the value for the "ResourceID" output from this Choreo execution

	@return String - (string) The document resource ID returned from Google.
	*/
	public String getResourceID() {
		return this.getResultString("ResourceID");
	}
}