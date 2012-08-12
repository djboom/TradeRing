package djboom.tradering.state {

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class ServerPath {

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private static var _gameServer:String = "http://tr-game.office.rosbd.com";
		private static var _gameServerRequest:String = "/flashclient/";

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function ServerPath() {
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		/**
		 * Путь к game-серверу.
		 * 
		 */

		static public function get gameServer():String {
			return _gameServer;
		}

		static public function set gameServer(path:String):void {
			_gameServer = path;
		}
		
		static public function get gameServerRequest():String {
			return _gameServerRequest;
		}

		static public function set gameServerRequest(path:String):void {
			_gameServerRequest = path;
		}

	}
}