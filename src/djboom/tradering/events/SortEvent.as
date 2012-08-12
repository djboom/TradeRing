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

	public class SortEvent  extends Event {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		public static const SORT:String = "sortEvent";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _sortType:int;
		private var _sortField:String;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function SortEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		override public function clone():Event {
			var e:SortEvent = new SortEvent(this.type, this.bubbles, this.cancelable);
			 e.sortType = this.sortType;
			 e.sortField = this.sortField;
			return e;
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------

		public function get sortType():int {
			return _sortType;
		}

		public function set sortType(sortType:int):void {
			_sortType = sortType;
		}

		public function get sortField():String {
			return _sortField;
		}

		public function set sortField(sortField:String):void {
			_sortField = sortField;
		}

	}
}