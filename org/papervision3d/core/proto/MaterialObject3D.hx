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

// _______________________________________________________________________ MaterialObject3D

package org.papervision3d.core.proto;

import flash.geom.Matrix;
import flash.display.BitmapData;

/**
* The MaterialObject3D class is the base class for all materials.
* <p/>
* Materials collects data about how objects appear when rendered.
* <p/>
* A material is data that you assign to objects or faces, so that they appear a certain way when rendered. Materials affect the line and fill colors.
* <p/>
* Materials create greater realism in a scene. A material describes how an object reflects or transmits light.
* <p/>
* You assign materials to individual objects or a selection of faces; a single object can contain different materials.
* <p/>
* MaterialObject3D is an abstract base class; therefore, you cannot call MaterialObject3D directly.
*/
class MaterialObject3D
{
	/**
	* A transparent or opaque BitmapData texture.
	*/
	public var bitmap :BitmapData;

	/**
	* A Bool value that determines whether the texture is animated.
	*
	* If set, the material must be included into the scene so the BitmapData texture can be updated when rendering. For performance reasons, the default value is false.
	*/
	public var animated :Bool;

	/**
	* A Bool value that determines whether the BitmapData texture is smoothed when rendered.
	*/
	public var smooth :Bool;


	/**
	* A RGB color value to draw the faces outline.
	*/
	public var lineColor :UInt;

	/**
	* An 8-bit alpha value for the faces outline. If zero, no outline is drawn.
	*/
	public var lineAlpha :Float;


	/**
	* A RGB color value to fill the faces with. Only used if no texture is provided.
	*/
	public var fillColor :UInt;

	/**
	* An 8-bit alpha value fill the faces with. If this value is zero and no texture is provided or is undefined, a fill is not created.
	*/
	public var fillAlpha :Float;
	
	/**
	* A Bool value that indicates whether the faces are double sided.
	*/
	public var doubleSided(get_doubleSided,set_doubleSided):Bool;


	private function get_doubleSided():Bool
	{
		return ! this.oneSide;
	}

	private function set_doubleSided( double:Bool ):Bool
	{
		this.oneSide = ! double;
		return double;
	}

	/**
	* A Bool value that indicates whether the faces are single sided. It has preference over doubleSided.
	*/
	public var oneSide :Bool;


	/**
	* A Bool value that indicates whether the faces are invisible (not drawn).
	*/
	public var invisible :Bool;

	/**
	* A Bool value that indicates whether the face is flipped. Only used if doubleSided or not singeSided.
	*/
	public var opposite :Bool;

	/**
	* The scene where the object belongs.
	*/
	public var scene :SceneObject3D;

	/**
	* Default color used for debug.
	*/
	static public var DEFAULT_COLOR :Int = 0xFF00FF;

	/**
	* The name of the material.
	*/
	public var name :String;

	/**
	* [internal-use] [read-only] Unique id of this instance.
	*/
	public var id :Int;
	
	static public var DEFAULT(get_DEFAULT,null):MaterialObject3D;

	/**
	* Creates a new MaterialObject3D object.
	*
	* @param	initObject	[optional] - An object that contains properties for the newly created material.
	*/
	public function new()
	{
		this.bitmap = null;

		// Color
		this.lineColor = DEFAULT_COLOR ;
		this.lineAlpha = 0.0 ;

		this.fillColor = DEFAULT_COLOR ;
		this.fillAlpha = 0.0 ;

		this.animated  = false ;

		// Defaults
		this.invisible = false ;
		this.smooth    = false ;

		this.doubleSided = false ;
		this.opposite =    false ;

		this.id = _totalMaterialObjects++;
	}

	/**
	* Returns a MaterialObject3D object with the default magenta wireframe values.
	*
	* @return A MaterialObject3D object.
	*/
	static private function get_DEFAULT():MaterialObject3D
	{
		var defMaterial :MaterialObject3D = new MaterialObject3D();

		defMaterial.lineColor   = DEFAULT_COLOR;
		defMaterial.lineAlpha   = 1.;
		defMaterial.fillColor   = DEFAULT_COLOR;
		defMaterial.fillAlpha   = 1.;
		defMaterial.doubleSided = true;

		return defMaterial;
	}


	/**
	* Updates the BitmapData bitmap from the given texture.
	*
	* Draws the current MovieClip image onto bitmap.
	*/
	public function updateBitmap():Void {}


	/**
	* Copies the properties of a material.
	*
	* @param	material	Material to copy from.
	*/
	public function copy( material :MaterialObject3D ):Void
	{
		this.bitmap    = material.bitmap;
		this.animated  = material.animated;
		this.smooth    = material.smooth;

		this.lineColor = material.lineColor;
		this.lineAlpha = material.lineAlpha;
		this.fillColor = material.fillColor;
		this.fillAlpha = material.fillAlpha;

		this.oneSide   = material.oneSide;
		this.opposite   = material.opposite;

		this.invisible = material.invisible;
		this.scene     = material.scene;
		this.name      = material.name;
	}

	/**
	* Creates a copy of the material.
	*
	* @return	A newly created material that contains the same properties.
	*/
	public function clone():MaterialObject3D
	{
		var cloned:MaterialObject3D = new MaterialObject3D();

		cloned.bitmap    = this.bitmap;
		cloned.animated  = this.animated;
		cloned.smooth    = this.smooth;

		cloned.lineColor = this.lineColor;
		cloned.lineAlpha = this.lineAlpha;
		cloned.fillColor = this.fillColor;
		cloned.fillAlpha = this.fillAlpha;

		cloned.oneSide   = this.oneSide;
		cloned.opposite  = this.opposite;

		cloned.invisible = this.invisible;
		cloned.scene     = this.scene;
		cloned.name      = this.name;

		return cloned;
	}

	/**
	* Returns a string value representing the material properties.
	*
	* @return	A string.
	*/
	public function toString():String
	{
		return '[MaterialObject3D] bitmap:' + this.bitmap + ' lineColor:' + this.lineColor + ' fillColor:' + fillColor;
	}

	static private var _totalMaterialObjects :Int=0 ;
}