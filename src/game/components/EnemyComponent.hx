package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class EnemyComponent implements IComponent
{
	public var type:String;
	public var counter:Int;
	
	public function new() { 
		type = "";
		counter = 0;
	}
	
	public static function build(enemyType:String) {
		var c = new EnemyComponent();
		c.type = enemyType;
		return c;
	}
}