package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * Simple collision between 2 circles
	 * @author Shiu	
	 */
	[SWF(width = 400, height = 300)]
	public class Simple3 extends Sprite
	{
		private var circle1:Circle, circle2:Circle;
		private var minDist:Number;
		
		public function Simple3() {
			circle1 = new Circle(0x0055AA, 30); addChild(circle1);
			circle1.x = 250; circle1.y = 250;
			circle1.addEventListener(MouseEvent.MOUSE_DOWN, start);
			circle1.addEventListener(MouseEvent.MOUSE_UP, end);
			
			circle2 = new Circle(0x00FF00, 30); addChild(circle2);
			circle2.x = 100; circle2.y = 50;
			
			minDist = circle1.radius + circle2.radius;
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
			var distance:Number = Math2.Pythagoras(circle1.x, circle1.y, circle2.x, circle2.y);
			if (distance <= minDist) circle2.color = 0x00FFAA;
			else circle2.color = 0x00FF00;
		}
	}

}