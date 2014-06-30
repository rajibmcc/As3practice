package  
{
	import fl.controls.Button;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * Collision with line segment
	 * @author Shiu
	 */
	[SWF(width = 400, height = 300)]
	public class LineCircle2 extends Sprite
	{
		private var x1:Number, y1:Number;	//coordinate1, c1
		private var x2:Number, y2:Number;	//coordinate2, c2
		private var line:Vector2D;					//line vector from c1 to c2
		private var leftNormal:Vector2D;		//normal of line
		
		private var circles:Vector.<Circle>;		//array to contain all circles
		private var velos:Vector.<Vector2D>;	//array to contain velocity corresponding to circle
		private var v_line_onX:Vector2D;
		private var b:Button;
		
		public function LineCircle2() {
			//declaring coordinates
			x1 = 50; y1 = 100;			
			x2 = 250; y2 = 150;
			
			//drawing line
			graphics.lineStyle(3);		
			graphics.moveTo(x1, y1); graphics.lineTo(x2, y2)
			
			//forming line vectors
			line = new Vector2D(x2 - x1, y2 - y1);
			leftNormal = line.rotate(Math.PI * -0.5);
			
			//Att2: getting the horizontal vector
			var line_onX:Number = line.projectionOn(new Vector2D(1, 0));
			v_line_onX = new Vector2D(1, 0);
			v_line_onX.setMagnitude(line_onX);
			
			//instantiate arrays
			circles = new Vector.<Circle>;
			velos = new Vector.<Vector2D>;
			for (var i:int = 0; i < 20; i++) {
				//create circles and add to array
				var circle:Circle = new Circle(0x0055AA); 
				addChild(circle); circle.x = i * 20;
				circles.push(circle);				
				//create velocities and add to array
				velos.push(new Vector2D(0, 1));
			}
			//refresh upon each frame
			stage.addEventListener(Event.ENTER_FRAME, refresh);
			b = new Button(); addChild(b); b.x = 10; b.y = 250; b.label="Restart"
			b.addEventListener(MouseEvent.MOUSE_DOWN, restart);
		}
		
		private function refresh(e:Event):void {
			for (var i:int = 0; i < circles.length; i++) {
				
				//calculating line's perpendicular distance to ball
				var c1_circle:Vector2D = new Vector2D(circles[i].x - x1, circles[i].y - y1);
				var c1_circle_onNormal:Number = c1_circle.projectionOn(leftNormal);
				
				//Att2: get vector from c2 to circle
				var c2_circle:Vector2D = new Vector2D(circles[i].x - x2, circles[i].y - y2);
				
				circles[i].y += 2;
				
				//if collision happened, undo movement
				if (Math.abs(c1_circle_onNormal) <= circles[i].radius
				
				//Att2: checking within segment
				&& v_line_onX.dotProduct(c1_circle) > 0
				&& v_line_onX.dotProduct(c2_circle) < 0
				
				){
					circles[i].y -= 2;
				}
			}
		}
		
		private function restart(e:MouseEvent):void {
			for (var i:int = 0; i < 20; i++) {
				circles[i].y = 0
			}
		}
		
	}

}