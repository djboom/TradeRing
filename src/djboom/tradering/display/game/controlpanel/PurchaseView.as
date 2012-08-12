package djboom.tradering.display.game.controlpanel {
	import djboom.tradering.events.GameEvent;
	import flash.events.MouseEvent;
	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.SmartTextField;
	import djboom.display.smart.StylishButton;
	import djboom.tradering.state.Styles;

	import flash.events.Event;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 11.08.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class PurchaseView extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Внедренные данные.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _billLabelFiled:SmartTextField;
		private var _billFiled:SmartTextField;
		
		private var _stockLabelField:SmartTextField;
		private var _stockField:SmartTextField;
		
		private var _buyButton:StylishButton;
		
		private var _sellButton:StylishButton;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function PurchaseView() {
			super();

			_billLabelFiled = new SmartTextField();
			_billLabelFiled.embedFonts = true;
			_billLabelFiled.cssClass = Styles.GAMECONTROL_P;
			_billLabelFiled.smartText = 'У меня на счету';
			_billLabelFiled.move(0, 60);
			addChild(_billLabelFiled);

			_billFiled = new SmartTextField();
			_billFiled.embedFonts = true;
			_billFiled.cssClass = Styles.GAMECONTROL_MONEY;
			_billFiled.smartText = '123 456';
			_billFiled.move(0, 80);
			addChild(_billFiled);

			_stockLabelField = new SmartTextField();
			_stockLabelField.embedFonts = true;
			_stockLabelField.cssClass = Styles.GAMECONTROL_P;
			_stockLabelField.smartText = 'В моих активах';
			_stockLabelField.move(0, 120);
			addChild(_stockLabelField);

			_stockField = new SmartTextField();
			_stockField.embedFonts = true;
			_stockField.cssClass = Styles.GAMECONTROL_MONEY;
			_stockField.smartText = '456 789';
			_stockField.move(0, 140);
			addChild(_stockField);


			_buyButton = new StylishButton('Купить на удачу');
			_buyButton.move(0, 240);
			_buyButton.addEventListener(MouseEvent.CLICK, buyGoodLuckHandler);
			addChild(_buyButton);

			_sellButton = new StylishButton('Продать всё');
			_sellButton.move(0, 280);
			_sellButton.addEventListener(MouseEvent.CLICK, sellAllHandler);
			addChild(_sellButton);
		}

		private function sellAllHandler(event:MouseEvent):void {
			dispatchEvent(new GameEvent(GameEvent.BUY_GOODLUCK));
		}

		private function buyGoodLuckHandler(event:MouseEvent):void {
			dispatchEvent(new GameEvent(GameEvent.SELL_ALL));
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
			return PurchaseView;
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