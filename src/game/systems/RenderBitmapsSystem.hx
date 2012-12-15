package game.systems;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.PositionComponent;
import nme.display.Bitmap;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.geom.Matrix;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class RenderBitmapsSystem extends Sys
{
	private var _holder:DisplayObjectContainer;
	private var _camera:CameraComponent;
	
	public function new(holder:DisplayObjectContainer) { 
		_holder = holder; 
		super();
	}
	
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_camera = em.getComp(CameraComponent);
	}
	
	
	
	override public function tick(gt:GameTime):Void 
	{
		var allRenderables = em().getEWC([BitmapComponent]);
		
		for (ew in allRenderables) {
			var bitmapHolder:Sprite = ew.comp(BitmapComponent).holder;
			var pos = ew.comp(PositionComponent);
			bitmapHolder.x = pos.x - _camera.x;
			bitmapHolder.y = pos.y - _camera.y;
			
			if (_camera.inView(pos) == false) {
				if (bitmapHolder.parent != null) {
					bitmapHolder.parent.removeChild(bitmapHolder); // remove
				}
				continue;
			}
			
			if (bitmapHolder.parent == null) {
				_holder.addChild(bitmapHolder); // add
			}
			
			
			
			var rot = ew.comp(AngularMovementComponent);
			bitmapHolder.rotation = rot.angle;
			rot.setDegrees(rot.angle + 1);
		}
	}
	
	private function inCamera(pos:PositionComponent, camera:CameraComponent) 
	{
		var left = pos.x - pos.width;
		var right = pos.x + pos.width;
		var top = pos.y - pos.height;
		var bottom = pos.y + pos.height;
		
		if (right > camera.x && left < (camera.x + camera.width)) {
			if (bottom > camera.y && top < (camera.y + camera.height)) {
				return true;
			}
		}
		return false;
	}
}