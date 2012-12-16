package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class FaceDirectionComponent implements IComponent
{
	public var lastX:Float;
	public var lastY:Float;
	
	public function new() {
		lastX = -1001;
		lastY = -1001;
	}
	
}