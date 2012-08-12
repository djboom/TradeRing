/**
 * Общение с сервером.
 * <br>
 * 
 * @author DJ BooM 
 * @since 15.06.2012
 * 
 * Copyright (c) 2011, DJ BooM
 * 
 */

package djboom.tradering.server {

	import adobe.serialization.json.JSON;
	import adobe.serialization.json.JSONParseError;

	import djboom.events.RemovableEventDispatcher;
	import djboom.tradering.Application;
	import djboom.tradering.events.GameServerClientEvent;
	import djboom.tradering.state.Actions;
	import djboom.tradering.state.ServerPath;
	import djboom.tradering.utils.Log;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	// ----------------------------------------------------------------------------
	// События класса.
	// ----------------------------------------------------------------------------

	[Event(name="completeEvent", type="djboom.tradering.events.GameServerClientEvent")]
	[Event(name="errorEvent", type="djboom.tradering.events.GameServerClientEvent")]

	// ----------------------------------------------------------------------------
	// Объявление класса.
	// ----------------------------------------------------------------------------

	public class GSClient extends RemovableEventDispatcher {

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		protected var _variables:URLVariables = new URLVariables();

		protected var _request:URLRequest = new URLRequest();

		protected var _loader:URLStream = new URLStream();

		protected var _action:String;

		protected var _vars:Object;

		protected var _ba:ByteArray = new ByteArray();

		protected var _data:Object;

		protected var _jsonErrorMessage:String;

		protected static var _requestCounter:int = 0;
		protected static var _requestLonPullingCounter:int = 0;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GSClient() {
			super();

			_variables.sessionId = Application.sessionID;

			_request.url = ServerPath.gameServer + ServerPath.gameServerRequest;
			_request.method = URLRequestMethod.POST;
			_request.data = _variables;

			_loader.addEventListener(Event.COMPLETE, dataComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, dataError);
		}

		// ----------------------------------------------------------------------------
		// Видимые методы класса.
		// ----------------------------------------------------------------------------

		protected function getData():void {
			if (_ba != null) {
				try {
					_data = JSON.decode(_ba.toString());
					_action = _data.action;

					if (_action == null) _action = Actions.NULL;
					if (_data.state == Actions.ERROR) _action = Actions.ERROR;

				} catch(error:JSONParseError) {
					_action = Actions.ERROR_JSON;
					_jsonErrorMessage = error.message;
				}
			} else {
				_action = Actions.NULL;
			}
		}

		protected function parseError():void {
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		protected function dataComplete(event:Event):void {
		}

		protected function dataError(event:IOErrorEvent):void {
			Log.errorMessage("Сервер не доступен");

			dispatchEvent(new GameServerClientEvent(GameServerClientEvent.ERROR));
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public function load():void {
			if (_ba != null) _ba.clear();

			_loader.load(_request);
		}

		public function close():void {
			try {
				_loader.close();
			} catch (error:Error) {

			}

			if (_ba != null) _ba.clear();
		}

		override public function dispose():void {
			_loader.removeEventListener(Event.COMPLETE, dataComplete);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, dataError);

			close();

			_ba = null;
			_data = null;
			_action = null;
			_jsonErrorMessage = null;
			_vars = null;
			_loader = null;
			_variables = null;
			_request = null;

			super.dispose();
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function set vars(vars:Object):void {
			if (vars == null) return;

			_vars = vars;

			for (var key:Object in vars) {
				_variables[key] = vars[key];
			}
		}
	}
}