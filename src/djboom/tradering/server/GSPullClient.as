package djboom.tradering.server {

	import djboom.events.Broadcaster;
	import djboom.functions.getDate;
	import djboom.tradering.events.GameServerClientEvent;
	import djboom.tradering.state.Actions;
	import djboom.tradering.state.Channel;
	import djboom.tradering.utils.Log;

	import com.junkbyte.console.Cc;

	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class GSPullClient extends GSClient {

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GSPullClient() {
			super();

			_variables.action = Actions.GET_GAME_INFO;
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		override protected function parseError():void {
			switch(_action) {
				case Actions.ERROR:

					Log.error(_data.data.code, this);
					Log.errorMessage(_data.data.message, this);

					break;

				case Actions.ERROR_JSON:

					Log.errorMessage(_jsonErrorMessage, this);

					break;

				case Actions.NULL:

					Log.error(Log.ACTION_NULL, this);

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
			Cc.addHTMLch(Channel.GAME_SERVER, 2, '<gameserver>*************  Long-pulling ответ от сервера ************</gameserver>', this);
			Cc.info('');
			Cc.addHTMLch(Channel.GAME_SERVER, 2, getDate());
			Cc.addHTMLch(Channel.GAME_SERVER, 2, "<gameserver><b>ACTION:</b></gameserver>", "<gameserver>" + _action + "</gameserver>");
			Cc.addHTMLch(Channel.GAME_SERVER, 2, "<gameserver><b>Ответ от сервера:</b></gameserver>", "<gameserver>" + _ba.toString() + "</gameserver>");
			Cc.info('');
			Cc.info('*******************************************************');
			Cc.info('');


			if (_action != Actions.ERROR && _action != Actions.NULL && _action != Actions.ERROR_JSON) {
				if (_action == Actions.GET_GAME_INFO) {

					var data:Object = _data.data;

					for (var key:Object in data) {
						createEvent(data[key].action, data[key].data);
					}
				}

			} else {
				dispatchEvent(new GameServerClientEvent(GameServerClientEvent.ERROR));
			}

			load();
		}

		private function createEvent(action:String, data:Object):void {
			var e:GameServerClientEvent;

			switch(action) {
				case Actions.GET_GAMES:
					e = new GameServerClientEvent(GameServerClientEvent.GET_GAMES);
					e.action = action;
					e.data = data;
					Broadcaster.dispatchEvent(e);

					break;

				 case Actions.CHANGE_PHASE:
				 e = new GameServerClientEvent(GameServerClientEvent.CHANGE_PHASE);
				 e.action = action;
				 e.data = data;
				 Broadcaster.dispatchEvent(e);
				
				 break;

			}
		}

		override protected function dataError(event:IOErrorEvent):void {
			super.dataError(event);

			load();
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		override public function load():void {
			_requestLonPullingCounter++;
			
			Cc.info('');
			Cc.addHTMLch(Channel.GAME_SERVER, 1, '<request>*************  Long-pulling запрос на сервер #' + _requestLonPullingCounter + ' ************</request>', this);
			Cc.info('');
			Cc.inspectch(Channel.GAME_SERVER, _variables);
			Cc.info('');
			Cc.info('*******************************************************');
			Cc.info('');

			super.load();
		}
	}
}