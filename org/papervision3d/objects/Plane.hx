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
//                                                GeometryObject3D: Plane
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
* The Plane class lets you create and display flat rectangle objects.
* <p/>
* The rectangle can be divided in smaller segments. This is usually done to reduce linear mapping artifacts.
* <p/>
* Dividing the plane in the direction of the perspective or vanishing point, helps to reduce this problem. Perspective distortion dissapears when the plane is facing straignt to the camera, i.e. it is perpendicular with the vanishing point of the scene.
*/
class Plane extends Mesh3D
{
	/**
	* Number of segments horizontally. Defaults to 1.
	*/
	public var segmentsW :Int;

	/**
	* Number of segments vertically. Defaults to 1.
	*/
	public var segmentsH :Int;

	/**
	* Default size of Plane if not texture is defined.
	*/
	static public var DEFAULT_SIZE :Float = 500;

	/**
	* Default size of Plane if not texture is defined.
	*/
	static public var DEFAULT_SCALE :Float = 1;

	/**
	* Default value of gridX if not defined. The default value of gridY is gridX.
	*/
	static public var DEFAULT_SEGMENTS :Int = 1;


	// ___________________________________________________________________________________________________
	//                                                                                               N E W
	// NN  NN EEEEEE WW    WW
	// NNN NN EE     WW WW WW
	// NNNNNN EEEE   WWWWWWWW
	// NN NNN EE     WWW  WWW
	// NN  NN EEEEEE WW    WW

	/**
	* Create a new Plane object.
	* <p/>
	* @param	material	A MaterialObject3D object that contains the material properties of the object.
	* <p/>
	* @param	width		[optional] - Desired width or scaling factor if there's bitmap texture in material and no height is supplied.
	* <p/>
	* @param	height		[optional] - Desired height.
	* <p/>
	* @param	segmentsW	[optional] - Number of segments horizontally. Defaults to 1.
	* <p/>
	* @param	segmentsH	[optional] - Number of segments vertically. Defaults to segmentsW.
	* <p/>
	* @param	initObject	[optional] - An object that contains user defined properties with which to populate the newly created GeometryObject3D.
	* <p/>
	* It includes x, y, z, rotationX, rotationY, rotationZ, scaleX, scaleY scaleZ and a user defined extra object.
	* <p/>
	* If extra is not an object, it is ignored. All properties of the extra field are copied into the new instance. The properties specified with extra are publicly available.
	*/
	public function new( ?material:MaterialObject3D, ?width:Float, ?height:Float, ?segmentsW:Int, ?segmentsH:Int)
	{
		super( material, new Array(), new Array(), null);

		this.segmentsW = if(segmentsW==null) DEFAULT_SEGMENTS else segmentsW ; // Defaults to 1
		this.segmentsH = if(segmentsH==null) this.segmentsW        else segmentsH ; // Defaults to segmentsW
        
		buildPlane( width, height );
	}

	private function buildPlane( width:Float, height:Float ):Void
	{
		var gridX    :Int = this.segmentsW;
		var gridY    :Int = this.segmentsH;
		var gridX1   :Int = gridX + 1;
		var gridY1   :Int = gridY + 1;

		var vertices :Array<Vertex3D>  = this.geometry.vertices;
		var faces    :Array<Face3D>  = this.geometry.faces;

		var textureX :Float = width /2;
		var textureY :Float = height /2;

		var iW       :Float = width / gridX;
		var iH       :Float = height / gridY;

		// Vertices
		for( ix in 0...gridX1)
		{
			for( iy in 0...gridY1)
			{
				var x :Float = ix * iW - textureX;
				var y :Float = iy * iH - textureY;
                
				vertices.push( new Vertex3D( x, y, 0 ) );
			}
		}
		// Faces
		var uvA :NumberUV;
		var uvC :NumberUV;
		var uvB :NumberUV;

		for( ix in 0...gridX )
		{
			for( iy in 0...gridY )
			{
				// Triangle A
				var a:Vertex3D = vertices[ ix     * gridY1 + iy     ];
				var c:Vertex3D = vertices[ ix     * gridY1 + (iy+1) ];
				var b:Vertex3D = vertices[ (ix+1) * gridY1 + iy     ];

				uvA =  new NumberUV( ix     / gridX, iy     / gridY );
				uvC =  new NumberUV( ix     / gridX, (iy+1) / gridY );
				uvB =  new NumberUV( (ix+1) / gridX, iy     / gridY );

				faces.push( new Face3D( [ a, b, c ], null, [ uvA, uvB, uvC ] ) );

				// Triangle B
				a = vertices[ (ix+1) * gridY1 + (iy+1) ];
				c = vertices[ (ix+1) * gridY1 + iy     ];
				b = vertices[ ix     * gridY1 + (iy+1) ];

				uvA =  new NumberUV( (ix+1) / gridX, (iy+1) / gridY );
				uvC =  new NumberUV( (ix+1) / gridX, iy      / gridY );
				uvB =  new NumberUV( ix      / gridX, (iy+1) / gridY );

				faces.push( new Face3D( [ a, b, c ], null, [ uvA, uvB, uvC ] ) );
			}
		}
		this.geometry.ready = true;
	}
}