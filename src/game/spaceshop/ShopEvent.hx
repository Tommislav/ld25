package game.spaceshop;
import nme.events.Event;

/**
 * ...
 * @author Tommislav
 */

class ShopEvent extends Event
{
	inline public static var EXIT_SHOP:String = "ShopEvent.EXIT_SHOP";
	inline public static var BUY_ITEM:String = "ShopEvent.BUY_ITEM";
	
	
	public var shopItem:Int;
	
	public function new(type:String, shopItem:Int=-1) 
	{
		super(type);
		this.shopItem = shopItem;
	}
	
}