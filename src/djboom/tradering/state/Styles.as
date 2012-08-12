package djboom.tradering.state {
	import flash.text.StyleSheet;

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class Styles {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------
		
		public static const GAMEINFO_TITLE:String = "GAMEINFO_TITLE";
		public static const GAMEINFO_TEXT:String = "GAMEINFO_TEXT";
		
		public static const GAMECONTROL_BANK:String = "GAMECONTROL_BANK";
		public static const GAMECONTROL_MONEY:String = "GAMECONTROL_MONEY";
		public static const GAMECONTROL_H2:String = "GAMECONTROL_H2";
		public static const GAMECONTROL_P:String = "GAMECONTROL_P";
		public static const GAMECONTROL_SPAN:String = "GAMECONTROL_SPAN";

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private static var _css:StyleSheet;
		
		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Styles() {
			throw(new Error("Styles is a static class and should not be instantiated."));
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

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public static function init():void {
			_css = new StyleSheet();
			_css.setStyle("." + GAMEINFO_TITLE, {color:"#6edcfe", fontFamily:Font.BLISS_PRO, fontSize:"16", fontWeight:"bold"});
			_css.setStyle("." + GAMEINFO_TEXT, {color:"#41b4d8", fontFamily:Font.ARIAL, fontSize:"12", fontWeight:"bold"});
			_css.setStyle("." + GAMECONTROL_BANK, {color:"#6be1ff", fontFamily:Font.BLISS_PRO, fontSize:"30", fontWeight:"bold", textAlign: 'center'});
			_css.setStyle("." + GAMECONTROL_MONEY, {color:"#c8f4ff", fontFamily:Font.BLISS_PRO, fontSize:"30", fontWeight:"bold", textAlign: 'center'});
			_css.setStyle("." + GAMECONTROL_H2, {color:"#c8f4ff", fontFamily:Font.ARIAL, fontSize:"18", fontWeight:"bold", textAlign: 'center'});
			_css.setStyle("." + GAMECONTROL_P, {color:"#6be1ff", fontFamily:Font.ARIAL, fontSize:"12", textAlign: 'center'});
			_css.setStyle("." + GAMECONTROL_SPAN, {color:"#41b4d8", fontFamily:Font.ARIAL, fontSize:"12", textAlign: 'center'});
			
		}

		static public function get css():StyleSheet {
			return _css;
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}