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
//                                               GeometryObject3D: Mesh3D
package org.papervision3d.core.geom;

import flash.display.BitmapData;
import flash.display.Sprite;

import org.papervision3d.core.BoundingBox;
import org.papervision3d.Papervision3D;
import org.papervision3d.core.Matrix3D;
import org.papervision3d.core.Number3D;
import org.papervision3d.core.NumberUV;
import org.papervision3d.core.geom.Face3D;
import org.papervision3d.core.geom.Mesh3D;
import org.papervision3d.core.geom.Vertex3D;
import org.papervision3d.core.geom.Vertex2D;
import org.papervision3d.core.proto.GeometryObject3D;
import org.papervision3d.core.proto.MaterialObject3D;
import org.papervision3d.core.proto.CameraObject3D;
import org.papervision3d.core.proto.SceneObject3D;

import org.papervision3d.objects.DisplayObject3D;

import org.papervision3d.core.utils.VertexHash;


/**
* The Mesh3D class lets you create and display solid 3D objects made of vertices and triangular polygons.
*/
class Mesh3D extends Vertices3D
{
	// ___________________________________________________________________________________________________
	//                                                                                               N E W
	// NN  NN EEEEEE WW    WW
	// NNN NN EE     WW WW WW
	// NNNNNN EEEE   WWWWWWWW
	// NN NNN EE     WWW  WWW
	// NN  NN EEEEEE WW    WW

	/**
	* Creates a new Mesh object.
	*
	* The Mesh DisplayObject3D class lets you create and display solid 3D objects made of vertices and triangular polygons.
	* <p/>
	* @param	material	A MaterialObject3D object that contains the material properties of the object.
	* <p/>
	* @param	vertices	An array of Vertex3D objects for the vertices of the mesh.
	* <p/>
	* @param	faces		An array of Face3D objects for the faces of the mesh.
	* <p/>
	* It includes x, y, z, rotationX, rotationY, rotationZ, scaleX, scaleY scaleZ and a user defined extra object.
	* <p/>
	* If extra is not an object, it is ignored. All properties of the extra field are copied into the new instance. The properties specified with extra are publicly available.
	* <ul>
	* <li><b>sortFaces</b>: Z-depth sorting when rendering. Some objects might not need it. Default is false (faster).</li>
	* <li><b>showFaces</b>: Use only if each face is on a separate MovieClip container. Default is false.</li>
	* </ul>
	*
	*/
	public function new( material:MaterialObject3D, vertices:Array<Vertex3D>, faces:Array<Face3D>, ?name:String)
	{
		super( vertices, name);

		this.geometry.faces = if(faces==null)  new Array() else faces;
		this.material       = if(material==null)  MaterialObject3D.DEFAULT else material;
	}

	// ___________________________________________________________________________________________________
	//                                                                                       P R O J E C T
	// PPPPP  RRRRR   OOOO      JJ EEEEEE  CCCC  TTTTTT
	// PP  PP RR  RR OO  OO     JJ EE     CC  CC   TT
	// PPPPP  RRRRR  OO  OO     JJ EEEE   CC       TT
	// PP     RR  RR OO  OO JJ  JJ EE     CC  CC   TT
	// PP     RR  RR  OOOO   JJJJ  EEEEEE  CCCC    TT

	/**
	* Projects three dimensional coordinates onto a two dimensional plane to simulate the relationship of the camera to subject.
	*
	* This is the first step in the process of representing three dimensional shapes two dimensionally.
	*
	* @param	camera	Camera3D object to render from.
	*/
	public override function project( parent :DisplayObject3D, camera :CameraObject3D, ?sorted :Array<Face> ):Float
	{
		// Vertices
		super.project( parent, camera, sorted );

		if(sorted==null ) sorted = this._sorted;

		var projected:Dynamic = this.projected;
		var view:Matrix3D = this.view;

		// Faces
		var faces        :Array<Face3D>  = this.geometry.faces;
		var iFaces       :Array<Face>  = this.faces;
		var screenZs     :Float = 0.0;
		var visibleFaces :Float = 0.0;

		var vertex0 :Vertex2D, vertex1 :Vertex2D, vertex2 :Vertex2D,  iFace:Face;

		for( i in 0...faces.length)
		{
			if(iFaces[i]==null) iFaces[i]=new Face();
			iFace = iFaces[i] ;
			iFace.face = faces[i];
			iFace.instance = this;

			vertex0 = projected.get( faces[i].vertices[0] );
			vertex1 = projected.get( faces[i].vertices[1] );
			vertex2 = projected.get( faces[i].vertices[2] );

			iFace.visible = (vertex0.visible && vertex1.visible && vertex2.visible);

			if( iFace.visible )
			{
				screenZs += iFace.screenZ = ( vertex0.z + vertex1.z + vertex2.z ) /3;
				visibleFaces++;

				if( sorted!=null ) sorted.push( iFace );
			}
		}

		return this.screenZ = screenZs / visibleFaces;
	}


	/**
	* Planar projection from the specified plane.
	*
	* @param	u	The texture horizontal axis. Can be "x", "y" or "z". The default value is "x".
	* @param	v	The texture vertical axis. Can be "x", "y" or "z". The default value is "y".
	*/
	/**
	* FixMe
	* @param	?u
	* @param	?v
	*/
	public function projectTexture():Void
	{
		var faces :Array<Face3D>  = this.geometry.faces;

		var bBox  :BoundingBox = this.boundingBox();
		var minX  :Float = bBox.min.x;
		var sizeX :Float = bBox.size.x;
		var minY  :Float = bBox.min.y;
		var sizeY :Float = bBox.size.y;

		var objectMaterial :MaterialObject3D = this.material;
		var myFace:Face3D;
		var myVertices :Array<Vertex3D>;
		var a :Vertex3D;
		var b :Vertex3D;
		var c :Vertex3D;
		var uvA :NumberUV;
		var uvB :NumberUV;
		var uvC :NumberUV;

		for( i in 0...faces.length )
		{
			myFace = faces[i];
			myVertices = myFace.vertices;

			a = myVertices[0];
			b = myVertices[1];
			c = myVertices[2];

			uvA = new NumberUV( (a.x - minX) / sizeX, (a.y - minY) / sizeY );
			uvB = new NumberUV( (b.x - minX) / sizeX, (b.y - minY) / sizeY );
			uvC = new NumberUV( (c.x - minX) / sizeX, (c.y - minY) / sizeY );

			myFace.uv = [ uvA, uvB, uvC ];

		}
	}
}