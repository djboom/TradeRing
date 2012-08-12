package djboom.tradering.managers {

	/**
	 * Переменные html-контейнера.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class FlashVarsManager {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const VARS_ASSETS:String = "assets";
		private static const VARS_APPLICATION:String = "app";

		private static const VARS_SESSION_ID:String = "sessionId";
		private static const VARS_PLAYER_ID:String = "playerId";
		private static const VARS_GAMESERVER_PATH:String = "gameServerPath";
		private static const VARS_GAMESERVER_REQUEST:String = "gameServerRequest";


		private static const ASSETS:String = "assets.swf";
		private static const APPLICATION:String = "app.swf";

		private static const SESSION_ID:String = "-1";
		private static const PLAYER_ID:String = "-1";
		private static const GAMESERVER_PATH:String = "http://tr-game.office.rosbd.com";
		private static const GAMESERVER_REQUEST:String = "/flashclient/";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		/**
		 * Библиотека элементов приложения.
		 * 
		 */

		private var _assets:String;


		/**
		 * Приложение.
		 * 
		 */

		private var _application:String;


		/**
		 * Идентификатор сессии.
		 * 
		 */

		private var _sessionID:String;


		/**
		 * Идентификатор пользователя.
		 * 
		 */

		private var _playerId:String;


		/**
		 * Путь до гейм-сервера.
		 * 
		 */

		private var _gameServerPath:String;


		/**
		 * Относительынй путь для запросов на гейм-сервер.
		 * 
		 */

		private var _gameServerRequest:String;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function FlashVarsManager(o:Object) {
			_assets = o[VARS_ASSETS] || ASSETS;
			_application = o[VARS_APPLICATION] || APPLICATION;
			_sessionID = o[VARS_SESSION_ID] || SESSION_ID;
			_playerId = o[VARS_PLAYER_ID] || PLAYER_ID;
			_gameServerPath = o[VARS_GAMESERVER_PATH] || GAMESERVER_PATH;
			_gameServerRequest = o[VARS_GAMESERVER_REQUEST] || GAMESERVER_REQUEST;
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function get assets():String {
			return _assets;
		}

		public function get application():String {
			return _application;
		}

		public function get sessionID():String {
			return _sessionID;
		}

		public function get playerId():String {
			return _playerId;
		}

		public function get gameServerPath():String {
			return _gameServerPath;
		}

		public function get gameServerRequest():String {
			return _gameServerRequest;
		}
	}
}