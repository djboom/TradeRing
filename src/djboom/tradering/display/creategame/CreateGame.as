package djboom.tradering.display.creategame {
	import djboom.display.smart.SmartShape;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.display.smart.SmartTextField;
	import djboom.display.smart.StylishButton;
	import djboom.interfaces.smart.ISmartShape;
	import djboom.interfaces.smart.ISmartTextField;
	import djboom.tradering.display.simple.Select;
	import djboom.tradering.events.GameEvent;
	import djboom.tradering.events.SelectEvent;
	import djboom.tradering.state.Currency;
	import djboom.tradering.state.Status;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;

	/**
	 * Создание игры.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class CreateGame extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const TEXT_INPUT_GAME_TITLE:String = "Введите название игры";
		private static const TEXT_INPUT_NOMINAL_SHARE:String = "1000";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		// Фон
		private var _back:ISmartShape;

		// Название игры
		private var _titleInput:ISmartTextField;
		private var _nominalShareInput:SmartTextField;
		private var _auctionField:SmartTextField;

		private var _currencySelect:Select;
		private var _auctionSelect:Select;

		private var _currency:String;
		private var _auction:String;

		private var _createButton:StylishButton;
		private var _closeButton:StylishButton;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function CreateGame() {
			super();

			_back = new SmartShape();
			_back.graphics.beginFill(0xffffff, 1);
			_back.graphics.drawRect(0, 0, 200, 240);
			_back.graphics.endFill();
			addChild(DisplayObject(_back));

			// Название игры
			_titleInput = new SmartTextField(false);
			_titleInput.mouseEnabled = true;
			_titleInput.selectable = true;
			_titleInput.type = TextFieldType.INPUT;
			_titleInput.text = TEXT_INPUT_GAME_TITLE;
			_titleInput.move(20, 10);
			_titleInput.addEventListener(FocusEvent.FOCUS_IN, focusInput);
			_titleInput.addEventListener(FocusEvent.FOCUS_OUT, focusOutInput);
			addChild(DisplayObject(_titleInput));


			// Номинал акции
			_nominalShareInput = new SmartTextField(false);
			_nominalShareInput.mouseEnabled = true;
			_nominalShareInput.selectable = true;
			_nominalShareInput.type = TextFieldType.INPUT;
			_nominalShareInput.text = TEXT_INPUT_NOMINAL_SHARE;
			_nominalShareInput.move(20, 40);
			_nominalShareInput.addEventListener(FocusEvent.FOCUS_IN, focusInput);
			_nominalShareInput.addEventListener(FocusEvent.FOCUS_OUT, focusOutInput);
			addChild(DisplayObject(_nominalShareInput));


			// Выбор валюты
			_currencySelect = new Select();
			_currencySelect.addEventListener(SelectEvent.SELECT, selectCurrency);
			_currencySelect.addItem({label:"Реалы", data:Currency.GOLDEN});
			_currencySelect.addItem({label:"Виртуалы", data:Currency.VIRTUAL});
			_currencySelect.move(10, 60);
			addChild(_currencySelect);

			// С аукцином?
			_auctionField = new SmartTextField(false);
			_auctionField.text = "С аукционом?";
			_auctionField.move(20, 120);
			addChild(_auctionField);


			_auctionSelect = new Select();
			_auctionSelect.addEventListener(SelectEvent.SELECT, selectAuction);
			_auctionSelect.addItem({label:"Да", data:Status.YES});
			_auctionSelect.addItem({label:"Нет", data:Status.NO});
			_auctionSelect.move(10, 130);
			addChild(_auctionSelect);



			_createButton = new StylishButton("Создать", StylishButton.BLUE);
			_createButton.addEventListener(MouseEvent.CLICK, createGame);
			_createButton.move(20, 190);
			addChild(_createButton);

			_closeButton = new StylishButton("Закрыть", StylishButton.RED);
			_closeButton.addEventListener(MouseEvent.CLICK, closeForm);
			_closeButton.move(110, 190);
			addChild(_closeButton);

			addChild(_auctionSelect);
			addChild(_currencySelect);
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


		override public function dispose():void {
			if (_back != null) {
				_back.dispose();
				_back = null;
			}

			if (_titleInput != null) {
				_titleInput.dispose();
				_titleInput = null;
			}


			if (_currencySelect != null) {
				_currencySelect.dispose();
				_currencySelect = null;
			}

			if (_createButton != null) {
				_createButton.dispose();
				_createButton = null;
			}

			if (_closeButton != null) {
				_closeButton.dispose();
				_closeButton = null;
			}

			super.dispose();
		}


		override public function reflect():Class {
			return CreateGame;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		private function focusInput(event:FocusEvent):void {
			var input:SmartTextField = event.currentTarget as SmartTextField;


			input.text = "";
		}

		private function focusOutInput(event:FocusEvent):void {
			var input:SmartTextField = event.currentTarget as SmartTextField;

			var text:String;

			switch(input) {
				case _titleInput:
					text = TEXT_INPUT_GAME_TITLE;

					break;

				case _nominalShareInput:
					text = TEXT_INPUT_NOMINAL_SHARE;

					break;
			}

			if (input.text == "") input.text = text;

		}

		private function createGame(event:MouseEvent):void {
			var e:GameEvent = new GameEvent(GameEvent.CREATE);
			e.gameName = _titleInput.text;
			e.nominal = _nominalShareInput.text;
			e.currency = _currency;
			e.auctionEnabled = _auction;
			dispatchEvent(e);
		}

		private function closeForm(event:MouseEvent):void {
			dispatchEvent(new Event(Event.CLOSE));
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------


		private function selectCurrency(event:SelectEvent):void {
			_currency = event.data;
		}

		private function selectAuction(event:SelectEvent):void {
			_auction = event.data;
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}