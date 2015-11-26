/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org ï¿?blog.papervision3d.org ï¿?osflash.org/papervision3d
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
//                                                               Number3D

package org.papervision3d.core ;

/**
* The Number3D class represents a value in a three-dimensional coordinate system.
*
* Properties x, y and z represent the horizontal, vertical and z the depth axes respectively.
*
*/
class Number4D
{
	/**
	* The horizontal coordinate value.
	*/
	public var x: Float;

	/**
	* The vertical coordinate value.
	*/
	public var y: Float;

	/**
	* The depth coordinate value.
	*/
	public var z: Float;
	
	
	public var w:Float;
	



	/**
	* Creates a new Number3D object whose three-dimensional values are specified by the x, y and z parameters. If you call this constructor function without parameters, a Number3D with x, y and z properties set to zero is created.
	*
	* @param	x	The horizontal coordinate value. The default value is zero.
	* @param	y	The vertical coordinate value. The default value is zero.
	* @param	z	The depth coordinate value. The default value is zero.
	*/
	public function new( ?x: Float, ?y: Float, ?z: Float , ?w:Float )
	{
		this.x=if(x==null) 0.0 else x;
		this.y=if(y==null) 0.0 else y;
		this.z=if(z==null) 0.0 else z;
		this.w=if(w==null) 0.0 else w;
	}


	/**
	* Returns a Number3D object with x, y and z properties set to zero.
	*
	* @return A Number3D object.
	*/
    static private function getZERO():Number4D
	{
		return new Number4D( 0.0, 0.0, 0.0 , 0.0 );
	}

	/**
	* Returns a string value representing the three-dimensional values in the specified Number3D object.
	*
	* @return	A string.
	*/
	public function toString(): String
	{
		return 'x:' + x + ' y:' + y + ' z:' + z + ' w: '+ w ;
	}
}