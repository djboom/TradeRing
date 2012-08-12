package djboom.tradering.events {
	import djboom.tradering.data.GameInfo;

	import flash.events.Event;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class GameEvent extends Event {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		public static const JOIN:String = "joinGame";

		public static const CREATE:String = "createGame";
		public static const LEAVE_WAITING:String = "leaveWaiting";
		public static const CHANGE_READINESS:String = "changeReadiness";
		public static const START_GAME:String = "START_GAME";

		public static const DISABLE_TARGET:String = "disableTarget";

		public static const EXIT:String = "exitGame";
		public static const GAME_OVER:String = "GAME_OVER";
		public static const DISABLE_LONGPOLLING:String = "DISABLE_LONGPOLLING";
		public static const REFRESH_PLAYERS:String = "REFRESH_PLAYERS";
		public static const ANIMATE_TARGET:String = "ANIMATE_TARGET";

		public static const SHOW_LOCK_LAYER:String = "showLockLayer";
		public static const HIDE_LOCK_LAYER:String = "hideLockLayer";
		public static const SHOW_READY_WINDOW:String = "SHOW_READY_WINDOW";
		public static const REMOVE_READY_WINDOW:String = "REMOVE_READY_WINDOW";
		public static const LEAVE_GAME:String = "LEAVE_GAME";
		
		
		
		
		// Купить на удачу
		public static const BUY_GOODLUCK:String = "BUY_GOODLUCK";
		
		// Продать всё
		public static const SELL_ALL:String = "SELL_ALL";
		
		

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		// идентификатор игры
		private var _gameId:String;

		// название игры
		private var _gameName:String;

		// первоначальная цена акции
		private var _nominal:String;

		// валюта
		private var _currency:String;

		// с аукционом или нет
		private var _auctionEnabled:String;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		override public function clone():Event {
			var e:GameEvent = new GameEvent(this.type, this.bubbles, this.cancelable);
			e.gameId = this.gameId;
			e.gameName = this.gameName;
			e.nominal = this.nominal;
			e.currency = this.currency;
			e.auctionEnabled = this.auctionEnabled;
			return e;
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		// идентификатор игры
		public function get gameId():String {
			return _gameId;
		}

		// идентификатор игры
		public function set gameId(gameId:String):void {
			_gameId = gameId;
		}

		// название игры
		public function get gameName():String {
			return _gameName;
		}

		// название игры
		public function set gameName(gameName:String):void {
			_gameName = gameName;
		}

		// валюта
		public function get currency():String {
			return _currency;
		}

		// валюта
		public function set currency(currency:String):void {
			_currency = currency;
		}

		// первоначальная цена акции
		public function get nominal():String {
			return _nominal;
		}

		// первоначальная цена акции
		public function set nominal(nominal:String):void {
			_nominal = nominal;
		}

		// с аукционом или нет
		public function get auctionEnabled():String {
			return _auctionEnabled;
		}

		// с аукционом или нет
		public function set auctionEnabled(auctionEnabled:String):void {
			_auctionEnabled = auctionEnabled;
		}

	}
}