package djboom.tradering.events {
	import flash.events.Event;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class GameServerClientEvent extends Event {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		public static const COMPLETE:String = "completeEvent";
		public static const ERROR:String = "errorEvent";
		
		public static const GET_GAMES:String = "GET_GAMES";
		public static const CHAT_MESSAGES:String = "CHAT_MESSAGES";
		public static const WAITING_PLAYERS:String = "WAITING_PLAYERS";
		public static const WAITING_PLAYERS_TIMEOUT:String = "WAITING_PLAYERS_TIMEOUT";
		public static const CHANGE_PHASE:String = "CHANGE_PHASE";
		public static const GAME_OVER:String = "GAME_OVER";
		
		public static const SEND_REQUEST:String = "SEND_REQUEST";
		

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _data:Object;
		private var _action:String;
		private var _message:String;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GameServerClientEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		override public function clone():Event {
			var e:GameServerClientEvent = new GameServerClientEvent(this.type, this.bubbles, this.cancelable);
			e.data = this.data;
			e.action = this.action;
			e.message = this.message;
			return e;
		}


		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
		public function get data():Object {
			return _data;
		}

		public function set data(data:Object):void {
			_data = data;
		}

		public function get action():String {
			return _action;
		}

		public function set action(action:String):void {
			_action = action;
		}

		public function get message():String {
			return _message;
		}

		public function set message(message:String):void {
			_message = message;
		}

	}
}