package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Main extends MovieClip {
		
		var _game:MovieClip;
		
		public function Main() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		protected function _init(e:Event):void {
			_game = new Game(Arena);
			this.addChild(_game);			
		}
	}
	
}
