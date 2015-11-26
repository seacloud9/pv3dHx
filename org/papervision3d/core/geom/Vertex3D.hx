/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org + blog.papervision3d.org + osflash.org/papervision3d
 */

/*
 * Copyright 2006 (c) Carlos Ulloa Matesanz, noventaynueve.com.
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

// ______________________________________________________________________
//                                                               Vertex3D
package org.papervision3d.core.geom;


/**
* The Vertex3D constructor lets you create 3D vertices.
*/
class Vertex3D
{
	/**
	* An Number that sets the X coordinate of a object relative to the scene coordinate system.
	*/
	public var x :Float;

	/**
	* An Number that sets the Y coordinate of a object relative to the scene coordinates.
	*/
	public var y :Float;

	/**
	* An Number that sets the Z coordinate of a object relative to the scene coordinates.
	*/
	public var z :Float;

	/**
	* Creates a new Vertex3D object whose three-dimensional values are specified by the x, y and z parameters.
	*
	* @param	x	The horizontal coordinate value. The default value is zero.
	* @param	y	The vertical coordinate value. The default value is zero.
	* @param	z	The depth coordinate value. The default value is zero.
	*
	* */
	public function new( ?x:Float, ?y:Float, ?z:Float )
	{
		this.x = if(x==null) 0.0 else x ;
		this.y = if(y==null) 0.0 else y ;
		this.z = if(z==null) 0.0 else z ;
	}
		/**
	* Returns a string value representing the xy values in the specified Vertex3D object.
	*
	* @return	A string.
	*/
	public function toString(): String
	{
		return 'x:' + x + ' y:' + y + ' z:' + z;
	}	
}