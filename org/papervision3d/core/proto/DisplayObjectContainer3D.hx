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

// _______________________________________________________________________ DisplayObjectContainer3D

package org.papervision3d.core.proto ;

import org.papervision3d.Papervision3D;
import org.papervision3d.objects.DisplayObject3D;

import flash.events.EventDispatcher;

/**
* The DisplayObjectContainer3D class is the base class for all objects that can serve as DisplayObject3D containers.
* <p/>
* Each DisplayObjectContainer3D object has its own child list.
*/
class DisplayObjectContainer3D extends EventDispatcher
{
	/**
	* Returns the number of children of this object.
	*/	
	public var numChildren(get_numChildren,null):Int;

	private function get_numChildren():Int
	{
		return this._childrenTotal;
	}

	// ___________________________________________________________________ N E W

	// NN  NN EEEEEE WW    WW
	// NNN NN EE     WW WW WW
	// NNNNNN EEEE   WWWWWWWW
	// NN NNN EE     WWW  WWW
	// NN  NN EEEEEE WW    WW

	/**
	* Creates a new DisplayObjectContainer3D object.
	*/
    public function new()
	{
		super();
		this._children       = new Array(  );
		this._childrenByName = new Array(  );
		this._childrenTotal  = 0;
	}


	// ___________________________________________________________________ C H I L D R E N

	/**
	* Adds a child DisplayObject3D instance to this DisplayObjectContainer instance.
	*
	* [TODO: If you add a child object that already has a different display object container as a parent, the object is removed from the child list of the other display object container.]
	*
	* @param	child	The DisplayObject3D instance to add as a child of this DisplayObjectContainer3D instance.
	* @param	name	An optional name of the child to add or create. If no name is provided, the child name will be used.
	* @return	The DisplayObject3D instance that you have added or created.
	*/
	public function addChild( child :DisplayObject3D, ?name:String ):DisplayObject3D
	{
		// Choose name
		if(name==null){
			   if(child.name==null)
			   {
				   //FIXME
				   name=Std.string( child.id );
			   }else 
			   {
				   name=child.name;
			   }
			   
		}
		//name = if(name==null) ( child.name || Std.string( child.id )) else name;

		this._children.push(child);
		this._childrenByName.push(name);
		this._childrenTotal++;

		return child;
	}


	/**
	* Removes the specified child DisplayObject3D instance from the child list of the DisplayObjectContainer3D instance.
	* </p>
	* [TODO: The parent property of the removed child is set to null, and the object is garbage collected if no other references to the child exist.]
	* </p>
	* The garbage collector is the process by which Flash Player reallocates unused memory space. When a variable or object is no longer actively referenced or stored somewhere, the garbage collector sweeps through and wipes out the memory space it used to occupy if no other references to it exist.
	* </p>
	* @param	child	The DisplayObject3D instance to remove.
	* @return	The DisplayObject3D instance that you pass in the child parameter.
	*/
	public function removeChild( child:DisplayObject3D ):DisplayObject3D
	{
		for(i in 0..._children.length)
		{
			if(child==_children[i])
			{
				child=null;
				_children.splice(i,1);
				_childrenByName.splice(i,1);
				_childrenTotal--;
				return child;
			}
		}

		return null;
	}


	/**
	* Returns the child display object that exists with the specified name.
	* </p>
	* If more that one child display object has the specified name, the method returns the first object in the child list.
	* </p>
	* @param	name	The name of the child to return.
	* @return	The child display object with the specified name.
	*/
	public function getChildByName( name:String ):DisplayObject3D
	{
		for(i in 0..._childrenByName.length)
		{
			if(name==_childrenByName[i])
			{
				return _children[i];
			}
		}

		return null;
	}


	/**
	* Removes the child DisplayObject3D instance that exists with the specified name, from the child list of the DisplayObjectContainer3D instance.
	* </p>
	* If more that one child display object has the specified name, the method removes the first object in the child list.
	* </p>
	* [TODO: The parent property of the removed child is set to null, and the object is garbage collected if no other references to the child exist.]
	* </p>
	* The garbage collector is the process by which Flash Player reallocates unused memory space. When a variable or object is no longer actively referenced or stored somewhere, the garbage collector sweeps through and wipes out the memory space it used to occupy if no other references to it exist.
	* </p>
	* @param	name	The name of the child to remove.
	* @return	The DisplayObject3D instance that was removed.
	*/
	public function removeChildByName( name:String ):DisplayObject3D
	{
		return removeChild( getChildByName( name ) );
	}

	// ___________________________________________________________________ D E B U G

	/**
	* Returns a string value with the list of objects.
	*
	* @return	A string.
	*/
	/**When we contain this toString() function,
	* Flash Player will throw a Error :
	* "VerifyError: Error #1053: 在 DisplayObjectContainer3D 中非法覆盖 DisplayObjectContainer3D。
	* at global$init()" .I don`t know how to fix it. Maybe this is a haxe bug.
	* @return
	*/
	//public  function toString():String
	//{
	//	return childrenList();
	//}


	/**
	* Returns a string value with the list of objects.
	*
	* @return	A string.
	*/
	public function childrenList():String
	{
		var list:String = "";

		for( i in 0...this._childrenByName.length )
			list += _childrenByName[i] + "\n";

		return list;
	}


	// ___________________________________________________________________ P R O T E C T E D
    //FIXME
	/**
	* [internal-use] Names indexed by children.
	*/
	private var _children       :Array<DisplayObject3D>;

	/**
	* [internal-use] Children indexed by name.
	*/
	private var _childrenByName :Array<String>;


	// ___________________________________________________________________ P R I V A T E

	private   var _childrenTotal  :Int;
}