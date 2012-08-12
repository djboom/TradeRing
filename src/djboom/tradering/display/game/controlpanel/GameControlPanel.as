package djboom.tradering.display.game.controlpanel {
	import djboom.tradering.events.GameEvent;
	import djboom.collection.List;

	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import com.greensock.TweenLite;

	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.SmartTextField;
	import djboom.display.smart.StylishButton;
	import djboom.tradering.data.GameInfo;
	import djboom.tradering.state.GamePhase;
	import djboom.tradering.state.Styles;

	import com.junkbyte.console.Cc;

	import flash.events.Event;
	import flash.filters.DropShadowFilter;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 07.08.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class GameControlPanel extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------
		
		public static const WIDTH:int = 240;

		// ----------------------------------------------------------------------------
		// Внедренные данные.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _titleField:SmartTextField;
		private var _bankGameField:SmartTextField;
		private var _billLabelFiled:SmartTextField;
		private var _statButton:StylishButton;
		private var _purchaseView:PurchaseView;
		private var _lotsView:LotsView;
		private var _percentView:PercentView;
		private var _winnersView:WinnersView;

		private var _views:List = new List();
		private var _delay:int;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GameControlPanel(gameInfo:GameInfo) {
			super();

			graphics.beginFill(0x00ffff, 0.2);
			graphics.drawRect(0, 0, WIDTH, 420);
			graphics.endFill();



			_titleField = new SmartTextField();
			_titleField.embedFonts = true;
			_titleField.cssClass = Styles.GAMECONTROL_P;
			_titleField.smartText = 'Банк игры';
			_titleField.filters = [new DropShadowFilter(1, 90, 0x031336, 1, 0, 0)];
			_titleField.move(0, 0);
			addChild(_titleField);

			_bankGameField = new SmartTextField();
			_bankGameField.embedFonts = true;
			_bankGameField.cssClass = Styles.GAMECONTROL_BANK;
			_bankGameField.smartText = '123 456';
			_bankGameField.move(0, 20);
			addChild(_bankGameField);


			_statButton = new StylishButton('Статистика');
			_statButton.move(0, 430);
			addChild(_statButton);


			updateView(gameInfo.gamePhase);




			_billLabelFiled = new SmartTextField();


		}

		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		private function purchasePhase():void {
			if (_purchaseView == null) {
				_purchaseView = new PurchaseView();
				_purchaseView.move(15, 60);
				_purchaseView.alpha = 0;
				_purchaseView.addEventListener(GameEvent.BUY_GOODLUCK, proxyGameEvent);
				_purchaseView.addEventListener(GameEvent.SELL_ALL, proxyGameEvent)
				addChild(_purchaseView);
			} else {
				_views.removeItem(_purchaseView);
			}
			
			animateViews(_purchaseView);

//			_delay = _views.size == 0 ? 0 : 1;
//
//			TweenMax.allTo(_views.collection, 1, {autoAlpha:0, ease:Quad.easeIn});
//			TweenMax.to(_purchaseView, 1, {autoAlpha:1, ease:Quad.easeOut, delay:_delay});
//
//			_views.addItem(_purchaseView);
		}

		private function proxyGameEvent(event:GameEvent):void {
			dispatchEvent(event);
		}

		

		private function lotsPhase():void {
			Cc.addHTMLch("systrace", 1, "<blue>функция lotsPhase()</blue>", this);
			
			if (_lotsView == null) {
				_lotsView = new LotsView();
				_lotsView.move(15, 60);
				_lotsView.alpha = 0;
				addChild(_lotsView);
			} else {
				_views.removeItem(_lotsView);
			}
			
			animateViews(_lotsView);
			
//			_delay = _views.size == 0 ? 0 : 1;
//			
//			
//
//			TweenMax.allTo(_views.collection, 1, {autoAlpha:0, ease:Quad.easeIn});
//			TweenMax.to(_lotsView, 1, {autoAlpha:1, ease:Quad.easeOut, delay:_delay});
//
//			_views.addItem(_lotsView);
		}

		private function percentPhase():void {
			if (_percentView == null) {
				_percentView = new PercentView();
				_percentView.move(15, 60);
				_percentView.alpha = 0;
				addChild(_percentView);
			} else {
				_views.removeItem(_percentView);
				
			}
			
			animateViews(_percentView);
			
//		_delay = _views.size == 0 ? 0 : 1;
//
//			TweenMax.allTo(_views.collection, 1, {autoAlpha:0, ease:Quad.easeIn});
//			TweenMax.to(_percentView, 1, {autoAlpha:1, ease:Quad.easeOut, delay:_delay});
//
//			_views.addItem(_percentView);
		}

		private function winnerPhase():void {
			if (_winnersView == null) {
				_winnersView = new WinnersView();
				_winnersView.move(15, 60);
				_winnersView.alpha = 0;
				addChild(_winnersView);
			} else {
				_views.removeItem(_winnersView);
				
			}
			
			animateViews(_winnersView);
			
			
//			_delay = _views.size == 0 ? 0 : 1;
//
//			TweenMax.allTo(_views.collection, 1, {autoAlpha:0, ease:Quad.easeIn});
//			TweenMax.to(_winnersView, 1, {autoAlpha:1, ease:Quad.easeOut, delay:_delay});
//
//			_views.addItem(_winnersView);
		}
		
		
		private function animateViews(view:SmartContainer):void {
			_delay = _views.size == 0 ? 0 : 1;

			TweenMax.allTo(_views.collection, 0.6, {autoAlpha:0, ease:Quad.easeIn});
			TweenMax.to(view, 1, {autoAlpha:1, ease:Quad.easeOut, delay:_delay});

			_views.addItem(view);
		}



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
			return GameControlPanel;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public function updateView(phase:String):void {
			Cc.addHTMLch("current", 1, "<current>phase:</current>", phase);

			switch(phase) {
				case GamePhase.PURCHASE_AND_SALE:

					purchasePhase();

					break;

				case GamePhase.NUMBER_OF_LOTS:

					lotsPhase();

					break;

				case GamePhase.PERCENTAGE_OF_LOSS:

					percentPhase();

					break;

				case GamePhase.WINNERS_AND_DONNORS:

					winnerPhase();

					break;
			}
		}





		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}