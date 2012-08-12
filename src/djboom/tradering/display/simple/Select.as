package djboom.tradering.display.simple {
	import djboom.display.smart.HotSpot;
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.SmartShape;
	import djboom.display.smart.SmartSpriteCache;
	import djboom.display.smart.SmartTextField;
	import djboom.interfaces.smart.ISmartBitmap;
	import djboom.interfaces.smart.ISmartContainer;
	import djboom.interfaces.smart.ISmartShape;
	import djboom.interfaces.smart.ISmartTextField;
	import djboom.tradering.events.SelectEvent;
	import djboom.utils.DrawUtil;
	import djboom.utils.StageReference;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * Выбор категории.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	[Event(name="select", type="djboom.tradering.events.SelectEvent")]

	public class Select extends SmartSpriteCache {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		private static const CLOSE:String = "bitmap.select.Close";
		private static const OPEN:String = "bitmap.select.Open";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _open:Boolean = false;

		private var _back:ISmartBitmap;
		private var _field:ISmartTextField;
		private var _hotSpot:HotSpot;

		private var _itemContainer:ISmartContainer;

		private var _lastItemSelected:Item;
		private var _shape:ISmartShape;



		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Select(title:String = "") {
			super();

			_shape = new SmartShape();
			_shape.x = 13;
			_shape.y = 36;
			_shape.visible = false;
			_shape.graphics.beginFill(0x737373, 1);
			DrawUtil.drawRoundRect(_shape.graphics, 0, 0, 154, 1, 10, 10);
			_shape.graphics.endFill();
			addChild(DisplayObject(_shape));

			_back = new SmartBitmap(getBitmap(CLOSE, false));
			addChild(DisplayObject(_back));

			_field = new SmartTextField();
			_field.htmlText = '<span class="select">' + title + '</span>';
			_field.move(21, 16);
			addChild(DisplayObject(_field));

			_hotSpot = new HotSpot();
			_hotSpot.drawRect(new Rectangle(0, 0, _back.width, _back.height));
			_hotSpot.addEventListener(MouseEvent.CLICK, clickLabel);
			addChild(_hotSpot);

			_itemContainer = new SmartContainer();
			_itemContainer.visible = false;
			_itemContainer.x = 13;
			_itemContainer.y = 40;
			addChild(DisplayObject(_itemContainer));
		}





		// ----------------------------------------------------------------------------
		// Приватные методы класса.
		// ----------------------------------------------------------------------------

		private function clickItem(event:MouseEvent):void {
			var item:Item = event.currentTarget as Item;

			item.removeEventListener(MouseEvent.CLICK, clickItem);
			item.selected = true;

			if (_lastItemSelected != null) {
				_lastItemSelected.selected = false;
				_lastItemSelected.addEventListener(MouseEvent.CLICK, clickItem);
			}

			var e:SelectEvent = new SelectEvent(SelectEvent.SELECT);
			e.data = item.data;
			e.label = item.label;
			dispatchEvent(e);

			_field.htmlText = '<span class="select">' + item.label + '</span>';

			_open = false;
			removeList();

			_lastItemSelected = item;
		}

		private function clickLabel(event:MouseEvent):void {
			_open = !_open;

			if (_open) {
				_itemContainer.visible = true;
				_shape.visible = _itemContainer.visible;
				_back.bitmapData = getBitmap(OPEN, false);

				StageReference.getStage().addEventListener(MouseEvent.CLICK, onStageClick);
			} else {
				removeList();
			}
		}

		private function removeList():void {
			StageReference.getStage().removeEventListener(MouseEvent.CLICK, onStageClick);

			_itemContainer.visible = false;
			_shape.visible = _itemContainer.visible;
			_back.bitmapData = getBitmap(CLOSE, false);
		}

		private function onStageClick(event:MouseEvent):void {
			if (event.target == _hotSpot) return;

			if (_itemContainer == null) return;

			if (new Rectangle(_itemContainer.x, _itemContainer.y, _itemContainer.width, _itemContainer.height).contains(event.stageX, event.stageY)) return;

			_open = false;
			removeList();
		}

		// ----------------------------------------------------------------------------
		// Видимые методы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Переопределенные методы.
		// ----------------------------------------------------------------------------

		override public function dispose():void {
			_lastItemSelected = null;

			if (_back != null) {
				_back.dispose();
				_back = null;
			}

			if (_hotSpot != null) {
				_hotSpot.dispose();
				_hotSpot = null;
			}

			if (_shape != null) {
				_shape.dispose();
				_shape = null;
			}

			if (_field != null) {
				_field.dispose();
				_field = null;
			}

			if (_itemContainer != null) {
				_itemContainer.dispose();
				_itemContainer = null;
			}

			super.dispose();
		}

		override public function reflect():Class {
			return Select;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public function addItem(o:Object):void {
			// example
			// o = {label:"Командная", data:"d"};
			var item:Item = new Item(o);
			item.y = _itemContainer.numChildren * Item.HEIGHT;
			item.addEventListener(MouseEvent.CLICK, clickItem);
			_itemContainer.addChild(item);

			if (_itemContainer.numChildren == 1) {
				item.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}

			_shape.graphics.clear();

			_shape.graphics.beginFill(0x737373, 1);
			DrawUtil.drawRoundRect(_shape.graphics, 0, 0, 154, _itemContainer.height + 4, 10, 10);
			_shape.graphics.endFill();
		}

		public function clear():void {
			_itemContainer.clear();


		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}




import djboom.display.smart.SmartShape;
import djboom.display.smart.SmartSpriteCache;
import djboom.display.smart.SmartTextField;
import djboom.interfaces.smart.ISmartShape;
import djboom.interfaces.smart.ISmartTextField;
import djboom.utils.Validate;

import com.greensock.TweenLite;

import flash.display.DisplayObject;
import flash.events.MouseEvent;

/**
 * .
 * <br>
 * 
 * @author DJ BooM 
 * @since 15.06.2012
 * 
 */

class Item extends SmartSpriteCache {

	// ----------------------------------------------------------------------------
	// Константы класса.
	// ----------------------------------------------------------------------------

	public static const HEIGHT:int = 28;

	// ----------------------------------------------------------------------------
	// Свойства класса.
	// ----------------------------------------------------------------------------

	private var _shape:ISmartShape;

	private var _field:ISmartTextField;

	private var _selected:Boolean;

	private var _label:String;
	private var _data:*;

	// ----------------------------------------------------------------------------
	// Конструктор.
	// ----------------------------------------------------------------------------

	public function Item(o:Object) {
		super();

		_label = o.label;
		_data = Validate.isSet(o.data) ? o.data : _label;

		_shape = new SmartShape();
		_shape.graphics.beginFill(0xffffff, 0);
		_shape.graphics.drawRect(0, 0, 154, HEIGHT);
		_shape.graphics.endFill();
		addChild(DisplayObject(_shape));

		_field = new SmartTextField();
		_field.htmlText = '<span class="selectitem">' + _label + '</span>';
		_field.move(15, 5);
		addChild(DisplayObject(_field));

		addEventListener(MouseEvent.ROLL_OVER, overItem);
		addEventListener(MouseEvent.ROLL_OUT, outItem);
	}

	private function overItem(event:MouseEvent = null):void {
		if (_field != null) TweenLite.to(_field, 0.2, {colorTransform:{tint:0xb0f100}});
	}

	private function outItem(event:MouseEvent = null):void {
		if (_field != null) TweenLite.to(_field, 0.2, {colorTransform:{tint:0x000000}});
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
		_data = null;

		if (_field != null) {
			_field.dispose();
			_field = null;
		}

		if (_shape != null) {
			_shape.dispose();
			_shape = null;
		}

		super.dispose();
	}

	// ----------------------------------------------------------------------------
	// Обработчики событий.
	// ----------------------------------------------------------------------------

	// ----------------------------------------------------------------------------
	// Публичные методы.
	// ----------------------------------------------------------------------------


	override public function reflect():Class {
		return Item;
	}

	public function set selected(selected:Boolean):void {
		_selected = selected;

		if (_selected) {
			removeEventListener(MouseEvent.ROLL_OVER, overItem);
			removeEventListener(MouseEvent.ROLL_OUT, outItem);

			overItem();
		} else {
			outItem();

			addEventListener(MouseEvent.ROLL_OVER, overItem);
			addEventListener(MouseEvent.ROLL_OUT, outItem);
		}
	}


	// ----------------------------------------------------------------------------
	// Методы доступа.
	// ----------------------------------------------------------------------------

	public function get label():String {
		return _label;
	}

	public function get data():* {
		return _data;
	}
}
