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

// __________________________________________________________________________ BITMAP MATERIAL

package org.papervision3d.materials;

import flash.geom.Matrix;
import flash.display.BitmapData;

import org.papervision3d.core.proto.MaterialObject3D;

/**
* The BitmapMaterial class creates a texture from a BitmapData object.
*
* Materials collects data about how objects appear when rendered.
*
*/
class BitmapMaterial extends MaterialObject3D
{

	// ______________________________________________________________________ TEXTURE
	/**
	* A texture object.
	*/
    public var texture(get_texture,set_texture):Dynamic;

	private function get_texture():Dynamic
	{
		return this._texture;
	}

	private function set_texture( asset:Dynamic ):Dynamic
	{
		this.bitmap   = createBitmap( asset );
		this._texture = asset;
		return asset;
	}


	// ______________________________________________________________________ NEW

	/**
	* The BitmapMaterial class creates a texture from a BitmapData object.
	*
	* @param	asset				A BitmapData object.
	* @param	initObject			[optional] - An object that contains additional properties with which to populate the newly created material.
	*/
	public function new( asset :Dynamic)
	{
		super();

		texture = asset;
	}


	// ______________________________________________________________________ TO STRING

	/**
	* Returns a string value representing the material properties in the specified BitmapMaterial object.
	*
	* @return	A string.
	*/
	public override function toString(): String
	{
		return 'Texture:' + this.texture + ' lineColor:' + this.lineColor + ' lineAlpha:' + this.lineAlpha;
	}


	// ______________________________________________________________________ CREATE BITMAP

	private function createBitmap( asset:Dynamic):BitmapData
	{
		return asset;
	}


	// ______________________________________________________________________ PRIVATE VAR

	private var _texture :Dynamic;
}