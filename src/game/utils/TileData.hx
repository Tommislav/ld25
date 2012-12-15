package game.utils;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author Tommislav
 */

class TileData 
{
	public var sheet:BitmapData;
	public var rect:Rectangle;
	
	
	public function new(sheet, rect) 
	{
		this.sheet = sheet;
		this.rect = rect;
	}
	
	public function drawTileTo(source:BitmapData, dest:Point) {
		source.copyPixels(sheet, rect, dest);
	}
	
	public function getBitmap() {
		var newBd:BitmapData = new BitmapData(Std.int(rect.width), Std.int(rect.height));
		drawTileTo(newBd, new Point(0,0));
		return new Bitmap(newBd);
	}
}