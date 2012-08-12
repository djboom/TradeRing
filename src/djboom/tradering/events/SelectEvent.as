package djboom.tradering.events {
	import flash.events.Event;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class SelectEvent extends Event {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		 public static const SELECT:String = "select";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _label:String;

		private var _data:*;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function SelectEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		override public function clone():Event {
			var e:SelectEvent = new SelectEvent(this.type, this.bubbles, this.cancelable);
			 e.label = this.label;
			 e.data = this.data;
			return e;
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function get label():String {
			return _label;
		}

		public function set label(label:String):void {
			_label = label;
		}

		public function get data():* {
			return _data;
		}

		public function set data(data:*):void {
			_data = data;
		}
	}
}