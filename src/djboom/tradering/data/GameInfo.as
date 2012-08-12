package djboom.tradering.data {

	import com.junkbyte.console.Cc;

	/**
	 * Информация об игре.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class GameInfo {

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		// идентификатор игры (комнаты)
		private var _gameId:String;

		// название игры
		private var _gameName:String;

		//
		private var _nominal:String;

		// валюта (1 – голдены, 2 – виртуалы)
		private var _currency:String;

		//
		private var _auctionEnabled:String;

		//
		private var _gamePhase:String;

		//
		private var _companies:Object;

		//
		private var _users:Object;
		
		
		private var _creatorId:String;
		private var _creatorName:String;
		private var _currentPlayersCount:String;
		

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GameInfo(o:Object) {
			for (var key:String in o) {
				try {
					this["_" + key] = o[key];
				} catch(error:ReferenceError) {
					Cc.error("В GameInfo не существует свойста ", key, this);
				}
			}

			Cc.addSlashCommand("gameinfo", showGameInfo);
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		private function showGameInfo():void {
			Cc.info('');
			Cc.info('**************  Информация об игре  ***************');
			Cc.info('');
			Cc.inspect(this);
			Cc.info('');
			Cc.info('*******************************************************');
			Cc.info('');
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function get gameId():String {
			return _gameId;
		}


		public function get gameName():String {
			return _gameName;
		}

		public function get nominal():String {
			return _nominal;
		}

		public function get currency():String {
			return _currency;
		}

		public function get auctionEnabled():String {
			return _auctionEnabled;
		}

		public function get gamePhase():String {
			return _gamePhase;
		}

		public function get companies():Object {
			return _companies;
		}

		public function get users():Object {
			return _users;
		}

		public function get creatorId():String {
			return _creatorId;
		}

		public function get creatorName():String {
			return _creatorName;
		}

		public function get currentPlayersCount():String {
			return _currentPlayersCount;
		}

		public function set gamePhase(gamePhase:String):void {
			_gamePhase = gamePhase;
		}



	}
}