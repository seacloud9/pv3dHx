﻿/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org  blog.papervision3d.org  osflash.org/papervision3d
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

// _______________________________________________________________________ PaperPlane
package org.papervision3d.objects;

import org.papervision3d.core.Number3D;
import org.papervision3d.core.NumberUV;
import org.papervision3d.core.Matrix3D;
import org.papervision3d.core.geom.Face3D;
import org.papervision3d.core.geom.Mesh3D;
import org.papervision3d.core.geom.Vertex3D;
import org.papervision3d.core.proto.CameraObject3D;
import org.papervision3d.core.proto.DisplayObjectContainer3D;
import org.papervision3d.core.proto.GeometryObject3D;
import org.papervision3d.core.proto.MaterialObject3D;
import org.papervision3d.core.proto.SceneObject3D;

import flash.display.BitmapData;

/**
* The PaperPlane class lets you create a paper plane object.
* <p/>
* Paper planes are useful for testing, when you want to know the direction an object is facing.
*/
class PaperPlane extends Mesh3D
{
	/**
	* Default value of segments.
	*/
	static public var DEFAULT_SCALE :Float = 1;


	// ___________________________________________________________________________________________________
	//                                                                                               N E W
	// NN  NN EEEEEE WW    WW
	// NNN NN EE     WW WW WW
	// NNNNNN EEEE   WWWWWWWW
	// NN NNN EE     WWW  WWW
	// NN  NN EEEEEE WW    WW

	/**
	* Creates a new PaperPlane object.
	* <p/>
	* @param	material	A Material3D object that contains the material properties of the object.
	* <p/>
	* @param	scale		[optional] - Scaling factor
	* <p/>
	* @param	initObject	[optional] - An object that contains user defined properties with which to populate the newly created GeometryObject3D.
	* <p/>
	* It includes x, y, z, rotationX, rotationY, rotationZ, scaleX, scaleY scaleZ and a user defined extra object.
	* <p/>
	* If extra is not an object, it is ignored. All properties of the extra field are copied into the new instance. The properties specified with extra are publicly available.
	*/
	public function new( ?material :MaterialObject3D, scale :Float)
	{
		super( material, new Array(), new Array(), null);

		scale = if(scale==0) DEFAULT_SCALE else scale;

		buildPaperPlane( scale );
	}


	private function buildPaperPlane( scale :Float ):Void
	{
		var a :Float = 100 * scale;
		var b :Float = a/2;
		var c :Float = b/3;

		var v:Array<Vertex3D> =
		[
			new Vertex3D(  0,  0,  a ),
			new Vertex3D( -b,  c, -a ),
			new Vertex3D( -c,  c, -a ),
			new Vertex3D(  0, -c, -a ),
			new Vertex3D(  c,  c, -a ),
			new Vertex3D(  b,  c, -a )
		];

		this.geometry.vertices = v;

		this.geometry.faces =
		[
			new Face3D( [v[0], v[1], v[2]] ),
			new Face3D( [v[0], v[2], v[3]] ),
			new Face3D( [v[0], v[3], v[4]] ),
			new Face3D( [v[0], v[4], v[5]] )
		];

		this.projectTexture();

		this.geometry.ready = true;
	}
	public override function projectTexture():Void
	{
		var faces :Array<Face3D>  = this.geometry.faces;

		var bBox  :Dynamic = this.boundingBox();
		var minX  :Float = bBox.min.x;
		var sizeX :Float = bBox.size.x;
		var minY  :Float = bBox.min.z;
		var sizeY :Float = bBox.size.z;

		var objectMaterial :MaterialObject3D = this.material;

		for( i in 0...faces.length )
		{
			var myFace     :Face3D = faces[i];
			var myVertices :Array<Vertex3D>  = myFace.vertices;

			var a :Vertex3D = myVertices[0];
			var b :Vertex3D = myVertices[1];
			var c :Vertex3D = myVertices[2];

			var uvA :NumberUV = new NumberUV( (a.x - minX) / sizeX, (a.z - minY) / sizeY );
			var uvB :NumberUV = new NumberUV( (b.x - minX) / sizeX, (b.z - minY) / sizeY );
			var uvC :NumberUV = new NumberUV( (c.x - minX) / sizeX, (c.z - minY) / sizeY );

			myFace.uv = [ uvA, uvB, uvC ];

		}
    }
}
