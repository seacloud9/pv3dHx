package org.papervision3d.core.utils;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.Lib;
class FPSCounter extends Sprite
{
		private var display:TextField;
		private var last:Float ;
		private var current:Float;
		private var fps:Float;
		
		public function new()
		{
			super();
			last=0;
			display = new TextField();
			display.width = 120;
			display.height = 20;
			display.background = true;
			display.backgroundColor = 0xFF0000;
			addEventListener(Event.ENTER_FRAME, update);
			addChild(display);
		}
		
		public function update(event:Event):Void
		{
			current = Lib.getTimer();
			fps = current - last;
			last = current;
			display.text = "每帧所用时间 : " + fps + " ms";
		}
}