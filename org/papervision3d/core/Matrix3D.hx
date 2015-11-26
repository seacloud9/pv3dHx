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

// ______________________________________________________________________ Matrix3D

package org.papervision3d.core;

import org.papervision3d.core.Number3D;

/**
* The Matrix3D class lets you create and manipulate 4x3 3D transformation matrices.
*/
class Matrix3D
{
	public var n11 :Float;		public var n12 :Float;		public var n13 :Float;		public var n14 :Float;
	public var n21 :Float;		public var n22 :Float;		public var n23 :Float;		public var n24 :Float;
	public var n31 :Float;		public var n32 :Float;		public var n33 :Float;		public var n34 :Float;

//	public var n41 :Float = 0;		public var n42 :Float = 0;		public var n43 :Float = 0;		public var n44 :Float = 1;
    static public var IDENTITY(get_IDENTITY,null):Matrix3D;
	public var det(get_det,null):Float;
	public function new( ?args :Array<Float> )
	{
		if(args!=null && args.length >= 12 )
		{
			n11 = args[0];  n12 = args[1];  n13 = args[2];  n14 = args[3];
			n21 = args[4];  n22 = args[5];  n23 = args[6];  n24 = args[7];
			n31 = args[8];  n32 = args[9];  n33 = args[10]; n34 = args[11];
		}
		else
		{
			n11 = n22 = n33 = 1;
			n12 = n13 = n14 = n21 = n23 = n24 = n31 = n32 = n34 = 0;
		}
	}


	private static function get_IDENTITY():Matrix3D
	{
		return new Matrix3D
		(
			[
				1., 0., 0., 0.,
				0., 1., 0., 0.,
				0., 0., 1., 0.
			]
		);
	}


	public function toString(): String
	{
		var s:String = "";

		s += Math.floor(n11*1000)/1000 + "\t\t" + Math.floor(n12*1000)/1000 + "\t\t" + Math.floor(n13*1000)/1000 + "\t\t" + Math.floor(n14*1000)/1000 +"\n";
		s += Math.floor(n21*1000)/1000 + "\t\t" + Math.floor(n22*1000)/1000 + "\t\t" + Math.floor(n23*1000)/1000 + "\t\t" + Math.floor(n24*1000)/1000 + "\n";
		s += Math.floor(n31*1000)/1000 + "\t\t" + Math.floor(n32*1000)/1000 + "\t\t" + Math.floor(n33*1000)/1000 + "\t\t" + Math.floor(n34*1000)/1000 + "\n";

		return s;
	}

/*
	public static function transposeMatrix( m:Matrix3D ):Void
	{
		var save:Float;

		save = m.n12; m.n12 = m.n21; m.n21 = save;
		save = m.n13; m.n13 = m.n31; m.n31 = save;
		save = m.n14; m.n14 = m.n41; m.n41 = save;

		save = m.n23; m.n23 = m.n32; m.n32 = save;
		save = m.n24; m.n24 = m.n42; m.n42 = save;

		save = m.n34; m.n34 = m.n43; m.n43 = save;
	}


	public static function transpose3x3Matrix( m:Matrix3D ):Void
	{
		var save:Float;

		save = m.n12; m.n12 = m.n21; m.n21 = save;
		save = m.n13; m.n13 = m.n31; m.n31 = save;
		save = m.n14; m.n14 = m.n41; m.n41 = save;

		save = m.n23; m.n23 = m.n32; m.n32 = save;
	}
*/


	public static function multiply3x3( m1:Matrix3D, m2:Matrix3D ):Matrix3D
	{
		var dest:Matrix3D = IDENTITY;
		var m111:Float = m1.n11; var m211:Float = m2.n11;
		var m121:Float = m1.n21; var m221:Float = m2.n21;
		var m131:Float = m1.n31; var m231:Float = m2.n31;
		var m112:Float = m1.n12; var m212:Float = m2.n12;
		var m122:Float = m1.n22; var m222:Float = m2.n22;
		var m132:Float = m1.n32; var m232:Float = m2.n32;
		var m113:Float = m1.n13; var m213:Float = m2.n13;
		var m123:Float = m1.n23; var m223:Float = m2.n23;
		var m133:Float = m1.n33; var m233:Float = m2.n33;

		dest.n11 = m111 * m211 + m112 * m221 + m113 * m231;
		dest.n12 = m111 * m212 + m112 * m222 + m113 * m232;
		dest.n13 = m111 * m213 + m112 * m223 + m113 * m233;

		dest.n21 = m121 * m211 + m122 * m221 + m123 * m231;
		dest.n22 = m121 * m212 + m122 * m222 + m123 * m232;
		dest.n23 = m121 * m213 + m122 * m223 + m123 * m233;

		dest.n31 = m131 * m211 + m132 * m221 + m133 * m231;
		dest.n32 = m131 * m212 + m132 * m222 + m133 * m232;
		dest.n33 = m131 * m213 + m132 * m223 + m133 * m233;

		dest.n14 = m1.n14;
		dest.n24 = m1.n24;
		dest.n34 = m1.n34;

		return dest;
	}

	public static function rotateAxis( m:Matrix3D, v:Number3D ):Void
	{
		var vx:Float, vy:Float, vz:Float;
		v.x = (vx=v.x) * m.n11 + (vy=v.y) * m.n12 + (vz=v.z) * m.n13;
		v.y = vx * m.n21 + vy * m.n22 + vz * m.n23;
		v.z = vx * m.n31 + vy * m.n32 + vz * m.n33;

		v.normalize();
	}

	public static function multiply( m1:Matrix3D, m2:Matrix3D ):Matrix3D
	{
		var dest:Matrix3D = IDENTITY;

		var m111:Float, m211:Float, m121:Float, m221:Float, m131:Float, m231:Float;
		var m112:Float, m212:Float, m122:Float, m222:Float, m132:Float, m232:Float;
		var m113:Float, m213:Float, m123:Float, m223:Float, m133:Float, m233:Float;
		var m114:Float, m214:Float, m124:Float, m224:Float, m134:Float, m234:Float;

		dest.n11 = (m111=m1.n11) * (m211=m2.n11) + (m112=m1.n12) * (m221=m2.n21) + (m113=m1.n13) * (m231=m2.n31);
		dest.n12 = m111 * (m212=m2.n12) + m112 * (m222=m2.n22) + m113 * (m232=m2.n32);
		dest.n13 = m111 * (m213=m2.n13) + m112 * (m223=m2.n23) + m113 * (m233=m2.n33);
		dest.n14 = m111 * (m214=m2.n14) + m112 * (m224=m2.n24) + m113 * (m234=m2.n34) + (m114=m1.n14);

		dest.n21 = (m121=m1.n21) * m211 + (m122=m1.n22) * m221 + (m123=m1.n23) * m231;
		dest.n22 = m121 * m212 + m122 * m222 + m123 * m232;
		dest.n23 = m121 * m213 + m122 * m223 + m123 * m233;
		dest.n24 = m121 * m214 + m122 * m224 + m123 * m234 + (m124=m1.n24);

		dest.n31 = (m131=m1.n31) * m211 + (m132=m1.n32) * m221 + (m133=m1.n33) * m231;
		dest.n32 = m131 * m212 + m132 * m222 + m133 * m232;
		dest.n33 = m131 * m213 + m132 * m223 + m133 * m233;
		dest.n34 = m131 * m214 + m132 * m224 + m133 * m234 + (m134=m1.n34);

		return dest;
	}

/*
	public static function multiply( m1:Matrix3D, m2:Matrix3D ):Matrix3D
	{
		var dest:Matrix3D = IDENTITY;

		var m111:Float, m211:Float, m121:Float, m221:Float, m131:Float, m231:Float, m141:Float, m241:Float;
		var m112:Float, m212:Float, m122:Float, m222:Float, m132:Float, m232:Float, m142:Float, m242:Float;
		var m113:Float, m213:Float, m123:Float, m223:Float, m133:Float, m233:Float, m143:Float, m243:Float;
		var m114:Float, m214:Float, m124:Float, m224:Float, m134:Float, m234:Float, m144:Float, m244:Float;

		m1.n44 = m2.n44 = 1;
		m1.n43 = m2.n43 = m1.n42 = m2.n42 = m1.n41 = m2.n41 = 0;

		dest.n11 = (m111=m1.n11) * (m211=m2.n11) + (m112=m1.n12) * (m221=m2.n21) + (m113=m1.n13) * (m231=m2.n31) + (m114=m1.n14) * (m241=m2.n41);
		dest.n12 = m111 * (m212=m2.n12) + m112 * (m222=m2.n22) + m113 * (m232=m2.n32) + m114 * (m242=m2.n42);
		dest.n13 = m111 * (m213=m2.n13) + m112 * (m223=m2.n23) + m113 * (m233=m2.n33) + m114 * (m243=m2.n43);
		dest.n14 = m111 * (m214=m2.n14) + m112 * (m224=m2.n24) + m113 * (m234=m2.n34) + m114 * (m244=m2.n44);

		dest.n21 = (m121=m1.n21) * m211 + (m122=m1.n22) * m221 + (m123=m1.n23) * m231 + (m124=m1.n24) * m241;
		dest.n22 = m121 * m212 + m122 * m222 + m123 * m232 + m124 * m242;
		dest.n23 = m121 * m213 + m122 * m223 + m123 * m233 + m124 * m243;
		dest.n24 = m121 * m214 + m122 * m224 + m123 * m234 + m124 * m244;

		dest.n31 = (m131=m1.n31) * m211 + (m132=m1.n32) * m221 + (m133=m1.n33) * m231 + (m134=m1.n34) * m241;
		dest.n32 = m131 * m212 + m132 * m222 + m133 * m232 + m134 * m242;
		dest.n33 = m131 * m213 + m132 * m223 + m133 * m233 + m134 * m243;
		dest.n34 = m131 * m214 + m132 * m224 + m133 * m234 + m134 * m244;

		dest.n41 = (m141=m1.n41) * m211 + (m142=m1.n42) * m221 + (m143=m1.n43) * m231 + (m144=m1.n44) * m241;
		dest.n42 = m141 * m212 + m142 * m222 + m143 * m232 + m144 * m242;
		dest.n43 = m141 * m213 + m142 * m223 + m143 * m233 + m144 * m243;
		dest.n44 = m141 * m214 + m142 * m224 + m143 * m234 + m144 * m244;

		return dest;
	}
*/

	public static function add( m1:Matrix3D, m2:Matrix3D ):Matrix3D
	{
		var dest : Matrix3D = IDENTITY;

		dest.n11 = m1.n11 + m2.n11; 	dest.n12 = m1.n12 + m2.n12;
		dest.n13 = m1.n13 + m2.n13;	dest.n14 = m1.n14 + m2.n14;

		dest.n21 = m1.n21 + m2.n21;	dest.n22 = m1.n22 + m2.n22;
		dest.n23 = m1.n23 + m2.n23;	dest.n24 = m1.n24 + m2.n24;

		dest.n31 = m1.n31 + m2.n31;	dest.n32 = m1.n32 + m2.n32;
		dest.n33 = m1.n33 + m2.n33;	dest.n34 = m1.n34 + m2.n34;

		return dest;
	}

	public function copy( m:Matrix3D ):Matrix3D
	{
		this.n11 = m.n11;	this.n12 = m.n12;
		this.n13 = m.n13;	this.n14 = m.n14;

		this.n21 = m.n21;	this.n22 = m.n22;
		this.n23 = m.n23;	this.n24 = m.n24;

		this.n31 = m.n31;	this.n32 = m.n32;
		this.n33 = m.n33;	this.n34 = m.n34;

		return this;
	}

	public function copy3x3( m:Matrix3D ):Matrix3D
	{
		this.n11 = m.n11;   this.n12 = m.n12;   this.n13 = m.n13;
		this.n21 = m.n21;   this.n22 = m.n22;   this.n23 = m.n23;
		this.n31 = m.n31;   this.n32 = m.n32;   this.n33 = m.n33;

		return this;
	}


	public static function clone(m:Matrix3D):Matrix3D
	{
		return new Matrix3D
		(
			[
				m.n11, m.n12, m.n13, m.n14,
				m.n21, m.n22, m.n23, m.n24,
				m.n31, m.n32, m.n33, m.n34
			]
		);
	}


	public static function multiplyVector( m:Matrix3D, v:Number3D ):Void
	{
		var vx:Float, vy:Float, vz:Float;
		v.x = (vx=v.x) * m.n11 + (vy=v.y) * m.n12 + (vz=v.z) * m.n13 + m.n14;
		v.y = vx * m.n21 + vy * m.n22 + vz * m.n23 + m.n24;
		v.z = vx * m.n31 + vy * m.n32 + vz * m.n33 + m.n34;
	}


	public static function multiplyVector3x3( m:Matrix3D, v:Number3D ):Void
	{
		var vx:Float, vy:Float, vz:Float;
		v.x = (vx=v.x) * m.n11 + (vy=v.y) * m.n12 + (vz=v.z) * m.n13;
		v.y = vx * m.n21 + vy * m.n22 + vz * m.n23;
		v.z = vx * m.n31 + vy * m.n32 + vz * m.n33;
	}

/*
	public static function projectVector( m:Matrix3D, v:Number3D ):Void
	{
		var c:Float = 1 / ( v.x * m.n41 + v.y * m.n42 + v.z * m.n43 + 1 );

		multiplyVector( m, v );

		v.x = v.x * c;
		v.y = v.y * c;
		v.z = 0;
	}
*/

	public static function matrix2euler( mat:Matrix3D ):Number3D
	{
		var angle:Number3D = new Number3D();

		var d :Float = -Math.asin( Math.max( -1, Math.min( 1, mat.n13 ) ) ); // Calculate Y-axis angle
		var c :Float =  Math.cos( d );

		angle.y = d * toDEGREES;

		var trX:Float, trY:Float;

		if( Math.abs( c ) > 0.005 )  // Gimball lock?
		{
			trX =  mat.n33 / c;  // No, so get X-axis angle
			trY = -mat.n23 / c;

			angle.x  = Math.atan2( trY, trX ) * toDEGREES;

			trX =  mat.n11 / c;  // Get Z-axis angle
			trY = -mat.n12 / c;

			angle.z  = Math.atan2( trY, trX ) * toDEGREES;
		}
		else  // Gimball lock has occurred
		{
			angle.x  = 0;  // Set X-axis angle to zero

			trX = mat.n22;  // And calculate Z-axis angle
			trY = mat.n21;

			angle.z = Math.atan2( trY, trX ) * toDEGREES;
		}
//		angle_x = clamp( angle_x, 0, 360 );  // Clamp all angles to range
//		angle_y = clamp( angle_y, 0, 360 );
//		angle_z = clamp( angle_z, 0, 360 );

		return angle;
	}


	public static function euler2matrix( angle:Number3D ):Matrix3D
	{
		var m:Matrix3D = IDENTITY;

		var ax:Float = angle.x * toRADIANS;
		var ay:Float = angle.y * toRADIANS;
		var az:Float = angle.z * toRADIANS;

		var a:Float = Math.cos( ax );
		var b:Float = Math.sin( ax );
		var c:Float = Math.cos( ay );
		var d:Float = Math.sin( ay );
		var e:Float = Math.cos( az );
		var f:Float = Math.sin( az );
		var ad:Float = a * d	;
		var bd:Float = b * d	;

		m.n11 =  c  * e;
		m.n12 = -c  * f;
		m.n13 =  d;
		m.n21 =  bd * e + a * f;
		m.n22 = -bd * f + a * e;
		m.n23 = -b  * c;
		m.n31 = -ad * e + b * f;
		m.n32 =  ad * f + b * e;
		m.n33 =  a  * c;

		return m;
	}

	public static function rotationX( angleRad:Float ):Matrix3D
	{
		var m :Matrix3D = IDENTITY;
		var c :Float   = Math.cos( angleRad );
		var s :Float   = Math.sin( angleRad );

		m.n22 =  c;
		m.n23 = -s;
		m.n32 =  s;
		m.n33 =  c;

		return m;
	}

	/**
	 *
	 * @param angle Float angle of rotation in degrees
	 * @return the computed matrix
	 */
	public static function rotationY( angleRad:Float ):Matrix3D
	{
		var m :Matrix3D = IDENTITY;
		var c :Float   = Math.cos( angleRad );
		var s :Float   = Math.sin( angleRad );

		m.n11 =  c;
		m.n13 = -s;
		m.n31 =  s;
		m.n33 =  c;

		return m;
	}

	/**
	 *
	 * @param angle Float angle of rotation in degrees
	 * @return the computed matrix
	 */
	public static function rotationZ( angleRad:Float ):Matrix3D
	{
		var m :Matrix3D = IDENTITY;
		var c :Float   = Math.cos( angleRad );
		var s :Float   = Math.sin( angleRad );

		m.n11 =  c;
		m.n12 = -s;
		m.n21 =  s;
		m.n22 =  c;

		return m;
	}


	public static function rotationMatrix( u:Float, v:Float, w:Float, angle:Float ):Matrix3D
	{
		var m:Matrix3D = IDENTITY;

		var nCos:Float	= Math.cos( angle );
		var nSin:Float	= Math.sin( angle );
		var scos:Float	= 1 - nCos;

		var suv	:Float = u * v * scos;
		var svw	:Float = v * w * scos;
		var suw	:Float = u * w * scos;
		var sw	:Float = nSin * w;
		var sv	:Float = nSin * v;
		var su	:Float = nSin * u;

		m.n11 =  nCos + u * u * scos;
		m.n12 = -sw   + suv;
		m.n13 =  sv   + suw;

		m.n21 =  sw   + suv;
		m.n22 =  nCos + v * v * scos;
		m.n23 = -su   + svw;

		m.n31 = -sv   + suw;
		m.n32 =  su   + svw;
		m.n33 =  nCos + w * w * scos;

		return m;
	}

	// _________________________________________________________________________________

	public static function translationMatrix( u:Float, v:Float, w:Float ):Matrix3D
	{
		var m:Matrix3D = IDENTITY;

		m.n14 = u;
		m.n24 = v;
		m.n34 = w;

		return m;
	}

	public static function scaleMatrix( u:Float, v:Float, w:Float ):Matrix3D
	{
		var m:Matrix3D = IDENTITY;

		m.n11 = u;
		m.n22 = v;
		m.n33 = w;

		return m;
	}


	public function get_det():Float
	{
		return	(this.n11 * this.n22 - this.n21 * this.n12) * this.n33 - (this.n11 * this.n32 - this.n31 * this.n12) * this.n23 +
				(this.n21 * this.n32 - this.n31 * this.n22) * this.n13; // + (this.n31 * this.n42) * (this.n13 * this.n24 - this.n23 * this.n14);
	}


	public static function getTrace( m:Matrix3D ):Float
	{
		return m.n11 + m.n22 + m.n33 + 1;
	}

/*
	public static function inverse( m:Matrix3D ):Matrix3D
	{
		var d:Float = det( m );
		if( Math.abs(d) < 0.001 )
		{
			// Determinant zero, there's no inverse
			return null;
		}

		d = 1/d;

		var m11:Float = m.n11; var m21:Float = m.n21; var m31:Float = m.n31; var m41:Float = m.n41;
		var m12:Float = m.n12; var m22:Float = m.n22; var m32:Float = m.n32; var m42:Float = m.n42;
		var m13:Float = m.n13; var m23:Float = m.n23; var m33:Float = m.n33; var m43:Float = m.n43;
		var m14:Float = m.n14; var m24:Float = m.n24; var m34:Float = m.n34; var m44:Float = m.n44;

		return new Matrix3D
		(
			[d * ( m22*(m33*m44 - m43*m34) - m32*(m23*m44 - m43*m24) + m42*(m23*m34 - m33*m24) ),
			-d* ( m12*(m33*m44 - m43*m34) - m32*(m13*m44 - m43*m14) + m42*(m13*m34 - m33*m14) ),
			d * ( m12*(m23*m44 - m43*m24) - m22*(m13*m44 - m43*m14) + m42*(m13*m24 - m23*m14) ),
			-d* ( m12*(m23*m34 - m33*m24) - m22*(m13*m34 - m33*m14) + m32*(m13*m24 - m23*m14) ),
			-d* ( m21*(m33*m44 - m43*m34) - m31*(m23*m44 - m43*m24) + m41*(m23*m34 - m33*m24) ),
			d * ( m11*(m33*m44 - m43*m34) - m31*(m13*m44 - m43*m14) + m41*(m13*m34 - m33*m14) ),
			-d* ( m11*(m23*m44 - m43*m24) - m21*(m13*m44 - m43*m14) + m41*(m13*m24 - m23*m14) ),
			d * ( m11*(m23*m34 - m33*m24) - m21*(m13*m34 - m33*m14) + m31*(m13*m24 - m23*m14) ),
			d * ( m21*(m32*m44 - m42*m34) - m31*(m22*m44 - m42*m24) + m41*(m22*m34 - m32*m24) ),
			-d* ( m11*(m32*m44 - m42*m34) - m31*(m12*m44 - m42*m14) + m41*(m12*m34 - m32*m14) ),
			d * ( m11*(m22*m44 - m42*m24) - m21*(m12*m44 - m42*m14) + m41*(m12*m24 - m22*m14) ),
			-d* ( m11*(m22*m34 - m32*m24) - m21*(m12*m34 - m32*m14) + m31*(m12*m24 - m22*m14) ),
			-d* ( m21*(m32*m43 - m42*m33) - m31*(m22*m43 - m42*m23) + m41*(m22*m33 - m32*m23) ),
			d * ( m11*(m32*m43 - m42*m33) - m31*(m12*m43 - m42*m13) + m41*(m12*m33 - m32*m13) ),
			-d* ( m11*(m22*m43 - m42*m23) - m21*(m12*m43 - m42*m13) + m41*(m12*m23 - m22*m13) ),
			d * ( m11*(m22*m33 - m32*m23) - m21*(m12*m33 - m32*m13) + m31*(m12*m23 - m22*m13) )]
		);
	}
*/

	public static function inverse( m:Matrix3D ):Matrix3D
	{
		var d:Float = m.det;
		if( Math.abs(d) < 0.001 )
		{
			// Determinant zero, there's no inverse
			return null;
		}

		d = 1/d;

		var m11:Float = m.n11; var m21:Float = m.n21; var m31:Float = m.n31;
		var m12:Float = m.n12; var m22:Float = m.n22; var m32:Float = m.n32;
		var m13:Float = m.n13; var m23:Float = m.n23; var m33:Float = m.n33;
		var m14:Float = m.n14; var m24:Float = m.n24; var m34:Float = m.n34;

		return new Matrix3D
		(
			[
				d * ( m22 * m33 - m32 * m23 ),
				-d* ( m12 * m33 - m32 * m13 ),
				d * ( m12 * m23 - m22 * m13 ),
				-d* ( m12 * (m23*m34 - m33*m24) - m22 * (m13*m34 - m33*m14) + m32 * (m13*m24 - m23*m14) ),
				-d* ( m21 * m33 - m31 * m23 ),
				d * ( m11 * m33 - m31 * m13 ),
				-d* ( m11 * m23 - m21 * m13 ),
				d * ( m11 * (m23*m34 - m33*m24) - m21 * (m13*m34 - m33*m14) + m31 * (m13*m24 - m23*m14) ),
				d * ( m21 * m32 - m31 * m22 ),
				-d* ( m11 * m32 - m31 * m12 ),
				d * ( m11 * m22 - m21 * m12 ),
				-d* ( m11 * (m22*m34 - m32*m24) - m21 * (m12*m34 - m32*m14) + m31 * (m12*m24 - m22*m14) )
			]
		);
	}


	public static function axisRotationWithReference( axis:Number3D, ref:Number3D, pAngle:Float ):Matrix3D
	{
		var angle :Float = ( pAngle + 360. ) % 360.;

		var m :Matrix3D = Matrix3D.translationMatrix( ref.x, -ref.y, ref.z );
		m = Matrix3D.multiply ( m, Matrix3D.rotationMatrix( axis.x, axis.y, axis.z, angle ) );
		m = Matrix3D.multiply ( m, Matrix3D.translationMatrix ( -ref.x, ref.y, -ref.z ) );

		return m;
	}

	// _________________________________________________________________________________ QUATERNIONS

	public static function quaternion2matrix( x:Float, y:Float, z:Float, w:Float ):Matrix3D
	{
		var xx:Float = x * x;
		var xy:Float = x * y;
		var xz:Float = x * z;
		var xw:Float = x * w;

		var yy:Float = y * y;
		var yz:Float = y * z;
		var yw:Float = y * w;

		var zz:Float = z * z;
		var zw:Float = z * w;

		var m:Matrix3D = IDENTITY;

		m.n11 = 1 - 2 * ( yy + zz );
		m.n12 =     2 * ( xy - zw );
		m.n13 =     2 * ( xz + yw );

		m.n21 =     2 * ( xy + zw );
		m.n22 = 1 - 2 * ( xx + zz );
		m.n23 =     2 * ( yz - xw );

		m.n31 =     2 * ( xz - yw );
		m.n32 =     2 * ( yz + xw );
		m.n33 = 1 - 2 * ( xx + yy );

		return m;
	}


	public static function euler2quaternion( ax:Float, ay:Float, az:Float ):Number4D
    {
		var fSinPitch       :Float = Math.sin( ax * 0.5 );
		var fCosPitch       :Float = Math.cos( ax * 0.5 );
		var fSinYaw         :Float = Math.sin( ay * 0.5 );
		var fCosYaw         :Float = Math.cos( ay * 0.5 );
		var fSinRoll        :Float = Math.sin( az * 0.5 );
		var fCosRoll        :Float = Math.cos( az * 0.5 );
		var fCosPitchCosYaw :Float = fCosPitch * fCosYaw;
		var fSinPitchSinYaw :Float = fSinPitch * fSinYaw;

		var q:Number4D=new Number4D();
		q.x = fSinRoll * fCosPitchCosYaw     - fCosRoll * fSinPitchSinYaw;
		q.y = fCosRoll * fSinPitch * fCosYaw + fSinRoll * fCosPitch * fSinYaw;
		q.z = fCosRoll * fCosPitch * fSinYaw - fSinRoll * fSinPitch * fCosYaw;
		q.w = fCosRoll * fCosPitchCosYaw     + fSinRoll * fSinPitchSinYaw;

		return q;
/*
		VECTOR3 vx = { 1, 0, 0 }, vy = { 0, 1, 0 }, vz = { 0, 0, 1 };
		QUATERNION qx, qy, qz, qt;

		var qx:Object = axis2quaternion(  &vx, rx );
		axis2quaternion( qy, &vy, ry );
		axis2quaternion( qz, &vz, rz );

		multiplyQuaternion( &qt, &qx, &qy );
		multiplyQuaternion( &q,  &qt, &qz );
*/
    }


	public static function multiplyQuaternion( qa:Number4D, qb:Number4D ):Number4D
    {
		/*
		qr.scalar = Number3D.cross( new Number3D( qa.x, qa.y, qa.z ), new Number3D( qb.x, qb.y, qb.z ) );
		v3_cross(  &va, &qa->vector, &qb->vector );
		v3_scalef( &vb, &qa->vector, &qb->scalar );
		v3_scalef( &vc, &qb->vector, &qa->scaler );
		v3_add(    &va,         &va, &vb );
		v3_add(    &qr->vector, &va, &vc );

		quaternion_normalise( qr );
		*/

		var w1:Float = qa.w;  var x1:Float = qa.x;  var y1:Float = qa.y;  var z1:Float = qa.z;
		var w2:Float = qa.w;  var x2:Float = qa.x;  var y2:Float = qa.y;  var z2:Float = qa.z;

		var q:Number4D=new Number4D();

		q.w = w1*w2 - x1*x2 - y1*y2 - z1*z2;
		q.x = w1*x2 + x1*w2 + y1*z2 - z1*y2;
		q.y = w1*y2 + y1*w2 + z1*x2 - x1*z2;
		q.z = w1*z2 + z1*w2 + x1*y2 - y1*x2;

		return q;
    }





	public static function axis2quaternion( x:Float, y:Float, z:Float, angle:Float ):Number4D
	{
		var sin_a:Float = Math.sin( angle / 2 );
		var cos_a:Float = Math.cos( angle / 2 );

		var q:Number4D=new Number4D();

		q.x = x * sin_a;
		q.y = y * sin_a;
		q.z = z * sin_a;
		q.w = cos_a;

		return normalizeQuaternion( q );
	}


	public static function magnitudeQuaternion( q:Number4D ):Float
    {
		return( Math.sqrt( q.w * q.w + q.x * q.x + q.y * q.y + q.z * q.z ) );
    }


	public static function normalizeQuaternion( q:Number4D):Number4D
	{
		var mag:Float = magnitudeQuaternion( q );

		q.x /= mag;
		q.y /= mag;
		q.z /= mag;
		q.w /= mag;

		return q;
	}

	// _________________________________________________________________________________ PRIVATE

	static private var toDEGREES :Float = 180./Math.PI;
	static private var toRADIANS :Float = Math.PI/180.;
}