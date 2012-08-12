package djboom.tradering.display.simple {
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.interfaces.smart.ISmartBitmap;

	import com.greensock.TweenLite;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class CirclePreloader extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const CIRCLE:String = "bitmap.PreloaderCircle";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _bitmap:ISmartBitmap;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function CirclePreloader() {
			super();

			_bitmap = new SmartBitmap(getBitmap(CIRCLE));
			_bitmap.smoothing = true;
			addChild(DisplayObject(_bitmap));

			_bitmap.x = -_bitmap.width * 0.5;
			_bitmap.y = -_bitmap.height * 0.5;

			addEventListener(Event.ENTER_FRAME, animate);

			this.alpha = 0;

			TweenLite.to(this, 1, {alpha:1});
		}

		private function animate(event:Event):void {
			rotation += 30;
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
			removeEventListener(Event.ENTER_FRAME, animate);

			if (_bitmap != null) {
				_bitmap.dispose();
				_bitmap = null;
			}

			super.dispose();
		}

		override public function reflect():Class {
			return CirclePreloader;
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