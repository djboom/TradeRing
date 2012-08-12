package djboom.tradering.display.lobby {
	import djboom.display.smart.ScaleBitmap;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.display.smart.SmartTextField;
	import djboom.interfaces.smart.IScaleBitmap;
	import djboom.interfaces.smart.ISmartTextField;
	import djboom.tradering.display.simple.Arrow;
	import djboom.tradering.events.SortEvent;
	import djboom.utils.DisplayObjectUtil;

	import flash.display.DisplayObject;
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

	public class SortButton extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const BACK:String = "bitmap.lobby.ButtonBack";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _back:IScaleBitmap;

		private var _field:ISmartTextField;

		private var _arrow:Arrow;

		private var _sortField:String;

		private var isDescending:Boolean = true;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function SortButton(text:String, sortField:String) {
			super();

			_sortField = sortField;

			_back = new ScaleBitmap(getBitmap(BACK).clone());
			_back.scale9Grid = new Rectangle(44, 0, 1, 13);
			addChild(DisplayObject(_back));

			_field = new SmartTextField();
			_field.htmlText = '<span class="text">' + text + '</span>';
			_field.move(15, 4);
			addChild(DisplayObject(_field));

			_arrow = new Arrow();
			addChild(_arrow);

			redraw();

			_back.width = _arrow.x + 20;

			graphics.beginFill(0xff0000, 0);
			graphics.drawRect(0, 0, _back.width, 24);
			graphics.endFill();

			addEventListener(MouseEvent.CLICK, clickButton);
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		private function clickButton(event:MouseEvent):void {
			isDescending = !isDescending;

			redraw();

			var e:SortEvent = new SortEvent(SortEvent.SORT);
			e.sortField = _sortField;
			e.sortType = isDescending ? Array.DESCENDING : 0;
			dispatchEvent(e);
		}

		private function redraw():void {
			if (isDescending) {
				_arrow.rotation = 0;
				_arrow.x = int(_field.textWidth) + 30;
				_arrow.y = 10;
			} else {
				_arrow.rotation = 180;
				_arrow.x = int(_field.textWidth) + 38;
				_arrow.y = 15;
			}
		}

		// ----------------------------------------------------------------------------
		// Переопределенные методы.
		// ----------------------------------------------------------------------------


		override public function dispose():void {
			super.dispose();

			if (_back != null) {
				DisplayObjectUtil.dispose(_back);
				_back = null;
			}

			if (_field != null) {
				_field.dispose();
				_field = null;
			}

			if (_arrow != null) {
				_arrow.dispose();
				_arrow = null;
			}
		}

		override public function reflect():Class {
			return SortButton;
		}
	}
}