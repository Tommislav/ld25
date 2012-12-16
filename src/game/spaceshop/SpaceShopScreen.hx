package game.spaceshop;
import game.components.GameComponent;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;

/**
 * ...
 * @author Tommislav
 */

class SpaceShopScreen extends Sprite
{
	private var _moneyText:ShopTextField;
	private var _moneyInstructions:ShopTextField;
	private var _shopItems:Array<SelectItem>;
	private var _gameComp:GameComponent;
	
	public function new() 
	{
		super();
		var bmp = new Bitmap(Assets.getBitmapData("img/shopScreen.png"));
		addChild(bmp);
		
		_moneyText = new ShopTextField();
		_moneyText.setSize(24);
		_moneyText.x = 130;
		_moneyText.y = 398;
		addChild(_moneyText);
		
		_moneyInstructions = new ShopTextField();
		_moneyInstructions.x = 130;
		_moneyInstructions.y = 376;
		addChild(_moneyInstructions);
		
		var itemY = [
			44.0,
			115.0,
			184.0,
			252.0,
			323.0,
			394.0
		];
		
		_shopItems = new Array<SelectItem>();
		
		for (i in 0...6) {
			var item = new SelectItem(i);
			item.x = 429;
			item.y = itemY[i];
			addChild(item);
			
			_shopItems.push(item);
		}
	}
	
	public function openShop(gameComp:GameComponent) {
		_gameComp = gameComp;
		
		if (gameComp.money == 0) {
			_moneyText.text = "";
			_moneyInstructions.text = "You have no money!\nKidnap cats for easy cash!\nJust make sure to catch them\nalive!";
		} else {
			_moneyText.text = "$" + gameComp.money;
			_moneyInstructions.text = "";
		}
		
		for (i in 0..._shopItems.length) {
			_shopItems[i].enter();
			_shopItems[i].addEventListener(ShopEvent.BUY_ITEM, onBuyItem);
		}
		
		updateAvailableItems();
	}
	
	public function exitShop() {
		for (i in 0..._shopItems.length) {
			_shopItems[i].exit();
			_shopItems[i].removeEventListener(ShopEvent.BUY_ITEM, onBuyItem);
		}
		dispatchEvent(new ShopEvent(ShopEvent.EXIT_SHOP));
	}
	
	private function onBuyItem(e:ShopEvent) {
		if (e.shopItem == 5) {
			exitShop();
		}
	}
	
	private function updateAvailableItems() {
		for (i in 0..._shopItems.length) {
			var cost = _shopItems[i].getCost();
			_shopItems[i].setSelectable(_gameComp.money >= cost);
		}
	}
	
}