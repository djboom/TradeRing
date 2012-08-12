package djboom.tradering.data {

	import com.junkbyte.console.Cc;

	/**
	 * Информация об игроке.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class PlayerInfo {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		// идентификатор пользователя
		private var _playerId:String;

		// имя пользователя
		private var _playerName:String;
		
		private var _stocks:Object;

		
		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function PlayerInfo(o:Object) {
			for (var key:String in o) {
				try {
					this["_" + key] = o[key];
				} catch(error:ReferenceError) {
					Cc.error("В PlayerInfo не существует свойста ", key, this);
				}
			}
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function get playerId():String {
			return _playerId;
		}

		public function get playerName():String {
			return _playerName;
		}


		public function get stocks():Object {
			return _stocks;
		}
	}
}