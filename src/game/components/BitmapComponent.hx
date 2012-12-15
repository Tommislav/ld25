package game.components;
import game.utils.TileData;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class BitmapComponent implements IComponent
{
	public var holder:Sprite;
	public var bitmap:Bitmap;
	public var bitmapData:BitmapData;
	public var frameNumber:Int;
	
	public function new() 
	{
		
	}
	
	public function remove() {
		if (holder.parent != null)
			holder.parent.removeChild(holder);
	}
	
	public static function build(td:TileData, frameNumber = 0) {
		var c = new BitmapComponent();
		c.holder = new Sprite();
		c.bitmap = td.getBitmap();
		c.bitmapData = c.bitmap.bitmapData;
		c.frameNumber = frameNumber;
		
		c.bitmap.x = -c.bitmapData.width >> 1;
		c.bitmap.y = -c.bitmapData.height >> 1;
		c.holder.addChild(c.bitmap);
		return c;
	}
}