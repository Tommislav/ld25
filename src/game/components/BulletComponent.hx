package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class BulletComponent implements IComponent
{
	public var immuneTypes:Array<Dynamic>;
	
	public function new() {
		immuneTypes = new Array<Dynamic>();
	}
	
	public static function build(immuneTypes:Array<Dynamic>=null) {
		var c = new BulletComponent();
		if (immuneTypes != null)
			c.immuneTypes = immuneTypes;
		
		return c;
	}
}