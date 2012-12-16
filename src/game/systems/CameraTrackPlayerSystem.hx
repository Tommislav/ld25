package game.systems;
import game.components.GameComponent;
import game.components.PlayerComponent;
import game.components.CenterPointPositionComponent;
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
		var pos = _player.comp(CenterPointPositionComponent);
		if (pos == null)
			return;
		
		_camera.x = pos.x - (_camera.width / 2);
		_camera.y = pos.y - (_camera.height / 2);
		
		// constrain bounds
		var bounds = em().getComp(GameComponent).levelBounds;
		if (_camera.x < bounds.x)
			_camera.x = bounds.x;
		else if ((_camera.x + _camera.width) > (bounds.right))
			_camera.x = bounds.right - _camera.width;
			
		if (_camera.y < bounds.y)
			_camera.y = bounds.y;
		else if ((_camera.y + _camera.height) > (bounds.bottom))
			_camera.y = bounds.bottom - _camera.height;
	}
	
}