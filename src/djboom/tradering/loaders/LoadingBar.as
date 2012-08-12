package djboom.tradering.loaders {

	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * Визуальный загрузчик гида.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class LoadingBar extends Sprite {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		public static const WIDTH:Number = 300;
		public static const HEIGHT:Number = 2;

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _showColors:Array = [16766976, 499422, 14024729, 5949952];

		private var _bar:Shape;
		private var _back:Shape;
		private var _field:TextField;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function LoadingBar() {
			super();

			addEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, dispose);
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

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		private function added(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);

			_back = new Shape();
			_back.graphics.beginFill(0x222222);
			_back.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			_back.graphics.endFill();
			addChild(_back);

			_bar = new Shape();
			_bar.graphics.beginGradientFill(GradientType.LINEAR, _showColors, getAlphaForColors(_showColors), getRatioForColors(_showColors), getMatrix());
			_bar.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			_bar.graphics.endFill();
			addChild(_bar);
			
			_bar.scrollRect = new Rectangle(0, 0, 0, HEIGHT);

			_field = new TextField();
			_field.defaultTextFormat = new TextFormat("_sans", 11, 0xffffff);
			_field.autoSize = TextFieldAutoSize.LEFT;
			_field.text = "1%";
			_field.x = (WIDTH - _field.textWidth) * 0.5;
			_field.y = 10;
			addChild(_field);
		}

		private function getAlphaForColors(colors:Array):Array {
			var a:Array = [];
			
			var lengthColors:int = colors.length < 2 ? (2) : (colors.length);
			var alphaColor:uint = 0;
			
			while (alphaColor < lengthColors) {
				a.push(1);
				alphaColor = alphaColor + 1;
			}
			
			return a;
		}


		private function getRatioForColors(colors:Array):Array {
			if (colors == null || colors.length == 0) {
				colors = [13421772];
			}
			
			if (colors.length < 2) {
				colors.push(colors[0]);
			}

			var color1:Number = 255 / (colors.length - 1);
			var a:Array = [];
			var color2:uint = 0;
			
			while (color2 < colors.length) {
				a.push(color2 * color1);
				color2 = color2 + 1;
			}
			
			return a;
		}


		private function getMatrix():Matrix {
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(WIDTH, HEIGHT, 0, 0, 0);
			return matrix;
		}


		private function dispose(event:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, dispose);

			if (_bar != null) {
				_bar.graphics.clear();
				_bar.visible = false;
				removeChild(_bar);
				_bar = null;
			}

			if (_back != null) {
				_back.graphics.clear();
				_back.visible = false;
				removeChild(_back);
				_back = null;
			}

			if (_field != null) {
				_field.visible = false;
				removeChild(_field);
				_field = null;
			}

			visible = false;
		}

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public function progress(progress:Number):void {
			_bar.scrollRect = new Rectangle(0, 0, progress * WIDTH, HEIGHT);

			var percent:int = Math.floor(progress * 100);

			_field.text = percent == 0 ? "1%" : percent + "%";
			_field.x = (WIDTH - _field.textWidth) * 0.5;
		}
	}
}
