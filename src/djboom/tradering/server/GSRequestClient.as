package djboom.tradering.server {

	import djboom.functions.getDate;
	import djboom.tradering.events.GameServerClientEvent;
	import djboom.tradering.state.Actions;
	import djboom.tradering.state.Channel;
	import djboom.tradering.utils.Log;

	import com.junkbyte.console.Cc;

	import flash.events.Event;

	public class GSRequestClient extends GSClient {

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _sandbox:*;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GSRequestClient() {
			super();
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		override protected function parseError():void {
			switch(_action) {
				case Actions.ERROR:

					Log.error(_data.data.code, _sandbox);
					Log.errorMessage(_data.data.message, _sandbox);

					break;

				case Actions.ERROR_JSON:

					Log.errorMessage(_jsonErrorMessage, _sandbox);

					break;

				case Actions.NULL:

					Log.error(Log.ACTION_NULL, _sandbox);

					break;
			}
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		override protected function dataComplete(event:Event):void {
			super.dataComplete(event);

			_loader.readBytes(_ba);

			getData();
			parseError();


			Cc.info('');
			Cc.addHTMLch(Channel.GAME_SERVER, 2, '<gameserver>*************  Ответ от сервера ************</gameserver>', this);
			Cc.info('');
			Cc.addHTMLch(Channel.GAME_SERVER, 2, getDate());
			Cc.addHTMLch(Channel.GAME_SERVER, 2, "<white>Вызвано из объекта</white>", _sandbox);
			Cc.addHTMLch(Channel.GAME_SERVER, 2, "<gameserver><b>ACTION:</b></gameserver>", "<gameserver>" + _action + "</gameserver>");
			Cc.addHTMLch(Channel.GAME_SERVER, 2, "<gameserver><b>Ответ от сервера:</b></gameserver>", "<gameserver>" + _ba.toString() + "</gameserver>");
			Cc.info('');
			Cc.info('*******************************************************');
			Cc.info('');


			if (_action != Actions.ERROR && _action != Actions.NULL && _action != Actions.ERROR_JSON) {
				var e:GameServerClientEvent = new GameServerClientEvent(GameServerClientEvent.COMPLETE);
				e.action = _action;
				e.data = _data.data;
				dispatchEvent(e);
			} else {
				dispatchEvent(new GameServerClientEvent(GameServerClientEvent.ERROR));
			}
		}




		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		override public function dispose():void {
			_sandbox = null;

			super.dispose();
		}


		override public function load():void {
			_requestCounter++;

			Cc.info('');
			Cc.addHTMLch(Channel.GAME_SERVER, 2, '<request>*************  Запрос на сервер #' + _requestCounter + ' ************</request>', this);
			Cc.info('');
			Cc.inspectch(Channel.GAME_SERVER, _variables);
			Cc.info('');
			Cc.info('*******************************************************');
			Cc.info('');

			super.load();
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function set action(action:String):void {
			_action = _variables.action = action;
		}

		public function set sandbox(sandbox:*):void {
			_sandbox = sandbox;
		}
	}
}