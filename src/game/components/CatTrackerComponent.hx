package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class CatTrackerComponent implements IComponent
{
	public var catToTrack:Int;
	
	public function new() {}
	
	public static function build(trackCatInstance:Int) {
		var c = new CatTrackerComponent();
		c.catToTrack = trackCatInstance;
		return c;
	}
}