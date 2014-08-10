package {
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class genPlanet {
		private var _planet_mc;
		private var _colours: Array = new Array('grey', 'blue', 'red');
		private var _planetcolour;
		private var _stage;
		public var units: Object = {};
		public var unitsIdx = 0;
		private var _spawnTimer;
		public var planetcolour;
		public var coords;
		public var plevel;
		public var health;
		public function genPlanet(colour, pos, level, maxlevel, args) {
			// constructor code
			_stage = args["stage"];
			planetcolour = colour;
			health = 50;
			_planetcolour = _colours.indexOf(colour);
			_planet_mc = new planet_mc();
			plevel = level;
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
					break;

			}
			coords = pos;
			_planet_mc.x = pos[0];
			_planet_mc.y = pos[1];

			_stage.addChild(_planet_mc);
			if (_planetcolour != 0) {
				_spawnTimer = new Timer(2000);
				_spawnTimer.addEventListener(TimerEvent.TIMER, spawnunits);
				function spawnunits(e) {
					units["unit" + unitsIdx] = new genUnit(colour, pos, level, unitsIdx, args);
					unitsIdx += 1;

				}
				_spawnTimer.start();
			}


		}

	}

}