package game.spaceshop;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;

/**
 * ...
 * @author Tommislav
 */

class SelectItem extends Sprite
{		
	private var _index:Int;
	private var _labels:Array<String>;
	private var _cost:Array<Int>;
	private var _tf:ShopTextField;
	
	private var _inStock:Bool;
	
	private var _hand:Bitmap;
	
	public function new(index:Int) 
	{
		super();
		
		_index = index;
		_inStock = true;
		
		this.graphics.beginFill(0x000000, 1);
		this.graphics.drawRect(0, 0, 166, 46);
		this.graphics.endFill();
		
		_cost = [
			100,
			100,
			100,
			100,
			100,
			0
		];
		
		_labels = [
			"HEALTH ",
			"CAT RADAR ",
			"TAIL CANNON\n",
			"FLANK CANNONS\n",
			"SHOOT FASTER\n",
			"EXIT SHOP "
		];
		
		_tf = new ShopTextField();
		_tf.x = 4;
		_tf.y = 3;
		_tf.text = _labels[_index];
		
		if (_index < 5)
			_tf.text += "($ " + _cost[_index] + ")";
		
		addChild(_tf);
		
		_hand = new Bitmap(Assets.getBitmapData("img/shop_select.png"));
		_hand.x = -45;
		_hand.y = 4;
		_hand.visible = false;
		addChild(_hand);
	}
	
	public function enter() {
		if (_inStock == true) {
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(MouseEvent.CLICK, onSelect);
			this.useHandCursor = true;
		}
	}
	
	public function exit() {
		removeEventListener(MouseEvent.MOUSE_OVER, onOver);
		removeEventListener(MouseEvent.MOUSE_OUT, onOut);
		removeEventListener(MouseEvent.CLICK, onSelect);
		this.useHandCursor = false;
	}
	
	public function outOfStock() {
		setSelectable(false);
		_tf.setIsAvaliable(false);
		_inStock = false;
	}
	
	
	
	public function setSelectable(val:Bool) {
		if (_inStock) {
			exit();
			
			if (val)
				enter();
			
			_tf.setIsAvaliable(val);
		}
	}
	
	
	public function getCost() {
		return _cost[_index];
	}
	
	
	
	
	
	private function onOver(e:MouseEvent):Void 
	{
		_hand.visible = true;
	}
	
	private function onOut(e:MouseEvent):Void 
	{
		_hand.visible = false;
	}
	
	private function onSelect(e:MouseEvent):Void 
	{
		onOut(null);
		dispatchEvent(new ShopEvent(ShopEvent.BUY_ITEM, _index));
	}
}