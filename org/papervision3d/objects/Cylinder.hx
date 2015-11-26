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
//                                                GeometryObject3D: Cylinder
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
* The Cylinder class lets you create and display Cylinders.
* <p/>
* The Cylinder is divided in vertical and horizontal segment, the smallest combination is two vertical and three horizontal segments.
*/
class Cylinder extends Mesh3D
{
	/**
	* Number of segments horizontally. Defaults to 8.
	*/
	public var segmentsW :Int;

	/**
	* Number of segments vertically. Defaults to 6.
	*/
	public var segmentsH :Int;

	/**
	* Default radius of Cylinder if not defined.
	*/
	static public var DEFAULT_RADIUS :Float = 100.0;

	/**
	* Default height if not defined.
	*/
	static public var DEFAULT_HEIGHT :Float = 100.0;

	/**
	* Default scale of Cylinder texture if not defined.
	*/
	static public var DEFAULT_SCALE :Float = 1.0;

	/**
	* Default value of gridX if not defined.
	*/
	static public var DEFAULT_SEGMENTSW :Int = 8;

	/**
	* Default value of gridY if not defined.
	*/
	static public var DEFAULT_SEGMENTSH :Int = 6;

	/**
	* Minimum value of gridX.
	*/
	static public var MIN_SEGMENTSW :Int = 3;

	/**
	* Minimum value of gridY.
	*/
	static public var MIN_SEGMENTSH :Int = 2;


	// ___________________________________________________________________________________________________
	//                                                                                               N E W
	// NN  NN EEEEEE WW    WW
	// NNN NN EE     WW WW WW
	// NNNNNN EEEE   WWWWWWWW
	// NN NNN EE     WWW  WWW
	// NN  NN EEEEEE WW    WW

	/**
	* Create a new Cylinder object.
	* <p/>
	* @param	material	A MaterialObject3D object that contains the material properties of the object.
	* <p/>
	* @param	radius		[optional] - Desired radius.
	* <p/>
	* @param	segmentsW	[optional] - Number of segments horizontally. Defaults to 8.
	* <p/>
	* @param	segmentsH	[optional] - Number of segments vertically. Defaults to 6.
	* <p/>
	* @param	topRadius	[optional] - An optional parameter for con- or diverging cylinders
	* <p/>
	* @param	initObject	[optional] - An object that contains user defined properties with which to populate the newly created GeometryObject3D.
	* <p/>
	* It includes x, y, z, rotationX, rotationY, rotationZ, scaleX, scaleY scaleZ and a user defined extra object.
	* <p/>
	* If extra is not an object, it is ignored. All properties of the extra field are copied into the new instance. The properties specified with extra are publicly available.
	*/
	public function new( ?material:MaterialObject3D, ?radius:Float, ?height:Float, ?segmentsW:Int, ?segmentsH:Int, ?topRadius:Float)
	{
		super( material, new Array(), new Array(), null);
        segmentsW=if(segmentsW==null) DEFAULT_SEGMENTSW else segmentsW;
		segmentsH=if(segmentsH==null) DEFAULT_SEGMENTSH else segmentsH;
		this.segmentsW = Std.int(Math.max( MIN_SEGMENTSW, segmentsW)); // Defaults to 8
		this.segmentsH = Std.int(Math.max( MIN_SEGMENTSH, segmentsH)); // Defaults to 6
		if (radius==null) radius = DEFAULT_RADIUS; // Defaults to 100
		if (height==null) height = DEFAULT_HEIGHT; // Defaults to 100
		if (topRadius==null) topRadius = radius;

		var scale :Float = DEFAULT_SCALE;

		buildCylinder( radius, height, topRadius );
	}

	private function buildCylinder( fRadius:Float, fHeight:Float,  fTopRadius:Float ):Void
	{

		var iHor:Int = Std.int(Math.max(3,this.segmentsW));
		var iVer:Int = Std.int(Math.max(2,this.segmentsH));
		var aVertice:Array<Vertex3D> = this.geometry.vertices;
		var aFace:Array<Face3D> = this.geometry.faces;
		var aVtc:Array<Dynamic> = new Array();
		for (j in 0...(iVer+1)) { // vertical
			var fRad1:Float = (j/iVer);
			var fZ:Float = fHeight*(j/(iVer+0))-fHeight/2;//-fRadius*Math.cos(fRad1*Math.PI);
			var fRds:Float = fTopRadius+(fRadius-fTopRadius)*(1-j/(iVer));//*Math.sin(fRad1*Math.PI);
			var aRow:Array<Dynamic> = new Array();
			var oVtx:Vertex3D;
			for (i in 0...iHor) { // horizontal
				var fRad2:Float = (2*i/iHor);
				var fX:Float = fRds*Math.sin(fRad2*Math.PI);
				var fY:Float = fRds*Math.cos(fRad2*Math.PI);
				//if (!((j==0||j==iVer)&&i>0)) { // top||bottom = 1 vertex
				oVtx = new Vertex3D(fY,fZ,fX);
				aVertice.push(oVtx);
				//}
				aRow.push(oVtx);
			}
			aVtc.push(aRow);
		}
		var iVerNum:Int = aVtc.length;

		var aP4uv:NumberUV, aP1uv:NumberUV, aP2uv:NumberUV, aP3uv:NumberUV;
		var aP1:Vertex3D, aP2:Vertex3D, aP3:Vertex3D, aP4:Vertex3D;

		for (j in 0...iVerNum) {
			var iHorNum:Int = aVtc[j].length;
			for (i in 0...iHorNum) {
				if (j>0 && i>=0) {
					// select vertices
					var bEnd:Bool = (i==(iHorNum-0));
					aP1 = aVtc[j][if(bEnd) 0 else i];
					var k:Int=if(i==0) iHorNum else i;
					aP2 = aVtc[j][k-1];
					aP3 = aVtc[j-1][k-1];
					aP4 = aVtc[j-1][if(bEnd) 0 else i];
					// uv
					var fJ0:Float = j		/ iVerNum;
					var fJ1:Float = (j-1)	/ iVerNum;
					var fI0:Float = (i+1)	/ iHorNum;
					var fI1:Float = i		/ iHorNum;
					aP4uv = new NumberUV(fI0,fJ1);
					aP1uv = new NumberUV(fI0,fJ0);
					aP2uv = new NumberUV(fI1,fJ0);
					aP3uv = new NumberUV(fI1,fJ1);
					// 2 faces
					aFace.push( new Face3D([aP1,aP2,aP3], null, [aP1uv,aP2uv,aP3uv]) );
					aFace.push( new Face3D([aP1,aP3,aP4], null, [aP1uv,aP3uv,aP4uv]) );
				}
			}
			if (j==0 || j==(iVerNum-1)) {
				for (i in 0...(iHorNum-2)) {
					// uv
					var iI:Int = Math.floor(i/2);
					aP1 = aVtc[j][iI];
					aP2 = if(i%2==0) (aVtc[j][iHorNum-2-iI]) else (aVtc[j][iI+1]);
					aP3 = if(i%2==0) (aVtc[j][iHorNum-1-iI]) else (aVtc[j][iHorNum-2-iI]);

					var bTop:Bool = (j==0);
					var top1:Int=if(bTop) 1 else 0;
					var top2:Int=if(bTop) -1 else 1;
					aP1uv = new NumberUV( top1+top2*(aP1.x/fRadius/2+.5), aP1.z/fRadius/2+.5 );
					aP2uv = new NumberUV( top1+top2*(aP2.x/fRadius/2+.5), aP2.z/fRadius/2+.5 );
					aP3uv = new NumberUV( top1+top2*(aP3.x/fRadius/2+.5), aP3.z/fRadius/2+.5 );

					// face
					if (j==0)	aFace.push( new Face3D([aP1,aP3,aP2], null, [aP1uv,aP3uv,aP2uv]) );
					else		aFace.push( new Face3D([aP1,aP2,aP3], null, [aP1uv,aP2uv,aP3uv]) );
				}
			}
		}
		this.geometry.ready = true;
	}
}