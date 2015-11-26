/*
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
//                                                                 Face3D

package org.papervision3d.core.geom;

import org.papervision3d.Papervision3D;
import org.papervision3d.core.Matrix3D;
import org.papervision3d.core.Number3D;
import org.papervision3d.core.NumberUV;
import org.papervision3d.core.proto.MaterialObject3D;
import org.papervision3d.core.geom.Vertices3D;
import org.papervision3d.core.geom.Mesh3D;
import org.papervision3d.core.geom.Vertex3D;

import org.papervision3d.objects.DisplayObject3D;

import flash.geom.Matrix;
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Graphics;
import org.papervision3d.core.utils.VertexHash;
typedef Map= {
	var _a:Float;
	var _b:Float;
	var _c:Float;
	var _d:Float;
	var _tx:Float;
	var _ty:Float;
}

/**
* The Face3D class lets you render linear textured triangles. It also supports solid colour fill and hairline outlines.
*
*/
class Face3D
{
	/**
	* An array of Vertex3D objects for the three vertices of the triangle.
	*/
	public var vertices :Array<Vertex3D>;


	/**
	* A material id TODO
	*/
	public var materialName :String;
/*
	private var _materialName :String;

	public function get materialName():String
	{
		return this._materialName;
	}

	public function set materialName( name:String ):void
	{
		this._materialName = name;
		this._material     =
		this._transformed = true;
	}
*/

	/**
	* A MaterialObject3D object that contains the material properties of the back of a single sided triangle.
	*/
//	public var materialBack :MaterialObject3D;


	/**
	* An array of {x,y} objects for the corresponding UV pixel coordinates of each triangle vertex.
	*/
	public var uv :Array<NumberUV>;

	// ______________________________________________________________________

	/**
	* [read-only] The average depth (z coordinate) of the transformed triangle. Also known as the distance from the camera. Used internally for z-sorting.
	*/
	public var screenZ :Float;

	/**
	* [read-only] A Boolean value that indicates that the face is visible, i.e. it's vertices are in front of the camera.
	*/
	public var visible :Bool;


	/**
	* The object where the face belongs.
	*/
//	public var object :Mesh3D;


	/**
	* [read-only] Unique id of this instance.
	*/
	public var id :Int;


	/**
	* The Face3D constructor lets you create linear textured or solid colour triangles.
	*
	* @param	vertices	An array of Vertex3D objects for the three vertices of the triangle.
	* @param	material	A MaterialObject3D object that contains the material properties of the triangle.
	* @param	uv			An array of {x,y} objects for the corresponding UV pixel coordinates of each triangle vertex.
	*/
	public function new( vertices:Array<Vertex3D>, ?materialName:String, ?uv:Array<NumberUV> )
	{
//		this.object = object;

		// Vertices
		this.vertices = vertices;

		// Material
		this.materialName = if(materialName!=null) materialName else "" ;
		this.uv = uv;

//		if( uv && material && material.bitmap ) transformUV();

		this.id = _totalFaces++;

		if(_bitmapMatrix==null ) _bitmapMatrix = new Matrix();
	}

	/**
	* Applies the updated UV texture mapping values to the triangle. This is required to speed up rendering.
	*
	*/
	public function transformUV( ?instance:DisplayObject3D):Map
	{
		var material :MaterialObject3D = if(instance!=null && this.materialName!=null && instance.materials!=null ) instance.materials.getMaterialByName( this.materialName ) else instance.material;
        var mapping:Map = null;
		if( this.uv==null )
		{
			Papervision3D.log( "Face3D: transformUV() uv not found!" );
		}
		else if( material!=null && material.bitmap!=null )
		{
			var uv :Array<NumberUV>  = this.uv;

			var w  :Int = material.bitmap.width;
			var h  :Int = material.bitmap.height;

			var u0 :Float = w * uv[0].u;
			var v0 :Float = h * ( 1 - uv[0].v );
			var u1 :Float = w * uv[1].u;
			var v1 :Float = h * ( 1 - uv[1].v );
			var u2 :Float = w * uv[2].u;
			var v2 :Float = h * ( 1 - uv[2].v );

			// Fix perpendicular projections
			if( (u0 == u1 && v0 == v1) || (u0 == u2 && v0 == v2) )
			{
				u0 -= if(u0 > 0.05)  0.05 else -0.05;
				v0 -= if(v0 > 0.07)  0.07 else -0.07;
			}

			if( u2 == u1 && v2 == v1 )
			{
				u2 -= if(u2 > 0.05)  0.04 else -0.04;
				v2 -= if(v2 > 0.06)  0.06 else -0.06;
			}

			// Precalculate matrix
			var at :Float = ( u1 - u0 );
			var bt :Float = ( v1 - v0 );
			var ct :Float = ( u2 - u0 );
			var dt :Float = ( v2 - v0 );

			var m :Matrix = new Matrix( at, bt, ct, dt, u0, v0 );
			m.invert();

			//FIXME
			//mapping= instance.projected[ this ] ;
			mapping={_a:m.a,_b:m.b,_c:m.c,_d:m.d,_tx:m.tx,_ty:m.ty};
			//mapping._a  = m.a;
			//mapping._b  = m.b;
			//mapping._c  = m.c;
			//mapping._d  = m.d;
			//mapping._tx = m.tx;
			//mapping._ty = m.ty;
		}
		else Papervision3D.log( "Face3D: transformUV() material.bitmap not found!" );

		return mapping;
	}


	// ______________________________________________________________________________
	//                                                                         RENDER
	// RRRRR  EEEEEE NN  NN DDDDD  EEEEEE RRRRR
	// RR  RR EE     NNN NN DD  DD EE     RR  RR
	// RRRRR  EEEE   NNNNNN DD  DD EEEE   RRRRR
	// RR  RR EE     NN NNN DD  DD EE     RR  RR
	// RR  RR EEEEEE NN  NN DDDDD  EEEEEE RR  RR

	/**
	* Draws the triangle into its MovieClip container.
	*
	* @param	container	The default MovieClip that you draw into when rendering.
	* @param	randomFill		A Boolean value that indicates whether random coloring is enabled. Typically used for debug purposes. Defaults to false.
	* @return					The number of triangles drawn. Either one if it is double sided or visible, or zero if it single sided and not visible.
	*
	*/
	public function render( instance:DisplayObject3D, container:Sprite ): Float
	{
		var vertices  :Array<Vertex3D>      = this.vertices;
		var projected :VertexHash<Vertex2D> = instance.projected;

		var s0 :Vertex2D = projected.get(vertices[0]);
		var s1 :Vertex2D = projected.get(vertices[1]);
		var s2 :Vertex2D = projected.get(vertices[2]);

		var x0 :Float = s0.x;
		var y0 :Float = s0.y;
		var x1 :Float = s1.x;
		var y1 :Float = s1.y;
		var x2 :Float = s2.x;
		var y2 :Float = s2.y;

		var material :MaterialObject3D = if( this.materialName!=null && instance.materials!=null ) instance.materials.getMaterialByName( this.materialName ) else instance.material;

		// Invisible?
		if( material.invisible ) return 0.0;

		// Double sided?
		if( material.oneSide )
		{
			if( material.opposite )
			{
				if( ( x2 - x0 ) * ( y1 - y0 ) - ( y2 - y0 ) * ( x1 - x0 ) > 0 )
				{
					return 0.;
				}
			}
			else
			{
				if( ( x2 - x0 ) * ( y1 - y0 ) - ( y2 - y0 ) * ( x1 - x0 ) < 0 )
				{
					return 0.;
				}
			}
		}

		var texture   :BitmapData  = material.bitmap;
		var fillAlpha :Float      = material.fillAlpha;
		var lineAlpha :Float      = material.lineAlpha;

		var graphics  :Graphics    = container.graphics;

		if( texture!=null )
		{
			//FIXME
			var map :Map = transformUV( instance );//instance.projected[ this ] || transformUV( instance );

			var a1  :Float = map._a;
			var b1  :Float = map._b;
			var c1  :Float = map._c;
			var d1  :Float = map._d;
			var tx1 :Float = map._tx;
			var ty1 :Float = map._ty;

			var a2  :Float = x1 - x0;
			var b2  :Float = y1 - y0;
			var c2  :Float = x2 - x0;
			var d2  :Float = y2 - y0;

			var matrix :Matrix = _bitmapMatrix;
			matrix.a = a1*a2 + b1*c2;
			matrix.b = a1*b2 + b1*d2;
			matrix.c = c1*a2 + d1*c2;
			matrix.d = c1*b2 + d1*d2;
			matrix.tx = tx1*a2 + ty1*c2 + x0;
			matrix.ty = tx1*b2 + ty1*d2 + y0;

			graphics.beginBitmapFill( texture, matrix, false, material.smooth );
		}
		else if( fillAlpha!=0 )
		{
			graphics.beginFill( material.fillColor, fillAlpha );
		}

		// Line color
		if( lineAlpha!=0 )
			graphics.lineStyle( 0, material.lineColor, lineAlpha );
		else
			graphics.lineStyle();

		// Draw triangle
		graphics.moveTo( x0, y0 );
		graphics.lineTo( x1, y1 );
		graphics.lineTo( x2, y2 );

		if( lineAlpha!=0 )
			graphics.lineTo( x0, y0 );

		if( texture!=null || fillAlpha!=0 )
			graphics.endFill();

		return 1;
	}

	// ______________________________________________________________________________
	//                                                                        PRIVATE

	static private var _totalFaces   :Int = 0;

	static private var _bitmapMatrix :Matrix;

	//private var _a  :Float;
	//private var _b  :Float;
	//private var _c  :Float;
	//private var _d  :Float;
	//private var _tx :Float;
	//private var _ty :Float;
}
