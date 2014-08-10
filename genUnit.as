package {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import G;
	import flash.events.MouseEvent;
	public class genUnit {

		//public var selected = false;
		public var isActive: Boolean;
		private var _colours: Array = ['blue', 'red'];
		private var _unitcolour;
		private var _stage;
		public var _unit_mc;
		private var _unitTimer = new Timer(100);
		private var _randdir = 0;
		private var _brownspeed = 0.3;
		private var _gen_x, _gen_y;
		private var _gen_ok: Boolean = false;
		public var maymove: Boolean = false;
		private var _movementTimer = new Timer(100);
		private var _unitidx;
		public function genUnit(colour, pos, level, idx, args) {

			// constructor code
			isActive = false;
			_unitidx = idx;
			_unitcolour = _colours.indexOf(colour);
			_stage = args["stage"];
			switch (_unitcolour) {
				case 0:
					_unit_mc = new unit_mc();
					_unit_mc.gotoAndStop(1);
					break;
				case 1:
					break;
				case 2:
					break;

			}
			while (_gen_ok == false) {
				_gen_x = Math.floor(Math.random() * level * 20) - (10 * level);
				_gen_y = Math.floor(Math.random() * level * 20) - (10 * level);
				if (Math.pow(_gen_x, 2) + Math.pow(_gen_y, 2) < (100 * level * level)) {
					_unit_mc.x = pos[0] + _gen_x;
					_unit_mc.y = pos[1] + _gen_y;
					_gen_ok = true;
				}
			}
			_unit_mc.alpha = 0.6;
			_stage.addChild(_unit_mc);

			_unitTimer.addEventListener(TimerEvent.TIMER, unitAction);
			_unit_mc.addEventListener(MouseEvent.MOUSE_DOWN, unitTrace);
			function unitAction(e) {
				_randdir = Math.random() * (2 * Math.PI + 0.55);
				_unit_mc.y += Math.sin(_randdir) * _brownspeed;
				_unit_mc.x += Math.cos(_randdir) * _brownspeed;

			}
			function unitTrace(e)
			{
				if(_unit_mc.hitTestPoint(_stage.mouseX, _stage.mouseY, true)){
					trace(" --- DISPLAY VAR --- ");
					trace("isActive:", isActive);
					trace("maymove:",maymove);
				}
			}

			_unitTimer.start();

		}
		public function select() {
			isActive = true;
			_unit_mc.alpha = 1.0;
			
			if (G.setdestination == false) {

				maymove = true;
			}

		}
		public function deselect() {

			isActive = false;
			_unit_mc.alpha = 0.6;
		}
		public function unitmove(end_x, end_y) {
			trace("let's go");
			maymove = false;
			//trace("destination is", end_x, ", ", end_y);
			_unitTimer.addEventListener(TimerEvent.TIMER, _moveAction);
			function _moveAction(e) {
				var _tomove_x = end_x - _unit_mc.x;
				var _tomove_y = end_y - _unit_mc.y;

				var _angle = Math.atan2(_tomove_y, _tomove_x);

				var _nowmove_x = Math.cos(_angle) * 1;
				var _nowmove_y = Math.sin(_angle) * 1;

				_unit_mc.x += _nowmove_x;
				_unit_mc.y += _nowmove_y;
				if (Math.abs(_tomove_x) < 5 && Math.abs(_tomove_y) < 5) {
					for (var i = 0; i < G.colourPlanets.length; i++) {
						//trace("upgrade");
						var dsx = G.planetsObj["planet" + i].coords[0] - end_x;
						var dsy = G.planetsObj["planet" + i].coords[1] - end_y;

						var dss = Math.sqrt(dsx * dsx + dsy * dsy);
						if (dss < G.planetsObj["planet" + i].plevel * 10) {
							trace("upgrade");
							trace(_unitidx);
							G.planetsObj["planet" + i].unitsCount -= 1;
							G.planetsObj["planet" + i].units["unit" + _unitidx] = null;
							G.planetsObj["planet" + i].health += 1;
							if(_stage.contains(_unit_mc))
							{
								_stage.removeChild(_unit_mc);
								break;
							}
							
							


						}
					}

					_unitTimer.removeEventListener(TimerEvent.TIMER, _moveAction);
					_unitTimer.stop();

				}


			}
			_unitTimer.start();
		}

	}

}