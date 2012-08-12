package djboom.tradering.display.game.circle {
	import djboom.display.smart.SmartContainer;

	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.GlowFilter;

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

	public class MagicCircle extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Внедренные данные.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _circle:Shape;
		private var _circle1:Shape;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function MagicCircle(radius:int) {
			super();
			
			_circle = new Shape();
			// circle.graphics.lineStyle(1, 0xf54dff);
			_circle.graphics.beginFill(0xf54dff, 1);
			_circle.graphics.drawCircle(0, 0, radius);
			_circle.filters = [new GlowFilter(0xffffff, 0.75, 40, 40, 2, 1, false, true)];
			_circle.blendMode = BlendMode.OVERLAY;
			addChild(_circle);

			var circle1:Shape = new Shape();
			circle1.graphics.beginFill(0xf54dff);
			circle1.graphics.drawCircle(0, 0, radius);
			circle1.alpha = 0.08;
			addChild(circle1);
			
			
			
			_circle1 = new Shape();
			_circle1.graphics.beginFill(0xf54dff, 1);
			_circle1.graphics.drawCircle(0, 0, radius);
			_circle1.filters = [new GlowFilter(0x6be1ff, 0.8, 24, 24, 2, 1, true, true)];
			_circle1.blendMode = BlendMode.OVERLAY;
			addChild(_circle1);
			
			var stroke:Shape = new Shape();
			stroke.graphics.lineStyle(2, 0x6be1ff);
			stroke.graphics.drawCircle(0, 0, radius);
			addChild(stroke);
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
			return MagicCircle;
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