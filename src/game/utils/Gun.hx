package game.utils;

/**
 * ...
 * @author Tommislav
 */

class Gun 
{
	public var spawnOffsetAngle:Float;
	public var spawnOffsetDistance:Float;
	public var directionRadians:Float;
	public var reloadDuration:Int;
	public var reloadTimer:Int;
	public var gunHasBeenFired:Bool;
	public var bulletType:String;
	
	public function new() 
	{
		
	}
	
	public function tick() {
		if (reloadTimer > 0) {
			reloadTimer--;
		}
	}
	
	public function canFire():Bool {
		return (reloadTimer == 0);
	}
	
	public function fire():Void {
		gunHasBeenFired = true;
		reloadTimer = reloadDuration;
	}
	
	
	public static function build(spawnOffsetAngle:Float, spawnOffsetDistance:Float, directionInRadians:Float, reloadDuration:Int, bulletType:String="") {
		var gun:Gun = new Gun();
		gun.spawnOffsetAngle = spawnOffsetAngle;
		gun.spawnOffsetDistance = spawnOffsetDistance;
		gun.directionRadians = directionInRadians;
		gun.reloadDuration = reloadDuration;
		gun.bulletType = bulletType;
		gun.gunHasBeenFired = false;
		gun.reloadTimer = 0;
		return gun;
	}
}