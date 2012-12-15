package game.utils;
import nme.display.BitmapData;
import nme.geom.Rectangle;

/**
 * Map a tile to a id
 * @author Tommislav
 */

class TileMap 
{
	
	private var _mappedTiles:Array<TileData>;
	
	
	
	public function new() { _mappedTiles = new Array<TileData>(); }
	
	public function mapTile(id:Int, sheet:BitmapData, rect:Rectangle) {
		var td:TileData = new TileData(sheet, rect);
		_mappedTiles[id] = td;
	}
	
	public function getTile(id:Int) {
		return _mappedTiles[id];
	}
}