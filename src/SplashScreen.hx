package ;
import com.eclecticdesignstudio.motion.Actuate;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;

/**
 * ...
 * @author Tommislav
 */

class SplashScreen extends Sprite
{

	public function new() 
	{
		super();
		var bmp = new Bitmap(Assets.getBitmapData("img/splashScreen.png"));
		addChild(bmp);
		this.alpha = 0;
		Actuate.tween(this, 2, { alpha:1 } );
		
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		Actuate.stop(this);
	}
	
}