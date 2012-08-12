package djboom.tradering.display.game {
	import djboom.display.smart.SmartBitmap;
	import djboom.display.smart.SmartContainer;
	import djboom.display.smart.SmartTextField;
	import djboom.managers.AssetManager;
	import djboom.tradering.data.GameInfo;
	import djboom.tradering.data.Players;
	import djboom.tradering.state.Auction;
	import djboom.tradering.state.Bitmaps;
	import djboom.tradering.state.Currency;
	import djboom.tradering.state.Styles;

	import com.greensock.TweenMax;

	import flash.events.Event;
	import flash.filters.DropShadowFilter;

	/**
	 * Панель с информацией об игре.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 05.08.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class GameInfoView extends SmartContainer {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Внедренные данные.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Свойства класса.
		// ----------------------------------------------------------------------------

		private var _titleField:SmartTextField;
		private var _stockNominalField:SmartTextField;
		private var _playersNumberField:SmartTextField;
		private var _back:SmartBitmap;
		private var _moneyIcon:SmartBitmap;
		private var _auctionIcon:SmartBitmap;
		private var _stockIcon:SmartBitmap;
		private var _currencyIcon:SmartBitmap;
		private var _playersIcon:SmartBitmap;
		private var _currentPlayersNumber:uint;
		private var _playersIconAnimate:SmartBitmap;

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function GameInfoView(gameInfo:GameInfo) {
			super();

			_currentPlayersNumber = Players.playersInfo.length;


			_back = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_INFO_VIEW_BACK));
			addChild(_back);

			_titleField = new SmartTextField();
			_titleField.embedFonts = true;
			_titleField.cssClass = Styles.GAMEINFO_TITLE;
			_titleField.smartText = gameInfo.gameName;
			_titleField.filters = [new DropShadowFilter(1, 90, 0x031336, 1, 0, 0)];
			_titleField.move(40, 16);
			addChild(_titleField);


			_moneyIcon = new SmartBitmap(AssetManager.getBitmapData(gameInfo.currency == Currency.GOLDEN ? Bitmaps.GAME_INFO_MONEY_GOLDEN : Bitmaps.GAME_INFO_MONEY_VIRTUAL));
			_moneyIcon.move(46, 50);
			addChild(_moneyIcon);


			_auctionIcon = new SmartBitmap(AssetManager.getBitmapData(gameInfo.auctionEnabled == Auction.ENABLED ? Bitmaps.GAME_INFO_AUCTION_ON : Bitmaps.GAME_INFO_AUCTION_OFF));
			_auctionIcon.move(88, 49);
			addChild(_auctionIcon);


			_stockIcon = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_INFO_STOCK_ICON));
			_stockIcon.move(130, 53);
			addChild(_stockIcon);

			_stockNominalField = new SmartTextField();
			_stockNominalField.embedFonts = true;
			_stockNominalField.cssClass = Styles.GAMEINFO_TEXT;
			_stockNominalField.smartText = gameInfo.nominal;
			_stockNominalField.filters = [new DropShadowFilter(1, 90, 0x022b61, 0.55, 0, 0)];
			_stockNominalField.move(_stockIcon.x + _stockIcon.width + 4, 53);
			addChild(_stockNominalField);

			_currencyIcon = new SmartBitmap(AssetManager.getBitmapData(gameInfo.currency == Currency.GOLDEN ? Bitmaps.GAME_INFO_GOLDEN : Bitmaps.GAME_INFO_VIRTUAL));
			_currencyIcon.move(_stockNominalField.x + _stockNominalField.textWidth + 6, 57);
			addChild(_currencyIcon);


			_playersIcon = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_INFO_PLAYERS));
			_playersIcon.move(213, 52);
			addChild(_playersIcon);

			_playersNumberField = new SmartTextField();
			_playersNumberField.embedFonts = true;
			_playersNumberField.cssClass = Styles.GAMEINFO_TEXT;
			_playersNumberField.smartText = _currentPlayersNumber.toString();
			_playersNumberField.filters = [new DropShadowFilter(1, 90, 0x022b61, 0.55, 0, 0)];
			_playersNumberField.move(_playersIcon.x + _playersIcon.width + 4, 53);
			addChild(_playersNumberField);

			_playersIconAnimate = new SmartBitmap(AssetManager.getBitmapData(Bitmaps.GAME_INFO_PLAYERS));
			_playersIconAnimate.move(213, 52);
			_playersIconAnimate.alpha = 0;
			addChild(_playersIconAnimate);

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
			return GameInfoView;
		}

		// ----------------------------------------------------------------------------
		// Обработчики событий.
		// ----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		// Публичные методы.
		// ----------------------------------------------------------------------------

		public function updatePlayersNumber():void {
			if (Players.playersInfo.length > _currentPlayersNumber) {
				TweenMax.fromTo(_playersIconAnimate, 0.3, {alpha:0, y:42}, {alpha:1, y:"10"});
			} else if (Players.playersInfo.length < _currentPlayersNumber) {
				TweenMax.fromTo(_playersIconAnimate, 0.3, {alpha:1, y:52}, {alpha:0, y:"-10"});
			}

			_currentPlayersNumber = Players.playersInfo.length;
			_playersNumberField.smartText = _currentPlayersNumber.toString();
		}

		// ----------------------------------------------------------------------------
		// Методы доступа.
		// ----------------------------------------------------------------------------
	}
}