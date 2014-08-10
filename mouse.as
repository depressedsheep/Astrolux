package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.events.*;
	import G;
	public class mouse {
		private var _stage;
		private var _noPlanets;
		public var selectionRect: Rectangle;
		public var selectionSprite: Sprite = new Sprite();
		public var isMouseHeld: Boolean;
		private var _mouse_mc;
		public function mouse(noPlanets, args) {
			_noPlanets = noPlanets;
			_stage = args["stage"];
			_mouse_mc = new mouse_mc();
			//_stage.addEventListener(Event.ENTER_FRAME, mouseMouse);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, setStartPoint);
			isMouseHeld = false;
			_stage.addChild(selectionSprite);
			_stage.addChild(_mouse_mc);
			_stage.addEventListener(MouseEvent.MOUSE_UP, RemoveRectangle);
			_stage.addEventListener(Event.ENTER_FRAME, UpdateGame);

		}

		public function setStartPoint(me: MouseEvent) {
			if (G.setdestination == false) {
				G.setdestination = true;
				for (var i = 0; i < _noPlanets; i++) {
					trace("--- 1 ---");
					for (var j = 0; j < G.planetsObj["planet" + i].unitsIdx; j++) {
	
						if (G.planetsObj["planet" + i].units["unit" + j] != null) {
							if (G.planetsObj["planet" + i].units["unit" + j].maymove == true) {

								G.planetsObj["planet" + i].units["unit" + j].unitmove(_stage.mouseX, _stage.mouseY)
							}
						}
					}
				}
			} else if (G.setdestination == true) {
				G.setdestination = false;
			}
			//trace("G.setdestination is", G.setdestination);
			selectionRect = new Rectangle(_stage.mouseX, _stage.mouseY);
			isMouseHeld = true;

			_mouse_mc.gotoAndStop(2);
		}
		public function RemoveRectangle(me: MouseEvent): void {
			_mouse_mc.gotoAndStop(1);
			isMouseHeld = false;
		}


		public function UpdateGame(e) {
			_mouse_mc.x = _stage.mouseX;
			_mouse_mc.y = _stage.mouseY;
			selectionSprite.graphics.clear();
			// Clear the rectangle so it is ready to be drawn again.;

			if (isMouseHeld) {

				selectionRect.width = _stage.mouseX - selectionRect.x; // Set the width of the rectangle.
				selectionRect.height = _stage.mouseY - selectionRect.y; // Set the height of the rectangle.
				selectionSprite.graphics.lineStyle(3, 0x9e9e9e, 0.6);
				selectionSprite.graphics.beginFill(0xe0e0e0, 0.2);
				selectionSprite.graphics.drawRect(selectionRect.x, selectionRect.y, selectionRect.width, selectionRect.height);
				selectionSprite.graphics.endFill();
				checkForSelection();
			}
		}
		public function checkForSelection() {
			for (var i = 0; i < _noPlanets; i++) {
				//trace(G.planetsObj["planet" + i].unitsIdx);
				for (var j = 0; j < G.planetsObj["planet" + i].unitsIdx; j++) {
					if (G.planetsObj["planet" + i].units["unit" + j] != null && G.planetsObj["planet" + i].planetcolour == 'blue') {
						if (G.planetsObj["planet" + i].units["unit" + j]._unit_mc.hitTestObject(selectionSprite)) {
							G.planetsObj["planet" + i].units["unit" + j].select();

						} else {
							G.planetsObj["planet" + i].units["unit" + j].deselect();
						}
					}
				}

			}
		}
	}

}