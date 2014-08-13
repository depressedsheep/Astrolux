package {
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class genPlanet {
		public var _planet_mc;
		private var _colours: Array = new Array('grey', 'blue', 'red');
		private var _planetcolour;
		private var _stage;
		public var units: Object = {};
		public var unitsIdx = 0;
		public var unitsCount = 0;
		private var _spawnTimer;
		public var planetcolour;
		public var coords;
		public var plevel;
		public var mplevel;
		public var health;
		private var _health_mc;
		public var health_visible = false;
		public function genPlanet(colour, pos, level, maxlevel, args) {
			// constructor code
			_stage = args["stage"];
			planetcolour = colour;
			health = 50;
			_planetcolour = _colours.indexOf(colour);
			_planet_mc = new planet_mc();
			plevel = level;
			mplevel = maxlevel;
			switch (_planetcolour) {
				case 0:
					_planet_mc.gotoAndStop(1);
					break;
				case 1:
					if (level == 1) {
						_planet_mc.gotoAndStop(2);
					} else if (level == 2) {
						_planet_mc.gotoAndStop(3);
					} else if (level == 3) {
						_planet_mc.gotoAndStop(4);
					}
					break;
				case 2:
					if (level == 1){
						_planet_mc.gotoAndStop(5);
				 	}
					else if (level == 2){
						_planet_mc.gotoAndStop(6);
					}
					else if (level == 3){
						_planet_mc.gotoAndStop(7);
					}
					break;

			}
			coords = pos;
			_planet_mc.x = pos[0];
			_planet_mc.y = pos[1];

			_stage.addChild(_planet_mc);
			if (_planetcolour != 0) {
				_spawnTimer = new Timer(500);
				_spawnTimer.addEventListener(TimerEvent.TIMER, spawnunits);
				function spawnunits(e) {
					for (var i = 0; i < plevel; i++) {
						units["unit" + unitsIdx] = new genUnit(colour, pos, level, unitsIdx, args);
						unitsIdx += 1;
						unitsCount += 1;
					}


				}
				_spawnTimer.start();
			}


		}
		public function genHealth() {
			_health_mc = new health_mc();
			_health_mc.y = coords[1] + 20;
			_health_mc.x = coords[0] - (0.5 * _health_mc.width);;
			_health_mc.gotoAndStop(0)
			_stage.addChild(_health_mc);
		}
		public function updateHealth(_health) {
			if (_health % 50 != 0) {
				trace("health increasing");
			}
			_health = _health % 50;
			_health_mc.gotoAndStop(_health);
			//trace("health is", _health);
		}
		public function removeHealthBar(){
			_stage.removeChild(_health_mc);
		}

	}

}