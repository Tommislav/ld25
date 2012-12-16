package ;

import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;

/**
 * ...
 * @author Tommislav
 */

class LD25 extends Sprite 
{
	
	public function new() 
	{
		super();
		init();
	}

	private function init() 
	{
		// entry point
		
		var splashScreen = new SplashScreen();
		addChild(splashScreen);
		splashScreen.addEventListener(MouseEvent.CLICK, showGameScreen);
	}
	
	private function showGameScreen(e:MouseEvent):Void 
	{
		e.currentTarget.removeEventListener(MouseEvent.CLICK, showGameScreen);
		var gameScreen = new GameScreen();
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new LD25());
	}
	
}
