/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org � blog.papervision3d.org � osflash.org/papervision3d
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
//                                               GeometryObject3D: Points
package org.papervision3d.core.geom;

import org.papervision3d.core.Matrix3D;
import org.papervision3d.core.BoundingBox;
import org.papervision3d.core.Number3D;
import org.papervision3d.core.NumberUV;
import org.papervision3d.core.Number4D;
import org.papervision3d.core.geom.Face3D;
import org.papervision3d.core.geom.Mesh3D;
import org.papervision3d.core.geom.Vertex3D;
import org.papervision3d.core.proto.CameraObject3D;
import org.papervision3d.core.proto.GeometryObject3D;
import org.papervision3d.core.proto.MaterialObject3D;
import org.papervision3d.core.proto.SceneObject3D;
import org.papervision3d.scenes.MovieScene3D;
import org.papervision3d.scenes.Scene3D;
import org.papervision3d.objects.DisplayObject3D;

import org.papervision3d.core.utils.VertexHash;

/**
* The Vertices3D class lets you create and manipulate groups of vertices.
*
*/
class Vertices3D extends DisplayObject3D
{
	// ___________________________________________________________________________________________________
	//                                                                                               N E W
	// NN  NN EEEEEE WW    WW
	// NNN NN EE     WW WW WW
	// NNNNNN EEEE   WWWWWWWW
	// NN NNN EE     WWW  WWW
	// NN  NN EEEEEE WW    WW

	/**
	* Creates a new Points object.
	*
	* The Points GeometryObject3D class lets you create and manipulate groups of vertices.
	*
	* @param	vertices	An array of Vertex3D objects for the vertices of the mesh.
	* <p/>
	* @param	initObject	[optional] - An object that contains user defined properties with which to populate the newly created GeometryObject3D.
	* <p/>
	* It includes x, y, z, rotationX, rotationY, rotationZ, scaleX, scaleY scaleZ and a user defined extra object.
	* <p/>
	* If extra is not an object, it is ignored. All properties of the extra field are copied into the new instance. The properties specified with extra are publicly available.
	*/
	public function new( vertices:Array<Vertex3D>, ?name:String)
	{
		super( name, new GeometryObject3D());

		this.geometry.vertices = if(vertices==null)  new Array() else vertices;
	}

	// ___________________________________________________________________________________________________
	//                                                                                   T R A N S F O R M
	// TTTTTT RRRRR    AA   NN  NN  SSSSS FFFFFF OOOO  RRRRR  MM   MM
	//   TT   RR  RR  AAAA  NNN NN SS     FF    OO  OO RR  RR MMM MMM
	//   TT   RRRRR  AA  AA NNNNNN  SSSS  FFFF  OO  OO RRRRR  MMMMMMM
	//   TT   RR  RR AAAAAA NN NNN     SS FF    OO  OO RR  RR MM M MM
	//   TT   RR  RR AA  AA NN  NN SSSSS  FF     OOOO  RR  RR MM   MM

	/**
	* Projects three dimensional coordinates onto a two dimensional plane to simulate the relationship of the camera to subject.
	*
	* This is the first step in the process of representing three dimensional shapes two dimensionally.
	*
	* @param	camera		Camera.
	*/
	public override function project( parent :DisplayObject3D, camera :CameraObject3D, ?sorted :Array<Face> ):Float
	{
		super.project( parent, camera, sorted );

		var projected:Dynamic = this.projected;
		var view:Matrix3D = this.view;

		// Camera
		var m11 :Float = view.n11;
		var m12 :Float = view.n12;
		var m13 :Float = view.n13;
		var m21 :Float = view.n21;
		var m22 :Float = view.n22;
		var m23 :Float = view.n23;
		var m31 :Float = view.n31;
		var m32 :Float = view.n32;
		var m33 :Float = view.n33;

		var vertices :Array<Vertex3D>  = this.geometry.vertices;
		var i        :Int    = vertices.length-1;

		var focus    :Float = camera.focus;
		var zoom     :Float = camera.zoom;
		var vertex   :Vertex3D, screen :Vertex2D, persp :Float;

		while( i>=0 )
		{
			vertex=vertices[i];
			// Center position
			var vx :Float =  vertex.x;
			var vy :Float =  vertex.y;
			var vz :Float =  vertex.z;

			var s_x :Float = vx * m11 + vy * m12 + vz * m13 + view.n14;
			var s_y :Float = vx * m21 + vy * m22 + vz * m23 + view.n24;
			var s_z :Float = vx * m31 + vy * m32 + vz * m33 + view.n34;
            //FIXME
			if(projected.get(vertex)==null)
			{
				projected.set(vertex,new Vertex2D());
			}
			screen =projected.get(vertex);

			if( screen.visible = ( s_z > 0.0 ) )
			{
				persp  = focus / (focus + s_z) * zoom;

				screen.x = s_x * persp;
				screen.y = s_y * persp;
				screen.z = s_z;
			}
			i--;
		}

		return 0.0; //screenZ;
	}


	/**
	* Calculates 3D bounding box.
	*
	* @return	{minX, maxX, minY, maxY, minZ, maxZ}
	*/
	public function boundingBox():BoundingBox
	{
		var vertices :Array<Vertex3D> = this.geometry.vertices;
		var bBox     :BoundingBox=new BoundingBox() ;

		for( i in 0...vertices.length )
		{
			var v:Vertex3D = vertices[i];

			bBox.min.x = Math.min( v.x, bBox.min.x );
			bBox.max.x = Math.max( v.x, bBox.max.x );

			bBox.min.y = Math.min( v.y, bBox.min.y );
			bBox.max.y = Math.max( v.y, bBox.max.y );

			bBox.min.z = Math.min( v.z, bBox.min.z );
			bBox.max.z = Math.max( v.z, bBox.max.z );
		}

		bBox.size.x = bBox.max.x - bBox.min.x;
		bBox.size.y = bBox.max.y - bBox.min.y;
		bBox.size.z = bBox.max.z - bBox.min.z;

		return bBox;
	}

	public function transformVertices( transformation:Matrix3D ):Void
	{
		var m11 :Float = transformation.n11;
		var m12 :Float = transformation.n12;
		var m13 :Float = transformation.n13;
		var m21 :Float = transformation.n21;
		var m22 :Float = transformation.n22;
		var m23 :Float = transformation.n23;
		var m31 :Float = transformation.n31;
		var m32 :Float = transformation.n32;
		var m33 :Float = transformation.n33;

		var m14 :Float = transformation.n14;
		var m24 :Float = transformation.n24;
		var m34 :Float = transformation.n34;

		var vertices :Array<Vertex3D>  = this.geometry.vertices;
		var i        :Int    = vertices.length-1;

		var vertex   :Vertex3D;
		var vx:Float;
		var vy:Float;
		var vz:Float;
		var tx:Float;
		var ty:Float;
		var tz:Float;

		// trace( "transformed " + i ); // DEBUG

		while( i>0 )
		{
			vertex = vertices[--i];
			// Center position
			vx = vertex.x;
			vy = vertex.y;
			vz = vertex.z;

			tx = vx * m11 + vy * m12 + vz * m13 + m14;
			ty = vx * m21 + vy * m22 + vz * m23 + m24;
			tz = vx * m31 + vy * m32 + vz * m33 + m34;

			vertex.x = tx;
			vertex.y = ty;
			vertex.z = tz;
			i--;
		}
	}

	// ___________________________________________________________________________________________________
	//                                                                                         R E N D E R
	// RRRRR  EEEEEE NN  NN DDDDD  EEEEEE RRRRR
	// RR  RR EE     NNN NN DD  DD EE     RR  RR
	// RRRRR  EEEE   NNNNNN DD  DD EEEE   RRRRR
	// RR  RR EE     NN NNN DD  DD EE     RR  RR
	// RR  RR EEEEEE NN  NN DDDDD  EEEEEE RR  RR

	// public function render() {}
}