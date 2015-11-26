package org.papervision3d.core ;
class BoundingBox 
{
	public var max:Number3D;
	public var min:Number3D;
	public var size:Number3D;
	public function new(?min:Number3D,?max:Number3D)
	{
		this.min=if(min==null) new Number3D() else min;
		this.max=if(max==null) new Number3D() else max;
		this.size=new Number3D();
		this.size.x = this.max.x - this.min.x;
		this.size.y = this.max.y - this.min.y;
		this.size.z = this.max.z - this.min.z;
	}
}