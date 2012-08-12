package djboom.tradering.loaders {
	import djboom.tradering.interfaces.IApplication;
	import djboom.tradering.managers.FlashVarsManager;

	import com.greensock.TweenNano;
	import com.greensock.events.LoaderEvent;
	import com.greensock.interfaces.ILoaderMax;
	import com.greensock.interfaces.ISWFLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	/**
	 * Загрузчик приложения.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	[SWF(backgroundColor="#04091a", frameRate="30", width="1100", height="850")]

	public class SmartLoader extends Sprite {

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _bar:LoadingBar;

		private var _vars:FlashVarsManager;

		private var _queue:ILoaderMax;
		private var _applicationLoader:ISWFLoader;
		private var _assetsLoader:ISWFLoader;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function SmartLoader() {
			addEventListener(Event.ADDED_TO_STAGE, initLoader);
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		private function destroyPreloader():void {
			_bar.visible = false;
			removeChild(_bar);
			_bar = null;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		private function initLoader(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, initLoader);

			// Настройки сцены.
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			// Настройка контекстного меню.
			var developerCMenu:ContextMenu = new ContextMenu();
			developerCMenu.hideBuiltInItems();
			contextMenu = developerCMenu;

			var item:ContextMenuItem = new ContextMenuItem("Разработка: РосБизнесДизайн");
			developerCMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, developerSite);


			_bar = new LoadingBar();
			addChild(_bar);

			_bar.x = (stage.stageWidth - _bar.width) * 0.5;
			_bar.y = (stage.stageHeight - _bar.height) * 0.5;

			TweenNano.from(_bar, 1, {alpha:0});

			_vars = new FlashVarsManager(stage.loaderInfo.parameters);

			_applicationLoader = new SWFLoader(_vars.application);
			_assetsLoader = new SWFLoader(_vars.assets);

			_queue = new LoaderMax();
			_queue.append(_applicationLoader);
			_queue.append(_assetsLoader);
			_queue.addEventListener(LoaderEvent.PROGRESS, loaderProgress);
			_queue.addEventListener(LoaderEvent.COMPLETE, loaderComplete);
			_queue.load();
		}

		private function loaderProgress(event:LoaderEvent):void {
			_bar.progress(_queue.progress);
		}

		private function loaderComplete(event:LoaderEvent):void {
			var application:IApplication = IApplication(_applicationLoader.loader.content);

			if (application != null) {
				application.assets = _assetsLoader;
				application.sessionID = _vars.sessionID;				
				application.playerId = _vars.playerId;
				application.gameServerPath = _vars.gameServerPath;
				application.gameServerRequest = _vars.gameServerRequest;

				addChild(DisplayObject(application));

				TweenNano.from(application, 0.4, {alpha:0});
			}

			_assetsLoader.destroyStream();

			_queue.destroy();
			_queue = null;

			_vars = null;


			TweenNano.to(_bar, 0.4, {alpha:0, onComplete:destroyPreloader});
		}

		/**
		 * Переход на сайт разработчика.
		 * 
		 */

		private function developerSite(event:ContextMenuEvent):void {
			navigateToURL(new URLRequest("http://rosbd.com/"), "_blank");
		}

	}
}
