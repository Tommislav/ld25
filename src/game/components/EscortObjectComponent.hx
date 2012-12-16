package game.components;
import se.salomonsson.ent.IComponent;

/**
 * If an entity has this component it will 
 * @author Tommislav
 */

class EscortObjectComponent implements IComponent
{
	public var escortingEntity:Int;
	public var offX:Float;
	public var offY:Float;
	public var isEscorting:Bool;
	
	public function new() {}
	
	public static function build(escortEntity:Int, offX:Float, offY:Float) {
		var c = new EscortObjectComponent();
		c.escortingEntity = escortEntity;
		c.offX = offX;
		c.offY = offY;
		c.isEscorting = true;
		return c;
	}
}