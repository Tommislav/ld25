package game.systems;
import game.components.PlayerComponent;
import game.components.PositionComponent;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class CameraTrackPlayerSystem extends Sys
{
	private var _player:EW;
	private var _camera:CameraComponent;
	
	
	public function new() 
	{
		super();
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_camera = em.getComp(CameraComponent);
		_player = em.getEWC([PlayerComponent])[0];
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var pos = _player.comp(PositionComponent);
		_camera.x = pos.x - (_camera.width >> 1);
		_camera.y = pos.y - (_camera.height >> 1);
	}
	
}