package djboom.tradering.display.simple {
	import djboom.display.smart.HotSpot;
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.display.smart.SmartTextField;
	import djboom.tradering.events.WindowEvent;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 25.01.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class Alert extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const BACK:String = "bitmap.alert.Back";
		private static const OK:String = "bitmap.alert.Ok";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _back:SmartBitmap;
		private var _hotspot:HotSpot;
		private var _field:SmartTextField;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Alert(message:String) {
			super();

			_back = new SmartBitmap(getBitmap(BACK));
			addChild(_back);

			_field = new SmartTextField();
			_field.embedFonts = true;
			_field.htmlText = '<span class="alert">' + message + '</span>';
			_field.move((_back.width - _field.textWidth) * 0.5 - 5, (_back.height - _field.textHeight) * 0.5 - 20);
			addChild(_field);


			_hotspot = new HotSpot();
			_hotspot.drawBitmapByName(OK);
			_hotspot.move(87, 82);
			_hotspot.addEventListener(MouseEvent.CLICK, clickHandler);
			addChild(_hotspot);
		}

		private function clickHandler(event:MouseEvent):void {
			dispatchEvent(new WindowEvent(WindowEvent.CLICK_YES));
		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Видимые методы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Переопределенные методы.
		// ----------------------------------------------------------------------------

		override public function added(event:Event):void {
			super.added(event);
		}

		override public function removed(event:Event):void {
			super.removed(event);
		}

		override public function dispose():void {
			super.dispose();
		}

		override public function reflect():Class {
			return Alert;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------
	
		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}