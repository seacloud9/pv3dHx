﻿/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org + blog.papervision3d.org + osflash.org/papervision3d
 */

/*
 * Copyright 2006-2007 (c) Carlos Ulloa Matesanz, noventaynueve.com.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

// _______________________________________________________________________ PAPERVISION3D

package org.papervision3d;


/**
* The Papervision3D class contains global properties and settings.
*/
class Papervision3D
{
	// ___________________________________________________________________ SETTINGS

	/**
	* Indicates if the angles are expressed in degrees (true) or radians (false). The default value is true, degrees.
	*/
	static public var useDEGREES  :Bool = true;

	/**
	* Indicates if the scales are expressed in percent (true) or from zero to one (false). The default value is false, i.e. units.
	*/
	static public var usePERCENT  :Bool = false;


	// ___________________________________________________________________ STATIC

	/**
	* Enables engine name to be retrieved at runtime or when reviewing a decompiled swf.
	*/
	static public var NAME     :String = 'Papervision3D HX';

	/**
	* Enables version to be retrieved at runtime or when reviewing a decompiled swf.
	*/
	static public var VERSION  :String = 'Beta RC0';

	/**
	* Enables version date to be retrieved at runtime or when reviewing a decompiled swf.
	*/
	static public var DATE     :String = '01.04.07';

	/**
	* Enables copyright information to be retrieved at runtime or when reviewing a decompiled swf.
	*/
	static public var AUTHOR   :String = '(c) 2006-2007 Copyright by Carlos Ulloa | papervision3d.org | C4RL054321@gmail.com';

	/**
	* Determines whether debug printout is enabled. It also prints version information at startup.
	*/
	static public var VERBOSE  :Bool = true;


	// ___________________________________________________________________ LOG

	/**
	* Sends debug information to the Output panel.
	*
	* @param	message		A String value to send to Output.
	*/
	static public function log( message :String ):Void
	{
		//if( Papervision3D.VERBOSE )
			//trace( message );
	}
}