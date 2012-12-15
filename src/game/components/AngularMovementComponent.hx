package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class AngularMovementComponent implements IComponent
{

	public var angle:Float;
	public var radians:Float;
	public var speed:Float;
	
	public function new() 
	{
		angle = 0;
		speed = 0;
	}
	
	public function setRadians(rad:Float) {
		this.radians = rad;
		this.angle = rad / Math.PI * 180;
	}
	
	public function setDegrees(deg:Float) {
		this.angle = deg;
		this.radians = deg / 180 * Math.PI;
	}
	
	public static function build(angleInDeg:Float, speed:Float) {
		var c:AngularMovementComponent = new AngularMovementComponent();
		c.setDegrees(angleInDeg);
		c.speed = speed;
		return c;
	}
}