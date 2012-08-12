package djboom.tradering.test {


	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartSprite;
	import djboom.display.smart.SmartTextField;
	import djboom.managers.AssetManager;
	import djboom.managers.CursorManager;
	import djboom.styles.SmartCSS;
	import djboom.tradering.data.GameInfo;
	import djboom.tradering.display.creategame.CreateGame;
	import djboom.tradering.display.game.Game;
	import djboom.tradering.display.simple.AlertRequest;
	import djboom.tradering.display.simple.CirclePreloader;
	import djboom.tradering.drawing.DrawingShapes;
	import djboom.tradering.events.GameServerClientEvent;
	import djboom.tradering.events.WindowEvent;
	import djboom.tradering.server.GSPullClient;
	import djboom.tradering.server.GSRequestClient;
	import djboom.tradering.state.Cursors;
	import djboom.tradering.state.Styles;
	import djboom.utils.AlignUtil;
	import djboom.utils.StageReference;

	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.ScrollRectPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.junkbyte.console.Cc;

	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	[SWF(backgroundColor="#0c1733", frameRate="30", width="1100", height="860")]

	public class TestPerfomance extends Sprite {


		// ----------------------------------------------------------------------------
		// РЎРІРѕР№СЃС‚РІР° РєР»Р°СЃСЃР°.
		// ----------------------------------------------------------------------------

		[Embed(source="../../../../assets/fonts/BlissproBold.otf", fontWeight="bold", embedAsCFF="false", mimeType="application/x-font", fontName="BlissPro", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		public var BlissProBoldFont:Class;



		[Embed(source="../../../../assets/fonts/Arial.ttf", embedAsCFF="false", mimeType="application/x-font", fontName="Arial", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		public var ArialFont:Class;

		[Embed(source="../../../../assets/fonts/ArialBold.ttf", fontWeight="bold", embedAsCFF="false", mimeType="application/x-font", fontName="Arial", unicodeRange="U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+0410-U+044F,U+0401,U+2014,U+002D")]
		public var ArialBoldFont:Class;




		private var _assetsLoader:SWFLoader;


		private var _loadQueue:LoaderMax;
		private var _createGame:CreateGame;
		private var _game:Game;
		private var _poolClient:GSPullClient;
		private var _stageW:int;
		private var _stageH:int;
		private var _stageRect:Rectangle;
		private var _lockLayer:SmartSprite;
		private var _requestField:SmartTextField;
		private var _alertRequest:AlertRequest;
		private var _client:GSRequestClient;


		// ----------------------------------------------------------------------------
		// РљРѕРЅСЃС‚СЂСѓРєС‚РѕСЂ.
		// ----------------------------------------------------------------------------

		public function TestPerfomance() {
			super();

			addEventListener(Event.ADDED_TO_STAGE, init);

		}

		private function init(event:Event):void {
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
			Cc.width = stage.stageWidth;
			Cc.height = 400;
			Cc.y = stage.stageHeight - Cc.height;
			Cc.config.tracing = true;
			Cc.fpsMonitor = true;
			Cc.memoryMonitor = true;
			Cc.config.style.styleSheet.setStyle("blue", {color:'#00c6ff', fontWeight:'bold', display:'inline'});
			Cc.config.style.styleSheet.setStyle("current", {color:'#b4ff00', display:'inline'});
			Cc.config.style.styleSheet.setStyle("video", {color:'#e60098', display:'inline'});
			Cc.config.style.styleSheet.setStyle("gameserver", {color:'#00ffba', display:'inline'});
			/**/

			_assetsLoader = new SWFLoader("assets.swf");

			_loadQueue = new LoaderMax();
			_loadQueue.append(_assetsLoader);
			_loadQueue.addEventListener(LoaderEvent.COMPLETE, completeAssets);
			_loadQueue.load();
		}

		private function completeAssets(event:LoaderEvent):void {
			AssetManager.init(_assetsLoader);


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



			var gameInfo:GameInfo = new GameInfo({"gameId":"169fcaa1d764046a280eb2b5aeaf7c5f5688ddfa", "gameName":"\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u043d\u0430\u0437\u0432\u0430\u043d\u0438\u0435 \u0438\u0433\u0440\u044b", "nominal":1000, "currency":1, "auctionEnabled":1, "gameStatus":0, "gamePhase":1, "gamePhaseStart":1344098716, "createdDate":1344098716, "companies":{"1":{"companyId":1, "companyName":"company_1", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[3, 7, 11], "2":[4, 6, 5], "3":[2, 8, 9]}}, "2":{"companyId":2, "companyName":"company_2", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[10, 4, 12], "2":[3, 1, 3], "3":[5, 7, 8]}}, "3":{"companyId":3, "companyName":"company_3", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[2, 12, 11], "2":[4, 7, 8], "3":[9, 6, 1]}}, "4":{"companyId":4, "companyName":"company_4", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[10, 1, 8], "2":[7, 12, 11], "3":[2, 5, 9]}}, "5":{"companyId":5, "companyName":"company_5", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[2, 8, 9], "2":[1, 10, 11], "3":[7, 3, 4]}}, "6":{"companyId":6, "companyName":"company_6", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[3, 7, 9], "2":[6, 8, 10], "3":[2, 5, 11]}}, "7":{"companyId":7, "companyName":"company_7", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[3, 8, 11], "2":[6, 4, 12], "3":[2, 10, 5]}}, "8":{"companyId":8, "companyName":"company_8", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[2, 7, 10], "2":[3, 12, 9], "3":[5, 6, 1]}}, "9":{"companyId":9, "companyName":"company_9", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[8, 1, 4], "2":[2, 7, 5], "3":[3, 6, 10]}}, "10":{"companyId":10, "companyName":"company_10", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[11, 5, 1], "2":[2, 8, 9], "3":[4, 12, 7]}}, "11":{"companyId":11, "companyName":"company_11", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[3, 7, 9], "2":[4, 2, 1], "3":[5, 8, 12]}}, "12":{"companyId":12, "companyName":"company_12", "stockPrice":1000, "stockNum":0, "price":0, "owner":[], "donors":{"1":[9, 10, 2], "2":[3, 8, 4], "3":[6, 7, 11]}}}, "playerIds":["148d62522edcf5a9485ce115ee02654eec21b8b8"], "myPlayerId":"148d62522edcf5a9485ce115ee02654eec21b8b8", "users":[{"playerId":"148d62522edcf5a9485ce115ee02654eec21b8b8", "playerName":false, "stocks":[], "realBalance":false, "virtualBalance":false, "onlineStatus":1, "lastActivityTime":1344098716}]});
			Cc.addHTMLch("current", 1, "<current>gameInfo.gameId:</current>", gameInfo.gameId);

			_stageW = stage.stageWidth;
			_stageH = stage.stageHeight;

			_stageRect = new Rectangle(0, 0, _stageW, _stageH);


			_game = new Game(gameInfo);
			_game.addEventListener(GameServerClientEvent.SEND_REQUEST, showAlertRequest);
			 addChild(_game);

			//			//  establish the fill properties
			// var myFill:GraphicsSolidFill = new GraphicsSolidFill();
			// myFill.color = 0x33CCFF;
			//
			//			//  establish the stroke properties and the fill for the stroke
			// var myStroke:GraphicsStroke = new GraphicsStroke(2);
			// myStroke.fill = new GraphicsSolidFill(0xffffff);
			// myStroke.joints = JointStyle.MITER;
			//
			//			//  establish the path properties
			// var myPath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
			// myPath.commands.push(1, 2, 2, 2, 2);
			// myPath.data.push(10, 10, 10, 100, 100, 100, 100, 10, 10, 10);
			//
			//			//  populate the IGraphicsData Vector array
			// var myDrawing:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
			// myDrawing.push(myFill, myStroke, myPath);
			//			//  render the drawing
			// graphics.drawGraphicsData(myDrawing);

			

			// Ресайз сцены.
			resizeStage();

			stage.addEventListener(Event.RESIZE, resizeStage);

		}



		/**
		 * Обработка события: изменения размеров сцены.
		 * 
		 */

		private function resizeStage(event:Event = null):void {
			_stageW = stage.stageWidth;
			_stageH = stage.stageHeight;

			_stageRect = new Rectangle(0, 0, _stageW, _stageH);

			if (_game != null) {
				AlignUtil.alignTopCenter(_game, _stageRect);
			}

			if (_lockLayer != null) {
				_lockLayer.width = _stageW;
				_lockLayer.height = _stageH;
			}

			if (_alertRequest != null) {
				AlignUtil.alignMiddleCenter(_alertRequest, _stageRect);
			}
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
			if (_lockLayer != null) TweenLite.to(_lockLayer, 0.2, {autoAlpha:0});

			if (_requestField != null) TweenLite.to(_requestField, 0.2, {autoAlpha:0});
			// } else {
			// addChild(_createGame);
			// }
		}



		/**
		 * Посылаем запрос на сервер с предварительным выводом окна предупреждения.
		 * 
		 */

		// Показываем окно
		private function showAlertRequest(event:GameServerClientEvent):void {
			Cc.addHTMLch("systrace", 1, "<blue>функция showAlertRequest(event)</blue>", this);
			Cc.addHTMLch("systrace", 1, "arg:", event);

			showLockLayer();

			if (_alertRequest != null) closeAlertReuqest();

			_alertRequest = new AlertRequest(event.message, event.action, event.data);
			_alertRequest.addEventListener(WindowEvent.CLICK_YES, sendAlertRequest);
			_alertRequest.addEventListener(WindowEvent.CLICK_NO, closeAlertReuqest);
			addChild(_alertRequest);

			resizeStage();
		}

		// Убираем окно
		private function closeAlertReuqest(event:WindowEvent = null):void {
			Cc.addHTMLch("systrace", 1, "<blue>функция closeAlertReuqest(event)</blue>", this);

			if (_alertRequest != null) {
				_alertRequest.dispose();
				_alertRequest = null;
			}

			hideLockLayer();
		}

		// Посылаем запрос
		private function sendAlertRequest(event:WindowEvent):void {
			Cc.addHTMLch("systrace", 1, "<blue>функция sendAlertRequest(event)</blue>", this);
			Cc.addHTMLch("systrace", 1, "arg:", event);

			_client = new GSRequestClient();
			_client.action = _alertRequest.action;
			_client.sandbox = this;
			_client.vars = _alertRequest.vars;
			_client.addEventListener(GameServerClientEvent.COMPLETE, completeAlertRequest);
			_client.addEventListener(GameServerClientEvent.ERROR, errorAlertRequest);
			_client.load();

			closeAlertReuqest();
		}

		// Запрос прошел успешно
		private function completeAlertRequest(event:GameServerClientEvent):void {
			Cc.addHTMLch("systrace", 1, "<blue>функция completeAlertRequest(event)</blue>", this);
			Cc.addHTMLch("systrace", 1, "arg:", event);
		}

		// Запрос прошел не успешно
		private function errorAlertRequest(event:GameServerClientEvent):void {
			Cc.addHTMLch("systrace", 1, "<blue>функция errorAlertRequest(event)</blue>", this);
			Cc.addHTMLch("systrace", 1, "arg:", event);
		}




	}
}