package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * Simple hitTest with boxes
	 * @author Shiu
	 */
	[SWF(width = 400, height = 300)]
	public class Simple extends Sprite
	{
		private var box1:Box, box2:Box;
		
		public function Simple() {
			box1 = new Box(0x0000FF); addChild(box1); 
			box1.x = 250; box1.y = 250;
			box1.addEventListener(MouseEvent.MOUSE_DOWN, start);
			box1.addEventListener(MouseEvent.MOUSE_UP, end);
			
			box2 = new Box(0x00FF00); addChild(box2);
			box2.x = 100; box2.y = 50;
		}
		private function start(e:MouseEvent):void {
			e.target.startDrag();
			e.target.addEventListener(MouseEvent.MOUSE_MOVE, check);
		}
		private function end(e:MouseEvent):void {
			e.target.stopDrag();
			e.target.removeEventListener(MouseEvent.MOUSE_MOVE, check);
		}
		private function check(e:MouseEvent):void {
			if (e.target.hitTestObject(box2)) box2.color = 0x00AA00;
			else	box2.color = 0x00FF00;
		}
	}
}