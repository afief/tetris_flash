package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Game extends MovieClip {
		
		public var _arena:MovieClip;
		public static var _arenar:Array;
		public static var _lebar:int = 20;
		public static var _tinggi:int = 30;
		public static var _offset:int = 24;

		public function Game(arena:Class) {
			// constructor code
			_arena = new arena();
			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		protected function _init(e:Event):void {
			initArenar();
			this.addChild(_arena);
			kotakBaru();
		}
		protected function initArenar():void {
			_arenar = new Array();
			var temp:Array;	
			for (var i:int = -10; i < _tinggi; i++) {
				temp = new Array();
				temp[-1] = 1;
				for (var j:int = 0; j < _lebar; j++) {
					temp[j] = 0;
				}
				temp[_lebar] = 1;
				_arenar[i] = temp;
			}
			
			//nambah 1 baris kotak 1 semua di bagian bawah arena
			temp = new Array();
			for (j = 0; j < _lebar; j++) {
				temp[j] = 1;
			}
			_arenar.push(temp);
		}
		protected function kotakBaru():void {
			var tet:Block = new Block(Math.floor(Math.random() * 7), blockFinish);
			tet.setPosisi(getPosisi(8,0 - tet.matrik.arBlock().length));
			tet.mulai();
			
			_arena.addChild(tet);
		}
		protected function blockFinish(pos:Point, ar:Array):void {
			var ktk:MovieClip;
			for (var i:int = 0; i < ar.length; i++) {
				for (var j:int = 0; j < ar[i].length; j++) {
					if (ar[i][j] == 1) {
						_arenar[pos.y + i][pos.x + j] = 1;
						ktk = new Kotak();
						ktk.name = 'ktk' + (pos.y + i) + '-' + (pos.x + j);
						ktk.y = (i + pos.y) * Game._offset;
						ktk.x = (j + pos.x) * Game._offset;
						_arena.addChild(ktk);
					}
				}
			}
			kotakBaru();
			cekRuntuh();
		}
		protected function cekRuntuh():void {
			var sama:Boolean;
			for (var i:int = 0; i < _tinggi; i++) {
				sama = true;
				for (var j:int = 0; j < _lebar; j++) {
					if (_arenar[i][j] == 0) sama = false;
				}
				if (sama) runtuhkan(i);
			}
		}
		protected function runtuhkan(baris:int):void {
			if (baris > 0) {
				for (var i:int = baris; i > 0; i--) {
					for (j = 0; j < _lebar; j++) {
						if (_arenar[i-1][j] == 0) {
							if (!_removeChild('ktk' + i + '-' + j)) trace('gagal' + 'ktk' + i + '-' + j);
						}
						_arenar[i][j] = _arenar[i-1][j];
					}
				}
			} else {
				for (var j:int = 0; j < _lebar; j++) {
					_arenar[baris][j] = 0;
					if (!_removeChild('ktk' + baris + '-' + j)) trace('gagal' + 'ktk' + baris + '-' + j);
				}
			}
		}
		protected function _removeChild(nama:String):Boolean {
			for (var i:int = 0; i < _arena.numChildren; i++) {
				if (_arena.getChildAt(i).name == nama) {
					_arena.removeChild(_arena.getChildAt(i));
					return true;
				}
			}
			return false;
		}
		public function getPosisi(px:int, py:int):Point {
			return new Point(px * _offset, py * _offset);
		}
		public static function cekBisa(pos:Point, ar:Array):Boolean {
			for (var i:int = 0; i < ar.length; i++) {
				for (var j:int = 0; j < ar[i].length; j++) {
					if ((ar[i][j] == 1) && (_arenar[pos.y + i][pos.x + j] == 1)) {
						return false;
					}
					
				}
			}
			return true;
		}
	}
	
}
