package djboom.tradering.display.simple {
	import djboom.display.smart.HotSpot;
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.SmartTextField;
	import djboom.display.smart.StylishButton;
	import djboom.tradering.events.WindowEvent;
	import djboom.tradering.state.Styles;

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

	public class AlertRequest extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------


		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _back:SmartBitmap;
		private var _hotspot:HotSpot;
		private var _field:SmartTextField;
		private var _yesHS:HotSpot;
		private var _yesButton:StylishButton;
		private var _noButton:StylishButton;

		private var _action:String;
		private var _vars:Object;
		

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function AlertRequest(message:String, action:String, vars:Object) {
			super();
			
			_action = action;
			_vars = vars;

			graphics.beginFill(0xff0000, 0.2);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();

			_field = new SmartTextField();
			_field.multiline = true;
			_field.wordWrap = true;
			_field.width = 100;
			_field.embedFonts = true;
			_field.cssClass = Styles.GAMECONTROL_P;
			_field.smartText = message;
			addChild(_field);


			_yesButton = new StylishButton('Да');
			_yesButton.move(0, _field.textHeight);
			_yesButton.addEventListener(MouseEvent.CLICK, yesHandler);
			addChild(_yesButton);
			
			_noButton = new StylishButton('Нет');
			_noButton.move(_yesButton.width + 10, _field.textHeight);
			_noButton.addEventListener(MouseEvent.CLICK, noHandler);
			addChild(_noButton);


		}

		private function yesHandler(event:MouseEvent):void {
			dispatchEvent(new WindowEvent(WindowEvent.CLICK_YES));
		}

		private function noHandler(event:MouseEvent):void {
			dispatchEvent(new WindowEvent(WindowEvent.CLICK_NO));
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

		public function get action():String {
			return _action;
		}

		public function get vars():Object {
			return _vars;
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