package djboom.tradering.display.game {
	import com.greensock.easing.Quad;

	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartContainer;
	import djboom.managers.AssetManager;
	import djboom.tradering.data.GameInfo;
	import djboom.tradering.state.Bitmaps;
	import djboom.tradering.state.GamePhase;
	import djboom.utils.Validate;

	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.KeyBind;

	import flash.events.Event;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 09.08.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class GamePhaseView extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Внедренные данные.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _back:SmartBitmap;
		private var _activeBitmap:SmartBitmap;
		private var _lastBitmap:SmartBitmap;
		private var _activeTimeline:TimelineMax;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GamePhaseView(gameInfo:GameInfo) {
			super();

			_back = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_PHASE_VIEW));
			_back.move(-8, -8);
			addChild(_back);
			
			update(gameInfo.gamePhase);


			Cc.bindKey(new KeyBind("1"), function():void {
				update("1");
			});

			Cc.bindKey(new KeyBind("2"), function():void {
				update("2");
			});

			Cc.bindKey(new KeyBind("3"), function():void {
				update("3");
			});

			Cc.bindKey(new KeyBind("4"), function():void {
				update("4");
			});

			Cc.bindKey(new KeyBind("5"), function():void {
				update("5");
			});

			Cc.bindKey(new KeyBind("0"), function():void {
				update("0");
			});

			Cc.bindKey(new KeyBind("6"), function():void {
				update("6");
			});
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
			return GamePhaseView;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public function update(phase:String):void {
			// if (phase != "0");

			if (Validate.n(phase) <= 0 || Validate.n(phase) > 5 && _lastBitmap != null) {
				Cc.addHTMLch("systrace", 1, "<blue>функция update(phase)</blue>", this);

				if (_lastBitmap != null) {
					_lastBitmap.dispose();
					_lastBitmap = null;
				}

				return;


			}

			if (_lastBitmap != null) {
				// var lastTimeline:TimelineMax = new TimelineMax({onComplete:lastRemoved, onCompleteParams:[phase]});
				// lastTimeline.append(new TweenLite(_lastBitmap, 0.07, {alpha:0}));
				// lastTimeline.append(new TweenLite(_lastBitmap, 0.06, {alpha:1}));
				// lastTimeline.append(new TweenLite(_lastBitmap, 0.05, {alpha:0}));
				// lastTimeline.append(new TweenLite(_lastBitmap, 0.04, {alpha:1}));
				// lastTimeline.append(new TweenLite(_lastBitmap, 0.03, {alpha:0}));

				// TweenMax.fromTo(_lastBitmap, 0.2, {blurFilter:{blurX:0}}, {x:"20", alpha:0, blurFilter:{blurX:30}, onComplete:lastRemoved, onCompleteParams:[phase]});
				TweenMax.fromTo(_lastBitmap, 0.5, {blurFilter:{blurX:0}}, {x:"20", alpha:0, blurFilter:{blurX:30, ease:Quad.easeIn, onComplete:lastRemoved, onCompleteParams:[_lastBitmap]}});


			}



			var bitmap:SmartBitmap;

			switch(phase) {
				case GamePhase.PURCHASE_AND_SALE:

					bitmap = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_PHASE_VIEW_ITEM + '1'));
					bitmap.move(-35, -35);

					break;

				case GamePhase.NUMBER_OF_LOTS:

					bitmap = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_PHASE_VIEW_ITEM + '2'));
					bitmap.move(138, -35);

					break;

				case GamePhase.PERCENTAGE_OF_LOSS:

					bitmap = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_PHASE_VIEW_ITEM + '3'));
					bitmap.move(340, -35);

					break;

				case GamePhase.WINNERS_AND_DONNORS:

					bitmap = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_PHASE_VIEW_ITEM + '4'));
					bitmap.move(529, -35);

					break;

				case GamePhase.RESULTS:

					bitmap = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_PHASE_VIEW_ITEM + '5'));
					bitmap.move(720, -35);

					break;

			}

			bitmap.alpha = 0;
			bitmap.x -= 20;
			addChild(bitmap);


			// _activeTimeline = new TimelineMax({onComplete:phaseChanged, onCompleteParams:[bitmap]});
			// _activeTimeline.append(new TweenLite(bitmap, 0.2, {alpha:1}));

			TweenMax.fromTo(bitmap, 0.2, {blurFilter:{blurX:30}}, {x:"20", alpha:1, blurFilter:{blurX:0}, onComplete:phaseChanged, onCompleteParams:[bitmap]});




		}


		private function lastRemoved(bitmap:SmartBitmap):void {
			if (bitmap != null) {
				bitmap.dispose();
				bitmap = null;
			}
		}

		private function phaseChanged(bitmap:SmartBitmap):void {
			_lastBitmap = bitmap;



			Cc.addHTMLch("current", 1, "<current>_lastBitmap:</current>", _lastBitmap);
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}