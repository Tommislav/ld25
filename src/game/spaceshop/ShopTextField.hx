package game.spaceshop;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;

/**
 * ...
 * @author Tommislav
 */

class ShopTextField extends TextField
{

	private var _format:TextFormat;
	
	public function new() 
	{
		super();
		_format = new TextFormat("arial", 16, 0xffffff, true);
		this.defaultTextFormat = _format;
		this.autoSize = TextFieldAutoSize.LEFT;
		this.selectable = false;
		this.mouseEnabled = false;
		this.textColor = 0xffffff;
		
	}
	
	public function setSize(size:Int) {
		_format.size = size;
		this.defaultTextFormat = _format;
	}
	
	public function setIsAvaliable(val:Bool) {
		this.alpha = (val) ? 1: 0.2;
	}
}