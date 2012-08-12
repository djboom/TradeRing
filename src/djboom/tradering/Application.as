package djboom.tradering {
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartSprite;
	import djboom.display.smart.SmartTextField;
	import djboom.interfaces.smart.ISmartSprite;
	import djboom.managers.AssetManager;
	import djboom.managers.CursorManager;
	import djboom.styles.SmartCSS;
	import djboom.tradering.data.GameInfo;
	import djboom.tradering.data.PlayerInfo;
	import djboom.tradering.display.creategame.CreateGame;
	import djboom.tradering.display.game.Game;
	import djboom.tradering.display.lobby.Lobby;
	import djboom.tradering.display.simple.Alert;
	import djboom.tradering.display.simple.CirclePreloader;
	import djboom.tradering.display.simple.GameBack;
	import djboom.tradering.events.GameEvent;
	import djboom.tradering.events.GameServerClientEvent;
	import djboom.tradering.events.WindowEvent;
	import djboom.tradering.interfaces.IApplication;
	import djboom.tradering.server.GSPullClient;
	import djboom.tradering.server.GSRequestClient;
	import djboom.tradering.state.Actions;
	import djboom.tradering.state.Channel;
	import djboom.tradering.state.Cursors;
	import djboom.tradering.state.Font;
	import djboom.tradering.state.ServerPath;
	import djboom.tradering.state.Styles;
	import djboom.tradering.utils.Log;
	import djboom.utils.AlignUtil;
	import djboom.utils.StageReference;

	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.interfaces.ISWFLoader;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.ScrollRectPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.junkbyte.console.Cc;

	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Security;
	import flash.text.TextFormat;

	/**
	 * TradeRing.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class Application extends Sprite implements IApplication {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// Версия.
		public static const VERSION:String = "0.0";

		// Сборка.
		public static const BUILD_NUMBER:String = "168";

		private static const WHITE:uint = 0xffffff;

		// ----------------------------------------------------------------------------
		// Встроенные шрифты.
		// ----------------------------------------------------------------------------

		// [Embed(source="../../../assets/fonts/tahoma.ttf", embedAsCFF="false", mimeType="application/x-font", fontName="Tahoma", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		// public var TahomaFont:Class;

		// [Embed(source="../../../assets/fonts/tahomabd.ttf", embedAsCFF="false", mimeType="application/x-font", fontName="Tahoma", fontWeight="bold", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		// public var TahomaBoldFont:Class;

		[Embed(source="../../../assets/fonts/BlissproBold.otf", fontWeight="bold", embedAsCFF="false", mimeType="application/x-font", fontName="BlissPro", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		public var BlissProBoldFont:Class;



		[Embed(source="../../../assets/fonts/Arial.ttf", embedAsCFF="false", mimeType="application/x-font", fontName="Arial", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		public var ArialFont:Class;

		[Embed(source="../../../assets/fonts/ArialBold.ttf", fontWeight="bold", embedAsCFF="false", mimeType="application/x-font", fontName="Arial", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		public var ArialBoldFont:Class;



		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------


		private static var _sessionId:String;


		private static var _playerId:String;


		// Лобби
		// private var _lobby:Lobby;

		// Ширина сцены
		private var _stageW:int;

		// Высота сцены
		private var _stageH:int;

		// Размеры сцены
		private var _stageRect:Rectangle;

		// Слой блокирующий события мышки
		private var _lockLayer:ISmartSprite;

		// Лонг-пуллинг клиент
		private var _poolClient:GSPullClient;

		// Клиент для обращения к игровому серверу для быстрых запросов
		private var _client:GSRequestClient;

		private var _requestField:SmartTextField;

		private static var _myPlayerInfo:PlayerInfo;
		private var _lobby:Lobby;
		private var _createGame:CreateGame;
		private var _alert:Alert;
		private var _game:Game;
		private var _back:GameBack;


		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Application() {
			super();

			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		/**
		 * Init.
		 * 
		 */

		private function initGame():void {
			// Настройки сцены.
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			StageReference.setStage(stage);

			// Setup console.
			/**/
			Cc.startOnStage(this, "`");
			Cc.commandLine = true;
			Cc.config.commandLineAllowed = true;
			Cc.config.showTimestamp = true;
			Cc.config.showLineNumber = true;
			Cc.config.maxLines = 0;
			Cc.width = stage.stageWidth;
			Cc.height = 400;
			Cc.y = stage.stageHeight - Cc.height;
			Cc.config.style.styleSheet.setStyle("blue", {color:'#00c6ff', fontWeight:'bold', display:'inline'});
			Cc.config.style.styleSheet.setStyle("current", {color:'#b4ff00', display:'inline'});
			Cc.config.style.styleSheet.setStyle("video", {color:'#e60098', display:'inline'});
			Cc.config.style.styleSheet.setStyle("white", {color:'#ffffff', display:'inline'});
			Cc.config.style.styleSheet.setStyle(Channel.GAME_SERVER_STYLE, {color:'#00ffba', display:'inline'});
			Cc.config.style.styleSheet.setStyle(Channel.REQUEST_STYLE, {color:'#8080ff', display:'inline'});


			Cc.addSlashCommand("sessionId", function():void {
				Cc.addHTMLch("current", 2, this, "<current><b>_sessionID</b></current>:", "<current>" + _sessionId + "</current>");
			}, "показывает sessionId");

			Cc.addSlashCommand("playerId", function():void {
				Cc.addHTMLch("current", 2, this, "<current><b>_playerID</b></current>:", "<current>" + _playerId + "</current>");
			}, "показывает sessionId");


			Cc.info("Версия " + VERSION + " (сборка " + BUILD_NUMBER + ")");

			// Cc.visible = true;

			Cc.addHTMLch("current", 1, "<current>Security.sandboxType:</current>", Security.sandboxType);

			/**/

			Log.message("Проверка доступности сервера", this);

			// Стили.
			Styles.init();
			SmartCSS.css = Styles.css;


			// Плагины
			TweenPlugin.activate([GlowFilterPlugin]);
			TweenPlugin.activate([ScrollRectPlugin]);
			TweenPlugin.activate([ColorTransformPlugin]);
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenPlugin.activate([BlurFilterPlugin]);



			// Курсоры
			CursorManager.init(stage);
			CursorManager.register(Cursors.TARGET, new SmartBitmap(AssetManager.getBitmapData(Cursors.TARGET, false), PixelSnapping.AUTO, true));
			CursorManager.register(Cursors.REQUEST, new CirclePreloader());


			// Фон.
			createBack();


			getUserBalance();


			// Ресайз сцены.
			resizeStage();

			stage.addEventListener(Event.RESIZE, resizeStage);
		}

		/**
		 * Cоздание фона.
		 * 
		 */

		private function createBack():void {
			_back = new GameBack();
			addChild(_back);
		}


		/**
		 * Запрос баланса.
		 * 
		 */

		private function getUserBalance():void {
			showWaitRequest("Запрос баланса");

			_client = new GSRequestClient();
			_client.action = Actions.GET_USER_BALANCE;
			_client.sandbox = this;
			_client.addEventListener(GameServerClientEvent.COMPLETE, balanceComplete);
			_client.addEventListener(GameServerClientEvent.ERROR, gsClientError);
			_client.load();
		}


		/**
		 * Успешный запрос баланса.
		 * 
		 */

		private function balanceComplete(event:GameServerClientEvent):void {
			closeWaitRequest();
			destroyClient();


			Cc.inspect(event.data);

			_myPlayerInfo = new PlayerInfo(event.data);

			if (_lobby == null) {
				setupGame();
			}

			if (_lobby != null) {
				// _lobby.realBalance = Application.myPlayerInfo.realBalance;
				// _lobby.virtualBalance = Application.myPlayerInfo.virtualBalance;
			}
		}


		/**
		 * Неуспешный запрос на сервер.
		 * 
		 */

		private function gsClientError(event:GameServerClientEvent):void {
			closeWaitRequest();
			destroyClient();
		}

		/**
		 * �?нициализация лобби и лонг-пуллинга.
		 * 
		 */

		private function setupGame():void {
			/**
			 * Проверяем выбран ли у нас способ высказывания,
			 * если нет то выводим форму с выбором способа высказывания.
			 * 
			 */

			createLobby();

			_poolClient = new GSPullClient();
			_poolClient.load();

			// Ресайз сцены.
			resizeStage();
		}


		/**
		 * Создание комнаты ожидания игр.
		 * 
		 */

		private function createLobby():void {
			if (_lobby == null) {
				_lobby = new Lobby();
				_lobby.addEventListener(GameEvent.CREATE, createGame);
				_lobby.addEventListener(GameEvent.JOIN, joinGameRequest);
			}

			addChild(_lobby);

			TweenMax.fromTo(_lobby, 0.3, {autoAlpha:0}, {autoAlpha:1});

			resizeStage();
		}


		/**
		 * Создание новой игры.
		 * 
		 */

		private function createGame(event:GameEvent):void {
			showLockLayer();

			_createGame = new CreateGame();
			_createGame.addEventListener(GameEvent.CREATE, createGameRequest);
			_createGame.addEventListener(Event.CLOSE, closeCreateGame);
			addChild(_createGame);

			TweenLite.from(_createGame, 0.3, {alpha:0});

			resizeStage();
		}

		private function createGameRequest(event:GameEvent):void {
			// var flag:Boolean = false;

			// if ((event.currency == Currency.REAL && Number(Application.myPlayerInfo.realBalance) < Number(event.nominal)) || (event.currency == Currency.VIRTUAL && Number(Application.myPlayerInfo.virtualBalance) < Number(event.nominal))) flag = true;

			// if (flag) {
			// createAlertMessage("Недостаточно средств");
			// } else {

			showWaitRequest();

			_client = new GSRequestClient();
			_client.action = Actions.CREATE_GAME;
			_client.sandbox = this;
			_client.vars = {gameName:event.gameName, nominal:event.nominal, currency:event.currency, auctionEnabled:event.auctionEnabled};
			_client.addEventListener(GameServerClientEvent.COMPLETE, createGameComplete);
			_client.addEventListener(GameServerClientEvent.ERROR, createGameError);
			_client.load();

			// }
		}

		private function createGameComplete(event:GameServerClientEvent):void {
			Cc.addHTMLch("systrace", 1, this, "<blue>функция createGameComplete(</blue>event<blue>)</blue>");

			closeWaitRequest();

			if (_poolClient != null) {
				_poolClient.dispose();
				_poolClient = null;
			}

			closeCreateGame();

			Cc.addHTMLch("current", 1, "<current>event.action:</current>", event.action);
			Cc.addHTMLch("current", 1, "<current>event.data:</current>", event.data);

			if (event.action == Actions.CREATE_GAME) {

				var gameInfo:GameInfo = new GameInfo(event.data);
				Cc.addHTMLch("current", 1, "<current>gameInfo.gameId:</current>", gameInfo.gameId);

				// createWaitGame(event.data, event.data.creatorId);

				// join to created game

				_lobby.visible = false;


				// Players.players = event.players;

				_game = new Game(gameInfo);
				// _game = new Game(event.gameInfo);
				// _game.setPhaseData("1");
				// _game.addEventListener(GameEvent.GAME_OVER, gameOver);
				_game.addEventListener(GameEvent.LEAVE_GAME, leaveGame);
				// _game.addEventListener(GameEvent.SHOW_READY_WINDOW, showReadyWindow);
				// _game.addEventListener(GameEvent.REMOVE_READY_WINDOW, removeReadyWindow);
				addChild(_game);

				resizeStage();

				Cc.addHTMLch("current", 1, "<current>event.data.gameId:</current>", event.data.gameId);


				_poolClient = new GSPullClient();
				_poolClient.vars = {gameId:event.data.gameId};
				_poolClient.load();
			}
		}


		private function createGameError(event:GameServerClientEvent):void {
			Cc.addHTMLch("systrace", 1, this, "<blue>функция createGameError(</blue>event<blue>)</blue>");

			closeWaitRequest();
		}

		private function closeCreateGame(event:Event = null):void {
			if (_createGame != null) {
				_createGame.dispose();
				_createGame = null;
			}

			hideLockLayer();
		}

		private function leaveGame(event:GameEvent):void {
			if (_game != null) {
				_game.dispose();
				_game = null;
			}


			Cc.addHTMLch("current", 1, "<current>Game.gameId:</current>", Game.gameId);
			Cc.addHTMLch("current", 1, "<current>event.gameId:</current>", event.gameId);

			showWaitRequest();

			_client = new GSRequestClient();
			_client.action = Actions.LEAVE_GAME;
			_client.sandbox = this;
			_client.vars = {gameId:event.gameId};
			_client.addEventListener(GameServerClientEvent.COMPLETE, leaveGameComplete);
			_client.addEventListener(GameServerClientEvent.ERROR, leaveGameError);
			_client.load();


		}

		private function leaveGameComplete(event:GameServerClientEvent):void {
			closeWaitRequest();

			getUserBalance();

			AssetManager.removeAll();

			destroyPoolClient();

			_poolClient = new GSPullClient();
			_poolClient.load();

			createLobby();
		}

		private function leaveGameError(event:GameServerClientEvent):void {
			closeWaitRequest();
		}


		/**
		 * Запрос на сервер: присоединение к игре.
		 *  
		 */

		private function joinGameRequest(event:GameEvent):void {
			// var flag:Boolean = false;

			// if ((event.currency == Currency.REAL && Number(Application.myPlayerInfo.realBalance) < Number(event.nominal)) || (event.currency == Currency.VIRTUAL && Number(Application.myPlayerInfo.virtualBalance) < Number(event.nominal))) flag = true;

			// if (flag) {
			// createAlertMessage("Недостаточно средств");
			// } else {
			showWaitRequest();

			_client = new GSRequestClient();
			_client.action = Actions.JOIN_GAME;
			_client.sandbox = this;
			_client.vars = {gameId:event.gameId};
			_client.addEventListener(GameServerClientEvent.COMPLETE, joinGameComplete);
			_client.addEventListener(GameServerClientEvent.ERROR, joinGameError);
			_client.load();
			// }
		}


		private function joinGameComplete(event:GameServerClientEvent):void {
			closeWaitRequest();
			destroyClient();


			if (_poolClient != null) {
				_poolClient.dispose();
				_poolClient = null;
			}

			closeCreateGame();

			Cc.addHTMLch("current", 1, "<current>event.action:</current>", event.action);

			if (event.action == Actions.JOIN_GAME) {

				var gameInfo:GameInfo = new GameInfo(event.data);
				Cc.addHTMLch("current", 1, "<current>gameInfo.gameId:</current>", gameInfo.gameId);

				// createWaitGame(event.data, event.data.creatorId);

				// join to created game

				_lobby.visible = false;

				// Players.players = event.players;

				_game = new Game(gameInfo);
				// _game = new Game(event.gameInfo);
				// _game.setPhaseData("1");
				// _game.addEventListener(GameEvent.GAME_OVER, gameOver);
				_game.addEventListener(GameEvent.LEAVE_GAME, leaveGame);
				// _game.addEventListener(GameEvent.SHOW_READY_WINDOW, showReadyWindow);
				// _game.addEventListener(GameEvent.REMOVE_READY_WINDOW, removeReadyWindow);
				addChild(_game);

				resizeStage();

				Cc.addHTMLch("current", 1, "<current>event.data.gameId:</current>", event.data.gameId);


				_poolClient = new GSPullClient();
				_poolClient.vars = {gameId:event.data.gameId};
				_poolClient.load();
			}
		}

		private function joinGameError(event:GameServerClientEvent):void {
			closeWaitRequest();
			destroyClient();

			Cc.addHTMLch("systrace", 1, this, "<blue>функция joinGameError(</blue>event<blue>)</blue>");
		}


		/**
		 * Окно предупреждения.
		 * 
		 */

		private function createAlertMessage(message:String):void {
			showLockLayer();

			_alert = new Alert(message);
			_alert.addEventListener(WindowEvent.CLICK_YES, closeAlert);
			addChild(_alert);

			AlignUtil.alignMiddleCenter(_alert, _stageRect);
		}

		private function closeAlert(event:WindowEvent):void {
			if (_alert != null) {
				_alert.dispose();
				_alert = null;
			}

			hideLockLayer();
		}







		// ----------------------------------------------------------------------------
		// Переопределенные методы.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		private function added(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);

			initGame();
		}


		/**
		 * Обработка события: изменения размеров сцены.
		 * 
		 */

		private function resizeStage(event:Event = null):void {
			_stageW = stage.stageWidth;
			_stageH = stage.stageHeight;

			_stageRect = new Rectangle(0, 0, _stageW, _stageH);

			if (_lockLayer != null) {
				_lockLayer.width = _stageW;
				_lockLayer.height = _stageH;
			}

			if (_requestField != null) {
				AlignUtil.alignMiddleCenter(_requestField, _stageRect);
			}

			if (_lobby != null) {
				AlignUtil.alignMiddleCenter(_lobby, _stageRect);
			}

			if (_createGame != null) {
				AlignUtil.alignMiddleCenter(_createGame, _stageRect);
			}

			if (_back != null) {
				_back.resize(_stageRect);

				AlignUtil.alignTopCenter(_back, _stageRect);
			}

			if (_game != null) {
				_game.move((_stageW - Game.SIZE.width) * 0.5, 0);
			}
		}




		/**
		 * Показываем окно запроса на сервер.
		 * 
		 */

		private function showWaitRequest(message:String = "Неизвестный запрос"):void {
			Cc.addHTMLch("current", 2, this, "<current><b>showWaitRequest</b></current>");

			showLockLayer();

			if (_requestField == null) {
				_requestField = new SmartTextField(false);
				_requestField.defaultTextFormat = new TextFormat(Font.FONT_SANS, 11, WHITE);
			}

			addChild(_requestField);

			TweenLite.to(_requestField, 0.3, {autoAlpha:1});

			_requestField.text = message;

			resizeStage();

			CursorManager.push(Cursors.REQUEST);
		}


		/**
		 * Скрываем окно запроса на сервер.
		 * 
		 */


		private function closeWaitRequest():void {
			Cc.addHTMLch("current", 2, this, "<current><b>closeWaitRequest</b></current>");

			hideLockLayer();

			CursorManager.pop(Cursors.REQUEST);
		}

		/**
		 * Показываем блокирующий слой.
		 * 
		 */

		private function showLockLayer():void {
			if (_lockLayer == null) {
				_lockLayer = new SmartSprite();
				_lockLayer.graphics.beginFill(0, 0.7);
				_lockLayer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				_lockLayer.graphics.endFill();
				_lockLayer.alpha = 0;
				_lockLayer.addEventListener(MouseEvent.CLICK, clickLockLayer);
				_lockLayer.buttonMode = false;
				_lockLayer.useHandCursor = false;
			}

			addChild(DisplayObject(_lockLayer));

			TweenLite.to(_lockLayer, 0.3, {autoAlpha:1});


		}

		private function clickLockLayer(event:MouseEvent):void {
		}


		/**
		 * Скрываем блокирующий слой.
		 * 
		 */

		private function hideLockLayer():void {
			// if (_createGame == null) {
			TweenLite.to(_lockLayer, 0.2, {autoAlpha:0});

			TweenLite.to(_requestField, 0.2, {autoAlpha:0});
			// } else {
			// addChild(_createGame);
			// }
		}


		/**
		 * Удаляем серверного клиента.
		 * 
		 */

		private function destroyClient():void {
			if (_client != null) {
				_client.dispose();
				_client = null;
			}
		}


		/**
		 * Удаляем pull-клиента.
		 * 
		 */

		private function destroyPoolClient():void {
			if (_poolClient != null) {
				_poolClient.dispose();
				_poolClient = null;
			}
		}



		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		static public function get sessionID():String {
			return _sessionId;
		}

		public function set sessionID(value:String):void {
			_sessionId = value;

			if (Security.sandboxType == Security.LOCAL_TRUSTED) {
				_sessionId = 'dfa0218d1f5a455b3c71983c68304517';
			}
		}

		static public function get playerId():String {
			return _playerId;
		}

		public function set playerId(value:String):void {
			_playerId = value;

			if (Security.sandboxType == Security.LOCAL_TRUSTED) {
				_playerId = '2b8337b1230ef15f5b4cba97832f4ec0b0c8ab56';
			}
		}



		public function set gameServerPath(value:String):void {
			ServerPath.gameServer = value;
		}

		public function set gameServerRequest(value:String):void {
			ServerPath.gameServerRequest = value;
		}



		public function set assets(value:ISWFLoader):void {
			AssetManager.init(value);
		}

		static public function get myPlayerInfo():PlayerInfo {
			return _myPlayerInfo;
		}

	}
}
