package djboom.tradering.state {

	/**
	 * Запросы.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class Actions {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		// Ошибка
		public static const ERROR:String = "error";

		// Успешно
		public static const SUCCESS:String = "success";

		// Сохранить способ высказывания
		public static const SAVE_STATEMENT_MODE:String = "saveStatementMode";

		// Получение списка доступных игр
		public static const GET_GAMES:String = "getGames";

		// Присоединение к игре
		public static const JOIN_GAME:String = "joinGame";

		// Создание новой игры
		public static const CREATE_GAME:String = "createNewGame";

		// Игра создана
		public static const GAME_CREATED:String = "gameCreated";

		// Присоеденились к игре
		public static const GAME_JOINED:String = "gameJoined";

		// Получение состояния игры
		public static const GET_GAME_INFO:String = "getGameInfo";

		// ожидание игроков
		public static const WAITING_PLAYERS:String = "waitingPlayers";

		// истекло время ожидания игроков
		public static const WAITING_PLAYERS_TIMEOUT:String = "waitingPlayersTimeOut";

		// смена фазы
		public static const CHANGE_PHASE:String = "changePhase";

		// Изменение статуса готовности пользователя
		public static const CHANGE_READINESS_STATUS:String = "changeReadinessStatus";


		// Нет экшна
		public static const NULL:String = "null";

		// Ошибка при парсинге JSON
		public static const ERROR_JSON:String = "ERROR_JSON";

		// Покинуть ожидания кворума игры
		public static const LEAVE_GAME_WAITING:String = "leaveGameWaiting";

		public static const ADD_CHAT_MESSAGE:String = "addChatMessage";
		public static const GAMES_INFO:String = "getGameInfo";

		public static const GAME_OVER:String = "gameOver";

		public static const CHAT_MESSAGES:String = "chatMessages";

		// Голосование за участника.
		public static const VOTE:String = "vote";

		/**
		 * Функция делает видимой карту игрока для комиссара или сержанта.
		 * Вызывается при клике комиссаром на карту игрока, которую он хочет открыть.
		 * 
		 */

		public static const SHOW_CARD:String = "showCard";

		// Получение полного списка игр (без сравнения с кэшем)
		public static const GET_FULL_GAMES_LIST:String = "getFullGameList";

		public static const START_GAME:String = "startGame";

		// Получение данных пользователя
		public static const GET_USER_BALANCE:String = "getUserBalance";

		public static const APPLY_SAYING:String = "applySaying";
		public static const REFUSE_SAYING:String = "refuseSaying";


		public static const GET_USER_GAME_STATE:String = "getUserGameState";

		public static const LEAVE_GAME:String = "leaveGame";





		/**
		 * Баланс пользователя изменился.
		 * <br>
		 * 
		 * data = Object {
		 * 	realBalance:int,
		 * 	virtualBalance:int
		 * }
		 * 
		 */

		public static const BALANCE_UPDATED:String = "balanceUpdated";


		/**
		 * Аукцион начался.
		 * <br>
		 * 
		 * data = Object {
		 * 	auctionCompany,
		 * 	ownedCompanies
		 * }
		 * 
		 */
		 
		public static const AUCTION_STARTED:String = "auctionStarted";


		/**
		 * Аукцион обновлен.
		 * <br>
		 * 
		data = Array (
		bets - Array ( [playerId] => [amount]) - 
		)
		 */

		public static const AUCTION_UPDATED:String = "auctionUpdated";


		/**
		 * Определено количество лотов.
		 * <br>
		 * 
		data = Array (
		lotNum - [lotNum]
		...
		)
		 */

		public static const LOT_NUM_DEFINED:String = "lotNumDefined";


		/**
		 * Определен штраф.
		 * <br>
		 * 
		data = Array (
		loosePenalty - [loosePenalty]
		...
		)
		 */

		public static const LOOSE_PENALTY_DEFINED:String = "loosePenaltyDefined";


		/**
		 * Аукцион закончен.
		 * <br>
		 * 
		data = Array (
		loosePenalty - [loosePenalty]
		...
		)
		 */

		public static const AUCTION_FINISHED:String = "auctionFinished";
		
		
		
		
		
		
		
		
		public static const SELL_ALL_STOCK:String = "sellAllStock";
		public static const BUY_GOODLUCK:String = "buyRandomStock";


	}
}