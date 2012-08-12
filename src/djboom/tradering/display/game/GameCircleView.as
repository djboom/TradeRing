package djboom.tradering.display.game {
	import djboom.tradering.display.game.circle.MagicCircles;
	import djboom.display.smart.SmartContainer;

	import com.greensock.TweenLite;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.junkbyte.console.Cc;

	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.GlowFilter;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 05.08.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class GameCircleView extends SmartContainer {

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
		private var _magicCircles:MagicCircles;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GameCircleView() {
			super();

			// var s:Shape = new Shape();
			// s.graphics.lineStyle(1, 0xFFCC00);
			// DrawingShapes.drawWedge(s.graphics, 400, 60, 30, 30, 60);

			_magicCircles = new MagicCircles();
			_magicCircles.move(300, 300);
			addChild(_magicCircles);


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
			return GameCircleView;
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