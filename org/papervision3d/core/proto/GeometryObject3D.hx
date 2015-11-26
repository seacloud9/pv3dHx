﻿/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org • blog.papervision3d.org • osflash.org/papervision3d
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
//                                               DisplayObjectContainer3D

package org.papervision3d.core.proto;

import org.papervision3d.Papervision3D;
import org.papervision3d.core.Matrix3D;
import org.papervision3d.core.Number3D;
import org.papervision3d.core.NumberUV;
import org.papervision3d.core.geom.Face3D;
import org.papervision3d.core.geom.Vertex3D;
import org.papervision3d.core.geom.Vertex2D;
import org.papervision3d.core.geom.Vertices3D;
import org.papervision3d.core.geom.Mesh3D;
import org.papervision3d.core.proto.MaterialObject3D;
import org.papervision3d.scenes.Scene3D;
import org.papervision3d.scenes.MovieScene3D;
import org.papervision3d.objects.DisplayObject3D;

import flash.events.EventDispatcher;

/**
* The GeometryObject3D class contains the mesh definition of an object.
*/
class GeometryObject3D extends EventDispatcher
{
	/**
	* A MaterialObject3D object that contains the material properties of the triangle.
	*/
//	public var material :MaterialObject3D;
/*
	public function get material():MaterialObject3D
	{
		return this._material;
	}

	public function set material( newMaterial:MaterialObject3D ):void
	{
		transformUV( newMaterial );
		this._material = newMaterial;
	}

    
	public var materials :MaterialsList;
*/
	/**
	* Radius square of the mesh bounding sphere
	*/
	public var boundingSphere2(get_boundingSphere2,null):Float;
	private function get_boundingSphere2():Float
	{
		if( _boundingSphereDirty )
			return getBoundingSphere2();
		else
			return _boundingSphere2;
	}


	/**
	* An array of Face3D objects for the faces of the mesh.
	*/
	public var faces  :Array<Face3D>;

	/**
	* An array of vertices.
	*/
	public var vertices :Array<Vertex3D>;

	public function transformVertices( transformation:Matrix3D ):Void {}

	public var ready :Bool ;

	// ___________________________________________________________________________________________________
	//                                                                                               N E W
	// NN  NN EEEEEE WW    WW
	// NNN NN EE     WW WW WW
	// NNNNNN EEEE   WWWWWWWW
	// NN NNN EE     WWW  WWW
	// NN  NN EEEEEE WW    WW

	public function new()
	{
		super();
		_boundingSphereDirty=true;
		ready=false;
//		this.materials = new MaterialsList();
	}


	/**
	* Returns a string value representing the three-dimensional values in the specified Number3D object.
	*
	* @return	A string.
	*/
	//public function toString():String
	//{
		//return 'x:' + Math.floor(this.x) + ' y:' + Math.floor(this.y) + ' z:' + Math.floor(this.z);
	//}

//	public function project( instance :DisplayObject3D, camera :CameraObject3D, sorted :Array ):Number { return 0; }

	// ___________________________________________________________________________________________________
	//                                                                                         R E N D E R
	// RRRRR  EEEEEE NN  NN DDDDD  EEEEEE RRRRR
	// RR  RR EE     NNN NN DD  DD EE     RR  RR
	// RRRRR  EEEE   NNNNNN DD  DD EEEE   RRRRR
	// RR  RR EE     NN NNN DD  DD EE     RR  RR
	// RR  RR EEEEEE NN  NN DDDDD  EEEEEE RR  RR

	/**
	* Draws the object into the MovieClip container.
	*
	* @param	scene	A Papervision3D object that contains the current scene.
	*/
//	public function render( instance:DisplayObject3D, scene:SceneObject3D, sorted :Array=null ):void {}


	public function transformUV( material:MaterialObject3D ):Void
	{
		if( material.bitmap!=null ){
			for( i in 0...faces.length ){}
			    //FIXME
				//faces[i].transformUV( material );
		}
	}

	public function getBoundingSphere2():Float
	{
		var max :Float = 0;
		var d   :Float;
		var v:Vertex3D;

		for( i in 0...this.vertices.length )
		{
			v=this.vertices[i];
			d = v.x*v.x + v.y*v.y + v.z*v.z;

			max = if(d > max)  d else max;
		}

		this._boundingSphereDirty = false;

		return _boundingSphere2 = max;
	}

	// ___________________________________________________________________________________________________
	//                                                                                       P R I V A T E

	private var _material        :MaterialObject3D;

	private var _boundingSphere2     :Float;
	private var _boundingSphereDirty :Bool ;
}