package djboom.tradering.display.simple {
	import djboom.display.smart.HotSpot;
	import djboom.display.smart.SmartShape;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.interfaces.core.IDisplayObject;
	import djboom.interfaces.smart.IHotSpot;
	import djboom.interfaces.smart.ISmartShape;
	import djboom.time.IInterval;
	import djboom.time.Interval;
	import djboom.utils.DisplayObjectUtil;

	import com.greensock.TweenLite;

	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * Скроллинг.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 24.09.2009
	 * 
	 */

	public class Scroll extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const SPEED_SCROLL:int = 10;

		private static const BAR:String = "bitmap.ScrollBar";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _scrollSprite:IDisplayObject;

		private var _spriteRectangle:Rectangle;

		private var _scrollbarHS:IHotSpot;

		private var _scrollSpriteHeight:int;
		private var _visibleHeight:int;
		private var _scrollHeight:int;
		private var _deltaHeight:int;

		private var _timer:IInterval;

		private var _minY:int = 0;
		private var _maxY:int;

		private var _shape:ISmartShape;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Scroll(scrollSprite:IDisplayObject, visibleHeight:int, scrollHeight:int) {
			_scrollSprite = scrollSprite;
			_visibleHeight = visibleHeight;
			_scrollHeight = scrollHeight;
			_scrollSpriteHeight = DisplayObjectUtil.getFullBounds(_scrollSprite).height;
			_deltaHeight = _scrollSpriteHeight - _visibleHeight;

			_shape = new SmartShape();
			_shape.graphics.beginFill(0x202020, 1);
			_shape.graphics.drawRect(0, 4, 1, _visibleHeight);
			_shape.graphics.endFill();
			_shape.x = 13;
			addChild(DisplayObject(_shape));

			_scrollbarHS = new HotSpot();
			_scrollbarHS.drawBitmap(getBitmap(BAR), PixelSnapping.AUTO, true);
			_scrollbarHS.x = 0;
			addChild(DisplayObject(_scrollbarHS));

			_spriteRectangle = new Rectangle(0, 0, _scrollSprite.width, _visibleHeight);
			_scrollSprite.scrollRect = _spriteRectangle;

			_maxY = _scrollHeight - _scrollbarHS.height + 14;

			_timer = Interval.setInterval(refreshScrollContent, 50);
		}

		// ----------------------------------------------------------------------------
		// Приватные методы.
		// ----------------------------------------------------------------------------

		private function dragBar(event:MouseEvent):void {
			_scrollbarHS.removeEventListener(MouseEvent.MOUSE_DOWN, dragBar);

			_timer.start();

			_scrollbarHS.startDrag(false, new Rectangle(0, 0, 0, _maxY - _minY));

			_scrollbarHS.addEventListener(MouseEvent.MOUSE_UP, stopDragBar);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragBar);
		}

		private function stopDragBar(event:MouseEvent):void {
			_scrollbarHS.removeEventListener(MouseEvent.MOUSE_UP, stopDragBar);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragBar);

			_scrollbarHS.stopDrag();

			_timer.stop();

			_scrollbarHS.addEventListener(MouseEvent.MOUSE_DOWN, dragBar);
		}

		private function refreshScrollContent():void {
			var currentY:int = ((_scrollbarHS.y) * (_scrollSpriteHeight - _visibleHeight)) / (_maxY - _minY);

			TweenLite.to(_scrollSprite, 0.3, {scrollRect:{y:currentY}});
		}

		private function scrollMouse(event:MouseEvent):void {
			var newX:int = _scrollbarHS.y - event.delta * SPEED_SCROLL;

			if (newX > _minY && newX < _maxY) {
				_scrollbarHS.y = newX;
			} else {
				if (newX > _maxY) {
					_scrollbarHS.y = _maxY;
				}

				if (newX < _minY) {
					_scrollbarHS.y = _minY;
				}
			}

			refreshScrollContent();
		}

		override public function added(event:Event):void {
			super.added(event);

			this.y = this.y - 4;

			_scrollbarHS.addEventListener(MouseEvent.MOUSE_DOWN, dragBar);
			_scrollSprite.addEventListener(MouseEvent.MOUSE_WHEEL, scrollMouse);
		}

		public function update(height:Number):void {
			_scrollSpriteHeight = height;
			_deltaHeight = _scrollSpriteHeight - _visibleHeight;


			if (_scrollbarHS.hasEventListener(MouseEvent.MOUSE_DOWN)) {
				_scrollbarHS.y = (_scrollSprite.scrollRect.y * (_maxY - _minY)) / (_scrollSpriteHeight - _visibleHeight);
			}
		}

		override public function dispose():void {
			_scrollSprite = null;

			_spriteRectangle = null;

			if (_shape != null) {
				_shape.dispose();
				_shape = null;
			}

			if (_scrollbarHS != null) {
				_scrollbarHS.dispose();
				_scrollbarHS = null;
			}

			if (_timer != null) {
				_timer.dispose();
				_timer = null;
			}

			super.dispose();
		}


	}
}