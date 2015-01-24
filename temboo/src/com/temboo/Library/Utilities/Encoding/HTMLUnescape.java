package com.temboo.Library.Utilities.Encoding;

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
HTMLUnescape

Replaces character entity names in the specified text with equivalent HTML markup characters.
*/
public class HTMLUnescape extends Choreography {

	/**
	Create a new instance of the HTMLUnescape Choreo. A TembooSession object, containing a valid
	set of Temboo credentials, must be supplied.
	*/
	public HTMLUnescape(TembooSession session) {
		super(session, TembooPath.pathFromStringNoException("/Library/Utilities/Encoding/HTMLUnescape"));
	}

	/** 
	Set the value of the EscapedHTML input for this Choreo. 

	@param String - (required, string) The escaped HTML that should be unescaped.
	*/
	public void setEscapedHTML(String value) {
		this.inputs.setInput("EscapedHTML", value);
	}


	
	/**
	 * Execute the Choreo, wait for the Choreo to complete 
	 * and return a ResultSet containing the execution results.
	 */
	@Override
	public HTMLUnescapeResultSet run() {
		JSONObject result = super.runWithResults();
		return new HTMLUnescapeResultSet(result);
	}
	
}