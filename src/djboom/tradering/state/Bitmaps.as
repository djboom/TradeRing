package djboom.tradering.state {

	/**
	 * .
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 16.05.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class Bitmaps {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		public static const SERVER_OFFLINE:String = "bitmap.common.ServerOffline";
		public static const SERVER_REQUEST:String = "bitmap.common.ServerRequest";
		
		// Фон
		public static const GAME_BACK:String = "bitmap.MainBack";
		public static const GAME_BACK_REPEAT_LEFT:String = "bitmap.MainBackRepeatLeft";
		public static const GAME_BACK_REPEAT_RIGHT:String = "bitmap.MainBackRepeatRight";
		
		// Game info
		public static const GAME_INFO_VIEW_BACK:String = "bitmap.gameinfo.Back";
		public static const GAME_INFO_MONEY_GOLDEN:String = "bitmap.gameinfo.MoneyGolden";
		public static const GAME_INFO_MONEY_VIRTUAL:String = "bitmap.gameinfo.MoneyVirtual";
		public static const GAME_INFO_AUCTION_OFF:String = "bitmap.gameinfo.AuctionOff";
		public static const GAME_INFO_AUCTION_ON:String = "bitmap.gameinfo.AuctionOn";
		public static const GAME_INFO_STOCK_ICON:String = "bitmap.gameinfo.StockIcon";
		
		public static const GAME_INFO_GOLDEN:String = "bitmap.gameinfo.Golden";
		public static const GAME_INFO_VIRTUAL:String = "bitmap.gameinfo.Virtual";
		public static const GAME_INFO_PLAYERS:String = "bitmap.gameinfo.Players";
		
		
		public static const GAME_PHASE_VIEW:String = "bitmap.gamephaseview.Back";
		public static const GAME_PHASE_VIEW_ITEM:String = "bitmap.gamephaseview.Phase";
		
		
		public static const GAME_INFO_TEST:String = "bitmap.gameinfo.BackTEST";
		
		
		
		

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Bitmaps() {
			throw(new Error("Bitmaps is a static class and should not be instantiated."));
		}
	}
}