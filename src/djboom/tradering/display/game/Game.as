package djboom.tradering.display.game {
	import djboom.tradering.state.Actions;
	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.StylishButton;
	import djboom.events.Broadcaster;
	import djboom.tradering.data.GameInfo;
	import djboom.tradering.data.Players;
	import djboom.tradering.display.game.controlpanel.GameControlPanel;
	import djboom.tradering.events.GameEvent;
	import djboom.tradering.events.GameServerClientEvent;

	import com.junkbyte.console.Cc;
	import com.junkbyte.console.KeyBind;

	import flash.events.MouseEvent;
	import flash.geom.Rectangle;



	/**
	 * Текущая игра.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */
	public class Game extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const EXIT:String = "bitmap.game.ExitButton";

		public static const SIZE:Rectangle = new Rectangle(0, 0, 960, 800);

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		// Информация об игре
		private var _gameInfo:GameInfo;

		private static var _gameId:String;



		private var _exitGameHS:StylishButton;

		private var _phaseView:GamePhaseView;
		private var _controlPanel:GameControlPanel;
		private var _infoView:GameInfoView;
		private var _circleView:GameCircleView;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Game(gameInfo:GameInfo = null) {
			super();


			/**
			 * Temp.
			 * 
			 */

			graphics.beginFill(0x00ffff, 0.1);
			graphics.drawRect(0, 0, 960, 800);
			graphics.endFill();




			_gameInfo = gameInfo;

			_gameId = _gameInfo.gameId;

			Players.players = _gameInfo.users;




			// Выход
			_exitGameHS = new StylishButton("Exit game");
			_exitGameHS.move(SIZE.width - _exitGameHS.width, 10);
			_exitGameHS.addEventListener(MouseEvent.CLICK, exitGame);
			addChild(_exitGameHS);
			
			
			_circleView = new GameCircleView();
			addChild(_circleView);


			_infoView = new GameInfoView(_gameInfo);
			_infoView.move(SIZE.width - _infoView.width + 9, 82);
			addChild(_infoView);


			_controlPanel = new GameControlPanel(_gameInfo);
			_controlPanel.move(SIZE.width - _controlPanel.width, 185);
			_controlPanel.addEventListener(GameEvent.BUY_GOODLUCK, buyGoodLuckHandler);
			_controlPanel.addEventListener(GameEvent.SELL_ALL, sellAllHandler);
			addChild(_controlPanel);


			// Фазы игры
			_phaseView = new GamePhaseView(_gameInfo);
			_phaseView.y = 730;
			addChild(_phaseView);


			Broadcaster.addEventListener(GameServerClientEvent.CHANGE_PHASE, changePhaseHandler);
			// Broadcaster.addEventListener(GameServerClientEvent.GAME_OVER, gameOver);

			Cc.bindKey(new KeyBind("1"), function():void {
				changePhase({"phase":1, "timePhase":10, "users":[{"playerId":"983ab3a194647bc526f8f81298979ab8376f9fc0", "playerName":"demo", "stocks":[], "realBalance":false, "virtualBalance":false, "lastActivityTime":1344683177}]});
			});

			Cc.bindKey(new KeyBind("2"), function():void {
				changePhase({"phase":2, "timePhase":10, "users":[{"playerId":"983ab3a194647bc526f8f81298979ab8376f9fc0", "playerName":"demo", "stocks":[], "realBalance":false, "virtualBalance":false, "lastActivityTime":1344683177}, {"playerId":"983ab3a194647bc526f8f81298979ab8376f9fc0", "playerName":"demo", "stocks":[], "realBalance":false, "virtualBalance":false, "lastActivityTime":1344683177}]});
			});

			Cc.bindKey(new KeyBind("3"), function():void {
				changePhase({"phase":3, "timePhase":10, "users":[{"playerId":"983ab3a194647bc526f8f81298979ab8376f9fc0", "playerName":"demo", "stocks":[], "realBalance":false, "virtualBalance":false, "lastActivityTime":1344683177}]});
			});

			Cc.bindKey(new KeyBind("4"), function():void {
				changePhase({"phase":4, "timePhase":10, "users":[{"playerId":"983ab3a194647bc526f8f81298979ab8376f9fc0", "playerName":"demo", "stocks":[], "realBalance":false, "virtualBalance":false, "lastActivityTime":1344683177}]});
			});

			Cc.bindKey(new KeyBind("5"), function():void {
				changePhase({"phase":5, "timePhase":10, "users":[{"playerId":"983ab3a194647bc526f8f81298979ab8376f9fc0", "playerName":"demo", "stocks":[], "realBalance":false, "virtualBalance":false, "lastActivityTime":1344683177}]});
			});
		}




		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		private function changePhase(data:Object):void {
			Players.players = data.users;

			_gameInfo.gamePhase = data.phase;


			_infoView.updatePlayersNumber();
			_phaseView.update(_gameInfo.gamePhase);
			_controlPanel.updateView(_gameInfo.gamePhase);

		}

		// ----------------------------------------------------------------------------
		// Видимые методы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Переопределенные методы.
		// ----------------------------------------------------------------------------

		override public function dispose():void {
			Broadcaster.removeEventListener(GameServerClientEvent.CHANGE_PHASE, changePhaseHandler);


			super.dispose();
		}

		override public function reflect():Class {
			return Game;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		private function changePhaseHandler(event:GameServerClientEvent):void {
			changePhase(event.data);
		}


		private function buyGoodLuckHandler(event:GameEvent):void {
			var e:GameServerClientEvent = new GameServerClientEvent(GameServerClientEvent.SEND_REQUEST);
			e.action = Actions.BUY_GOODLUCK;
			e.data =  {};
//			e.data =  {gameName:event.gameName, nominal:event.nominal, currency:event.currency, auctionEnabled:event.auctionEnabled};
			e.message = 'buyGoodLuckHandler';
			dispatchEvent(e);
		}

		private function sellAllHandler(event:GameEvent):void {
			var e:GameServerClientEvent = new GameServerClientEvent(GameServerClientEvent.SEND_REQUEST);
			e.action = Actions.SELL_ALL_STOCK;
			e.data =  {};
//			e.data =  {gameName:event.gameName, nominal:event.nominal, currency:event.currency, auctionEnabled:event.auctionEnabled};
			e.message = 'sellAllHandler';
			dispatchEvent(e);
		}


		private function exitGame(event:MouseEvent):void {
			var e:GameEvent = new GameEvent(GameEvent.LEAVE_GAME);
			e.gameId = _gameInfo.gameId;
			dispatchEvent(e);
		}


		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		static public function get gameId():String {
			return _gameId;
		}

	}
}