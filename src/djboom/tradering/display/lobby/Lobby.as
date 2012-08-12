package djboom.tradering.display.lobby {
	import djboom.display.smart.HotSpot;
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.display.smart.SmartTextField;
	import djboom.events.Broadcaster;
	import djboom.interfaces.smart.ISmartBitmap;
	import djboom.interfaces.smart.ISmartContainer;
	import djboom.interfaces.smart.ISmartTextField;
	import djboom.tradering.Application;
	import djboom.tradering.display.simple.Scroll;
	import djboom.tradering.events.GameEvent;
	import djboom.tradering.events.GameServerClientEvent;
	import djboom.tradering.events.SortEvent;
	import djboom.tradering.server.GSRequestClient;
	import djboom.tradering.state.Actions;
	import djboom.utils.DisplayObjectUtil;

	import com.greensock.TweenLite;
	import com.junkbyte.console.Cc;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;


	/**
	 * Текущие игры.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class Lobby extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const BACK:String = "bitmap.lobby.Back";

		private static const BITMAP_CREATE_GAME:String = "bitmap.lobby.CreateGame";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		// Фон
		private var _back:ISmartBitmap;

		// Массив текущих игр
		private var _games:Array = [];

		// Поле для вывода информации о количестве текущих игр
		private var _totalGameField:ISmartTextField;

		private var _sortName:SortButton;
		private var _sortOwner:SortButton;
		private var _sortPlayer:SortButton;
		private var _sortMax:SortButton;
		private var _sortBet:SortButton;
		private var _sortTypeGame:SortButton;

		private var _createGameHS:HotSpot;

		private var _container:ISmartContainer;

		private var _scroll:Scroll;
		private var _client:GSRequestClient;
		private var _moneyField:ISmartTextField;
		private var _realBalance:String;
		private var _virtualBalance:String;



		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Lobby() {
			super();


			_back = new SmartBitmap(getBitmap(BACK));
			addChild(DisplayObject(_back));

			_totalGameField = new SmartTextField();
			_totalGameField.htmlText = '<span class="text">Всего созданных игр: ' + _games.length + '</span>';
			_totalGameField.move(_back.width - _totalGameField.width - 20, 470);
			addChild(DisplayObject(_totalGameField));

			_moneyField = new SmartTextField();
			_moneyField.htmlText = '<span class="text"><b>Баланс:</b></span> <span class="gray">реалов</span> <span class="graybold">' + _realBalance + '</span><span class="gray">, виртуалов</span> <span class="graybold">' + _virtualBalance + '</span>';
			_moneyField.move(_back.width - _moneyField.textWidth - 48, 25);
			addChild(DisplayObject(_moneyField));

			_container = new SmartContainer();
			_container.move(16, 90);
			addChild(DisplayObject(_container));

			createSortButton();

			_createGameHS = new HotSpot();
			_createGameHS.drawBitmapByName(BITMAP_CREATE_GAME);
			_createGameHS.move(810, 50);
			addChild(_createGameHS);

			getGamesList();
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		// Кнопки сортировки
		private function createSortButton():void {
			_sortName = new SortButton("Название игры", "title");
			_sortName.x = 16;
			_sortName.y = 54;
			_sortName.addEventListener(SortEvent.SORT, sortGames);
			addChild(_sortName);

			_sortOwner = new SortButton("Создатель", "owner");
			_sortOwner.x = 210;
			_sortOwner.y = 54;
			_sortOwner.addEventListener(SortEvent.SORT, sortGames);
			addChild(_sortOwner);

			_sortPlayer = new SortButton("Игроки", "players");
			_sortPlayer.x = 360;
			_sortPlayer.y = 54;
			_sortPlayer.addEventListener(SortEvent.SORT, sortGames);
			addChild(_sortPlayer);

			_sortMax = new SortButton("Максимум", "max");
			_sortMax.x = 450;
			_sortMax.y = 54;
			_sortMax.addEventListener(SortEvent.SORT, sortGames);
			addChild(_sortMax);

			_sortBet = new SortButton("Ставка", "bet");
			_sortBet.x = 557;
			_sortBet.y = 54;
			_sortBet.addEventListener(SortEvent.SORT, sortGames);
			addChild(_sortBet);

			_sortTypeGame = new SortButton("Тип игры         ", "type");
			_sortTypeGame.x = 648;
			_sortTypeGame.y = 54;
			_sortTypeGame.addEventListener(SortEvent.SORT, sortGames);
			addChild(_sortTypeGame);
		}

		private function redraw():void {
			for (var i:int = 0; i < _games.length; i++) {
				var game:LobbyGameItem = _games[i] as LobbyGameItem;
				game.y = LobbyGameItem.HEIGHT * i;
			}
		}

		private function updateGames(gamesInfo:Object):void {
			_container.clear();
			_games.length = 0;

			for each (var data:Object in gamesInfo) {
				createPlayer(data);
			}
		}

		private function createPlayer(data:Object):LobbyGameItem {
			var gameItem:LobbyGameItem = new LobbyGameItem(data);
			gameItem.addEventListener(GameEvent.JOIN, joinGame);
			gameItem.y = DisplayObjectUtil.getFullBounds(_container).height;
			_container.addChild(gameItem);

			_games.push(gameItem);

			_totalGameField.htmlText = '<span class="text">Всего созданных игр: ' + _games.length + '</span>';

			if (DisplayObjectUtil.getFullBounds(_container).height > 363) {
				if (_scroll == null) {
					_scroll = new Scroll(_container, 363, 363);
					_scroll.x = 956;
					_scroll.y = 90;
					addChild(_scroll);
				} else {
					_scroll.update(DisplayObjectUtil.getFullBounds(_container).height);
				}
			}

			redraw();

			return gameItem;
		}

		private function getGamesList():void {
			_client = new GSRequestClient();
			_client.action = Actions.GET_FULL_GAMES_LIST;
			_client.sandbox = this;
			_client.addEventListener(GameServerClientEvent.COMPLETE, clientComplete);
			_client.addEventListener(GameServerClientEvent.ERROR, clientError);
			_client.load();
		}


		// ----------------------------------------------------------------------------
		// Видимые методы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Переопределенные методы.
		// ----------------------------------------------------------------------------


		override public function dispose():void {
			Broadcaster.removeEventListener(GameServerClientEvent.GET_GAMES, updateGamesProxy);

			destroyClient();

			if (_back != null) {
				_back.dispose();
				_back = null;
			}

			if (_container != null) {
				_container.dispose();
				_container = null;
			}

			_games.length = 0;
			_games = null;

			if (_totalGameField != null) {
				_totalGameField.dispose();
				_totalGameField = null;
			}

			if (_createGameHS != null) {
				_createGameHS.dispose();
				_createGameHS = null;
			}

			if (_scroll != null) {
				_scroll.dispose();
				_scroll = null;
			}

			if (_sortName != null) {
				_sortName.dispose();
				_sortName = null;
			}

			if (_sortOwner != null) {
				_sortOwner.dispose();
				_sortOwner = null;
			}

			if (_sortPlayer != null) {
				_sortPlayer.dispose();
				_sortPlayer = null;
			}

			if (_sortMax != null) {
				_sortMax.dispose();
				_sortMax = null;
			}

			if (_sortBet != null) {
				_sortBet.dispose();
				_sortBet = null;
			}

			if (_sortTypeGame != null) {
				_sortTypeGame.dispose();
				_sortTypeGame = null;
			}

			super.dispose();
		}

		override public function reflect():Class {
			return Lobby;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		private function sortGames(event:SortEvent):void {
			_games.sortOn(event.sortField, event.sortType);

			redraw();
		}

		private function createGame(event:MouseEvent):void {
			dispatchEvent(new GameEvent(GameEvent.CREATE));
		}

		private function joinGame(event:GameEvent):void {
			dispatchEvent(event);
		}

		private function clientComplete(event:GameServerClientEvent):void {
			destroyClient();

			TweenLite.from(_container, 0.3, {alpha:0});


			updateGames(event.data);

			_createGameHS.addEventListener(MouseEvent.CLICK, createGame);

			Broadcaster.addEventListener(GameServerClientEvent.GET_GAMES, updateGamesProxy);
		}

		private function updateGamesProxy(event:GameServerClientEvent):void {
			Cc.addHTMLch("systrace", 1, "<blue>функция updateGamesProxy(event)</blue>", this);
			
			updateGames(event.data);
		}

		private function clientError(event:GameServerClientEvent):void {
			destroyClient();
		}

		private function destroyClient():void {
			if (_client != null) {
				_client.dispose();
				_client = null;
			}
		}

		public function set realBalance(realBalance:String):void {
			_realBalance = realBalance;
			
			_moneyField.htmlText = '<span class="text"><b>Баланс:</b></span> <span class="gray">реалов</span> <span class="graybold">' + _realBalance + '</span><span class="gray">, виртуалов</span> <span class="graybold">' + _virtualBalance + '</span>';
		}

		public function set virtualBalance(virtualBalance:String):void {
			_virtualBalance = virtualBalance;
			
			_moneyField.htmlText = '<span class="text"><b>Баланс:</b></span> <span class="gray">реалов</span> <span class="graybold">' + _realBalance + '</span><span class="gray">, виртуалов</span> <span class="graybold">' + _virtualBalance + '</span>';
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------
		
		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}