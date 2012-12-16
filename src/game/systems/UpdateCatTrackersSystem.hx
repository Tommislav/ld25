package game.systems;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.CatComponent;
import game.components.CatTrackerComponent;
import game.components.CenterPointPositionComponent;
import game.components.DamagebleComponent;
import game.components.PlayerComponent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class UpdateCatTrackersSystem extends Sys
{

	public function new() { super(); }
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		// Add listener for cat removed
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		// Remove listener for cat removed
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var player = em().getEWC([PlayerComponent]);
		if (player.length == 0)
			return;
			
		var playerPos = player[0].comp(CenterPointPositionComponent);
		var camera = em().getComp(CameraComponent);
		
		var catTrackerEnt = em().getEWC([CatTrackerComponent]);
		for (tracker in catTrackerEnt) {
			var catId = tracker.comp(CatTrackerComponent).catToTrack;
			
			// If cat is removed, we should also be removed
			var cat = em().getComponentOnEntity(catId, CatComponent);
			var catHealth = em().getComponentOnEntity(catId, DamagebleComponent);
			
			if (cat == null || catHealth.health == 0) {
				tracker.comp(BitmapComponent).remove();
				tracker.destroy();
				continue;
				
			} else {
				
				// Is cat visible in the screen?
				var catPos = em().getComponentOnEntity(catId, CenterPointPositionComponent);
				
				var catVisible = camera.inView(catPos);
				tracker.comp(BitmapComponent).holder.alpha = catVisible ? 0.1 : 1;
				
				var dx = catPos.x - playerPos.x;
				var dy = catPos.y - playerPos.y;
				var angle = Math.atan2(dy, dx);
				var distFromPlayer = 200;
				
				var trackerPos = tracker.comp(CenterPointPositionComponent);
				trackerPos.x = playerPos.x + (Math.cos(angle) * distFromPlayer);
				trackerPos.y = playerPos.y + (Math.sin(angle) * distFromPlayer);
				
				tracker.comp(AngularMovementComponent).setRadians(angle);
			}
		}
	}
	
}