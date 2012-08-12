package djboom.tradering.display.simple {
	import djboom.display.smart.ScaleBitmap;
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartSprite;
	import djboom.managers.AssetManager;
	import djboom.tradering.state.Bitmaps;

	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * Фон игры.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 07.08.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class GameBack extends SmartSprite {

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _bitmap:SmartBitmap;

		private var _leftGradient:ScaleBitmap;
		private var _rightGradient:ScaleBitmap;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GameBack() {
			super();

			_bitmap = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_BACK));
			addChild(_bitmap);
		}

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

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public function resize(stageRect:Rectangle):void {
			if (_bitmap.width < stage.stageWidth) {
				if (_leftGradient == null) {
					_leftGradient = new ScaleBitmap(AssetManager.getBitmapData(Bitmaps.GAME_BACK_REPEAT_LEFT).clone());
					_leftGradient.scale9Grid = new Rectangle(0, 0, 1, 884);
					addChild(_leftGradient);
				}

				if (_rightGradient == null) {
					_rightGradient = new ScaleBitmap(AssetManager.getBitmapData(Bitmaps.GAME_BACK_REPEAT_RIGHT).clone());
					_rightGradient.scale9Grid = new Rectangle(0, 0, 1, 884);
					addChild(_rightGradient);
				}

				var w:Number = (stageRect.width - _bitmap.width) * 0.5;

				_leftGradient.width = w;
				_rightGradient.width = w;

				_leftGradient.x = -_leftGradient.width;
				_rightGradient.x = _bitmap.width;
			}
		}
	}
}