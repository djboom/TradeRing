package djboom.tradering.display.game.controlpanel {
	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.SmartTextField;
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

	public class PercentView extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Внедренные данные.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _titleField:SmartTextField;
		private var _descriptionField:SmartTextField;
		private var _counter:SmartCounter;
		
		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function PercentView() {
			super();

			_titleField = new SmartTextField();
			_titleField.embedFonts = true;
			_titleField.multiline = true;
			_titleField.wordWrap = true;
			_titleField.width = GameControlPanel.WIDTH - 30;
			_titleField.cssClass = Styles.GAMECONTROL_H2;
			_titleField.smartText = 'Определение процента проигрыша доноров';
			addChild(_titleField);


			_descriptionField = new SmartTextField();
			_descriptionField.embedFonts = true;
			_descriptionField.multiline = true;
			_descriptionField.wordWrap = true;
			_descriptionField.width = GameControlPanel.WIDTH - 30;
			_descriptionField.cssClass = Styles.GAMECONTROL_P;
			_descriptionField.smartText = 'Определение процента проигрыша доноров';
			_descriptionField.move(0, _titleField.textHeight + 5);
			addChild(_descriptionField);
			
			
			_counter = new SmartCounter(15);
			_counter.move(x, _descriptionField.y + _descriptionField.textHeight + 20);
			_counter.start();
			addChild(_counter);
			
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
			return PercentView;
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