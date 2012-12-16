package game.spaceshop;
import game.components.DamagebleComponent;
import game.components.GameComponent;
import game.components.GunComponent;
import game.utils.Gun;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;

/**
 * ...
 * @author Tommislav
 */

class SpaceShopScreen extends Sprite
{
	private var _hintHasBeenDisplayed:Bool;
	
	private var _moneyText:ShopTextField;
	private var _moneyInstructions:ShopTextField;
	private var _shopItems:Array<SelectItem>;
	private var _gameComp:GameComponent;
	private var _healthComp:DamagebleComponent;
	private var _gunComponent:GunComponent;
	
	
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
	
	public function openShop(gameComp:GameComponent, playerHealthComponent:DamagebleComponent, playerGunComponent:GunComponent) {
		_gameComp = gameComp;
		_healthComp = playerHealthComponent;
		_gunComponent = playerGunComponent;
		
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
			return;
		}
		
		if (e.shopItem == 0) {
			_healthComp.health += 1;
		}
		
		if (e.shopItem == 1) {
			_gameComp.catRadarEnabled = true;
			_shopItems[e.shopItem].outOfStock();
		}
		
		if (e.shopItem == 2) {
			// add TailGun
			_gunComponent.addGun(Gun.build(Math.PI, 36, Math.PI, 50, ""));
			_shopItems[e.shopItem].outOfStock();
		}
		
		if (e.shopItem == 3) {
			// flank guns
			_gunComponent.addGun(Gun.build(Math.PI/2, 36, Math.PI/2, 50, ""));
			_gunComponent.addGun(Gun.build(Math.PI * 1.5, 36, Math.PI * 1.5, 50, ""));
			_shopItems[e.shopItem].outOfStock();
		}
		
		if (e.shopItem == 4) {
			// shoot faster
			for (gun in _gunComponent.allGuns) {
				if (gun.reloadDuration > 20) {
					gun.reloadDuration -= 5;
				}
			}
		}
		
		_gameComp.money -= _shopItems[e.shopItem].getCost();
		updateAvailableItems();
	}
	
	private function updateAvailableItems() {
		for (i in 0..._shopItems.length) {
			var cost = _shopItems[i].getCost();
			_shopItems[i].setSelectable((_gameComp.money >= cost));
		}
		
		if (_gameComp.money == 0 && !_hintHasBeenDisplayed) {
			_moneyText.text = "";
			_moneyInstructions.text = "You have no money!\nKidnap cats for easy cash!\nJust make sure to catch them\nalive!";
		} else {
			_hintHasBeenDisplayed = true;
			_moneyText.text = "$" + _gameComp.money;
			_moneyInstructions.text = "";
		}
	}
	
}