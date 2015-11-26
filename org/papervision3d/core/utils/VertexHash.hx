package org.papervision3d.core.utils ;

import flash.utils.Dictionary;
import org.papervision3d.core.geom.Vertex3D;
//FIXME
class VertexHash<T> {
	static var h:Map<String, Dynamic>;
	/**
		Creates a new empty hashtable.
	**/
	public function new() : Void {
		h = new Map();
	}

	/**
		Set a value for the given key.
	**/
	public function set( key : Vertex3D, value : T ) : Void {
		untyped h[key.toString()] = value;
		//trace("untyped h[key] ="+untyped h[key.toString()]);
	}

	/**
		Get a value for the given key.
	**/
	public function get( key : Vertex3D ) : Null<T> {
		return untyped h[key.toString()];
	}

	/**
		Tells if a value exists for the given key.
		In particular, it's useful to tells if a key has
		a [null] value versus no value.
	**/
	public function exists( key : Vertex3D ) : Bool {
		return untyped h.hasOwnProperty(key);
	}

	/**
		Removes a hashtable entry. Returns [true] if
		there was such entry.
	**/
	public function remove( key : Vertex3D ) : Bool {
		if( untyped !h.hasOwnProperty(key) ) return false;
		return true;
	}

	/**
		Returns an iterator of all keys in the hashtable.
	**/
	public function keys() : Iterator<Vertex3D> {
		return untyped (__keys__(h)).iterator();
	}

	/**
		Returns an iterator of all values in the hashtable.
	**/
	public function iterator() : Iterator<T> {
		return untyped {
			ref : h,
			it : keys(),
			hasNext : function() { return this.it.hasNext(); },
			next : function() { var i = this.it.next(); return this.ref[i]; }
		};
	}

	/**
		Returns an displayable representation of the hashtable content.
	**/

	public function toString():String {
		var s = new StringBuf();
		s.add("{");
		var it = keys();
		for( i in it ) {
			s.add(i);
			s.add(" => ");
			s.add(Std.string(get(i)));
			if( it.hasNext() )
				s.add(", ");
		}
		s.add("}");
		return s.toString();
	}

	//private var h : Dynamic;

}
