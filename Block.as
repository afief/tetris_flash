package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Block extends MovieClip {
		
		protected var _timer:Timer;
		public var _onFinish:Function;
		public var matrik:Matriks;

		public function Block(tipe:int, onFinish:Function) {
			// constructor code
			matrik = new Matriks();
			matrik.no = tipe;
			matrik.rot = 0;
			_onFinish = onFinish;
			fill(matrik.arBlockRandom());
			
			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		function _init(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, _init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kdown);
		}
		protected function kdown(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.UP) {
				rotasiKanan();
			}
			if (e.keyCode == Keyboard.DOWN) {
				geserBawah();
			}
			if (e.keyCode == Keyboard.LEFT) {
				geserKiri();
			}
			if (e.keyCode == Keyboard.RIGHT) {
				geserKanan();
			}
		}
		public function mulai() {
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, updateTimer);
			_timer.start();
		}
		protected function updateTimer(e:TimerEvent):void {
			geserBawah();
		}
		public function posOffset():Point {
			return new Point(Math.floor(this.x / Game._offset), Math.floor(this.y / Game._offset));
		}
		public function setPosisi(po:Point):void { 
			this.x = po.x;
			this.y = po.y;
		}
		public function geserBawah():void {
			var pos:Point = posOffset();
			pos.y += 1;
			if (Game.cekBisa(pos, matrik.arBlock())) {
				this.y += Game._offset;
			} else {
				//selesai sampai bawah
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, kdown);
				_timer.removeEventListener(TimerEvent.TIMER, updateTimer);
				_timer.stop();
				_onFinish.apply(this, new Array(posOffset(), matrik.arBlock()));
				MovieClip(parent).removeChild(this);
			}
			trace(posOffset());
		}
		public function geserKiri():void {
			var pos:Point = posOffset();
			pos.x -= 1;
			if (Game.cekBisa(pos, matrik.arBlock())) {
				this.x -= Game._offset;
			}
		}
		public function geserKanan():void {
			var pos:Point = posOffset();
			pos.x += 1;
			if (Game.cekBisa(pos, matrik.arBlock())) {
				this.x += Game._offset;
			}
		}
		public function rotasiKanan():void {
			matrik.rotKanan();
			if (Game.cekBisa(posOffset(), matrik.arBlock())) {
				wipe();
				fill(matrik.arBlock());
			} else {
				matrik.rotKiri();
				if (posOffset().x < 0) {
					geserKanan();
					rotasiKanan();
				}
				if (posOffset().x > (Game._lebar - matrik.arBlock().length)) {
					geserKiri();
					rotasiKanan();
				}
			}
		}
		protected function fill(mat:Array):void {
			var ktk:MovieClip;
			for (var i:int = 0; i < mat.length; i++) {
				for (var j:int = 0; j < mat.length; j++) {
					if (mat[i][j] == 1) {
						ktk = new Kotak();
						ktk.y = i * Game._offset;
						ktk.x = j * Game._offset;
						this.addChild(ktk);
					}
				}
			}
		}
		protected function wipe():void {
			this.removeChildren();
		}
	}
	
}
