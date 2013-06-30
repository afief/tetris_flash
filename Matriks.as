package  {
	
	public class Matriks {
		
		public var ar:Array;
		public var no:int;
		public var rot:int = 0;
		
		public function Matriks() {
			// constructor code
			prepare();
		}
		public function prepare() {
			var d1:Array = [[[1,1,1],
							 [0,1,0],
							 [0,0,0]],
							 
							[[0,0,1],
							 [0,1,1],
							 [0,0,1]],
							 
							[[0,0,0],
							 [0,1,0],
							 [1,1,1]],
							 
							[[1,0,0],
							 [1,1,0],
							 [1,0,0]]];
							 
			var d2:Array = [[[0,0,1],
							 [1,1,1],
							 [0,0,0]],
							 
							[[0,1,0],
							 [0,1,0],
							 [0,1,1]],
							 
							[[0,0,0],
							 [1,1,1],
							 [1,0,0]],
							 
							[[1,1,0],
							 [0,1,0],
							 [0,1,0]]];
							 
			var d3:Array = [[[0,0,0],
							 [1,1,1],
							 [0,0,1]],
							 
							[[0,1,0],
							 [0,1,0],
							 [1,1,0]],
							 
							[[1,0,0],
							 [1,1,1],
							 [0,0,0]],
							 
							[[0,1,1],
							 [0,1,0],
							 [0,1,0]]];
							 
			var d4:Array = [[[0,0,0,0],
							 [1,1,1,1],
							 [0,0,0,0],
							 [0,0,0,0]],
							 
							[[0,1,0,0],
							 [0,1,0,0],
							 [0,1,0,0],
							 [0,1,0,0]],
							 
							[[0,0,0,0],
							 [1,1,1,1],
							 [0,0,0,0],
							 [0,0,0,0]],
							 
							[[0,1,0,0],
							 [0,1,0,0],
							 [0,1,0,0],
							 [0,1,0,0]]];
			
			var d5:Array = [[[1,1],
							 [1,1]],
							 
							[[1,1],
							 [1,1]],
							 
							[[1,1],
							 [1,1]],
							 
							[[1,1],
							 [1,1]]];
			
			var d6:Array = [[[1,0,0],
							 [1,1,0],
							 [0,1,0]],
							 
							[[0,1,1],
							 [1,1,0],
							 [0,0,0]],
							 
							[[1,0,0],
							 [1,1,0],
							 [0,1,0]],
							 
							[[0,1,1],
							 [1,1,0],
							 [0,0,0]]];
							 
			var d7:Array = [[[0,0,1],
							 [0,1,1],
							 [0,1,0]],
							 
							[[1,1,0],
							 [0,1,1],
							 [0,0,0]],
							 
							[[0,0,1],
							 [0,1,1],
							 [0,1,0]],
							 
							[[1,1,0],
							 [0,1,1],
							 [0,0,0]]];
							 
			ar = new Array(d1,d2,d3,d4,d5,d6,d7);
		}
		public function arAktif():Array {
			if (no >= 0) {
				return ar[no];
			} else {
				return new Array();
			}
		}
		public function arBlock():Array {
			if (no >= 0) {
				return ar[no][rot];
			} else {
				return new Array();
			}
		}
		public function arBlockRandom():Array {
			rot = Math.floor(Math.random() * 4);
			return arBlock();
		}
		public function rotKanan():void {
			rot++;
			if (rot > 3) {
				rot = 0;
			}
		}
		public function rotKiri():void {
			rot--;
			if (rot < 0) {
				rot = 3;
			}
		}
	}
	
}
