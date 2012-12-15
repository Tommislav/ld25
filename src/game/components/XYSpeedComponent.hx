package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class XYSpeedComponent implements IComponent
{
	public var xSpeed:Float;
	public var ySpeed:Float;
	
	
	public function new() 
	{
		xSpeed = 0;
		ySpeed = 0;
	}
	
	public static function build(xSpeed:Float, ySpeed:Float):XYSpeedComponent {
		var c:XYSpeedComponent = new XYSpeedComponent();
		c.xSpeed = xSpeed;
		c.ySpeed = ySpeed;
		return c;
	}
	
}