package djboom.tradering.display.lobby {
	import djboom.display.smart.HotSpot;
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.display.smart.SmartTextField;
	import djboom.interfaces.smart.ISmartBitmap;
	import djboom.interfaces.smart.ISmartTextField;
	import djboom.tradering.data.GameInfo;
	import djboom.tradering.events.GameEvent;
	import djboom.tradering.state.Currency;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class LobbyGameItem extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const BACK:String = "bitmap.lobby.GameItem";
		// bitmap.lobby.GameItemGold
		// text color - e9d901
		private static const BITMAP_JOINGAME:String = "bitmap.lobby.JoinGame";

		public static const HEIGHT:int = 33;

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _info:GameInfo;

		private var _back:ISmartBitmap;

		private var _titleField:ISmartTextField;
		private var _ownerField:ISmartTextField;
		private var _playersField:ISmartTextField;
		private var _betField:ISmartTextField;
		// private var _typeField:ISmartTextField;

		private var _joinGame:HotSpot;
		private var _currency:String;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function LobbyGameItem(info:Object) {
			super();

			_info = new GameInfo(info);



			// Cc.inspect(_info);

			_back = new SmartBitmap(getBitmap(BACK, false));
			addChild(DisplayObject(_back));


			_titleField = new SmartTextField();
			_titleField.move(15, 7);
			_titleField.htmlText = '<span class="titlegame">' + _info.gameName + '</span>';
			addChild(DisplayObject(_titleField));

			_ownerField = new SmartTextField();
			_ownerField.htmlText = '<span class="ownergame">' + _info.creatorName + '</span>';
			_ownerField.move(209, 7);
			addChild(DisplayObject(_ownerField));

			_playersField = new SmartTextField();
			_playersField.htmlText = '<span class="text">' + _info.currentPlayersCount + '</span>';
			_playersField.move(int((90 - _playersField.textWidth) * 0.5 + 343), 7);
			addChild(DisplayObject(_playersField));

			// Определяем валюту


			if (_info.currency == Currency.GOLDEN) {
				_currency = Currency.GOLDEN_TEXT + "ов";
			} else {
				_currency = Currency.VIRTUAL_TEXT + "ов";
			}

			_betField = new SmartTextField();
			_betField.htmlText = '<span class="text">' + _currency + '</span>';
			_betField.move(int((90 - _betField.textWidth) * 0.5 + 538), 7);
			addChild(DisplayObject(_betField));


			_joinGame = new HotSpot();
			_joinGame.drawBitmapByName(BITMAP_JOINGAME, false);
			_joinGame.x = 807;
			addChild(_joinGame);

			// Cc.addHTMLch("current", 2, this, "<current><b>_info.gameStatus</b></current>:", "<current>" + _info.gameStatus + "</current>");

			_joinGame.addEventListener(MouseEvent.CLICK, joinGame);
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Видимые методы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Переопределенные методы.
		// ----------------------------------------------------------------------------

		override public function dispose():void {
			_info = null;

			if (_back != null) {
				_back.dispose();
				_back = null;
			}

			if (_titleField != null) {
				_titleField.dispose();
				_titleField = null;
			}

			if (_ownerField != null) {
				_ownerField.dispose();
				_ownerField = null;
			}

			if (_playersField != null) {
				_playersField.dispose();
				_playersField = null;
			}


			if (_betField != null) {
				_betField.dispose();
				_betField = null;
			}


			if (_joinGame != null) {
				_joinGame.dispose();
				_joinGame = null;
			}

			super.dispose();
		}

		override public function reflect():Class {
			return LobbyGameItem;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		private function joinGame(event:MouseEvent):void {
			var e:GameEvent = new GameEvent(GameEvent.JOIN);
			e.gameId = _info.gameId;
			// e.currency = _info.currency;
			// e.bet = _info.rate;
			dispatchEvent(e);
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function get title():String {
			return _info.gameName;
		}

		public function get owner():String {
			return _info.creatorName;
		}

		public function get players():int {
			return int(_info.currentPlayersCount);
		}



		public function get gameId():String {
			return _info.gameId;
		}

		public function update(info:Object):void {
			_info = new GameInfo(info);

			_playersField.htmlText = '<span class="text">' + _info.currentPlayersCount + '</span>';

			this.alpha = 1;

			if (!_joinGame.hasEventListener(MouseEvent.CLICK)) _joinGame.addEventListener(MouseEvent.CLICK, joinGame);
		}

		public function get currency():String {
			return _currency;
		}

		public function get betField():ISmartTextField {
			return _betField;
		}
	}
}