package game.systems;
import game.components.CenterPointPositionComponent;
import game.components.GameComponent;
import game.components.PlayerComponent;
import game.components.ShopComponent;
import game.spaceshop.ShopEvent;
import game.spaceshop.SpaceShopScreen;
import nme.events.MouseEvent;
import nme.Lib;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class UpdateSpaceShopSystem extends Sys
{
	private var _shoppingScreen:SpaceShopScreen;
	private var _alreadyBeenHit:Bool;
	
	public function new() 
	{
		super();
		_shoppingScreen = new SpaceShopScreen();
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var shopList = em().getEWC([ShopComponent]);
		if (shopList.length > 0) {
			var shop = shopList[0];
			var pos = shop.comp(CenterPointPositionComponent);
			var camera = em().getComp(CameraComponent);
			if (camera.inView(pos)) {
				// check for player collision
				
				var player = em().getEWC([PlayerComponent])[0];
				var playerPos = player.comp(CenterPointPositionComponent);
				var wantsToEnterShop = pos.intersects(playerPos);
				
				if (wantsToEnterShop && !_alreadyBeenHit) {
					_alreadyBeenHit = true;
					// ## LAUNCH SHOP!! ##
					
					Lib.current.stage.addChild(_shoppingScreen);
					_shoppingScreen.openShop(em().getComp(GameComponent));
					_shoppingScreen.addEventListener(ShopEvent.EXIT_SHOP, onExitShoppingScreen);
					getManager().pause();
					
					var levelBounds = em().getComp(GameComponent).levelBounds;
					//pos.x = (Math.random() * levelBounds.width - 256) + 128;
					//pos.y = (Math.random() * levelBounds.height - 256) + 128;
				}
				if (!wantsToEnterShop)
					_alreadyBeenHit = false;
			}
		}
	}
	
	private function onExitShoppingScreen(e:ShopEvent):Void 
	{
		_shoppingScreen.removeEventListener(ShopEvent.EXIT_SHOP, onExitShoppingScreen);
		
		if (_shoppingScreen.parent != null) {
			_shoppingScreen.parent.removeChild(_shoppingScreen);
		}
		
		getManager().resume();
	}
	
}