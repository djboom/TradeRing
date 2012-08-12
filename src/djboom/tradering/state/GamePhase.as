package djboom.tradering.state {

	/**
	 * Фазы игры.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class GamePhase {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------






		/**
		 * Купля/продажа акций.
		 * @return 1
		 * 
		 */

		public static const PURCHASE_AND_SALE:String = "1";


		/**
		 * торги: определение количества разыгрываемых лотов
		 * @return 2
		 * 
		 */

		public static const NUMBER_OF_LOTS:String = "2";


		/**
		 * торги: определение процента проигрыша
		 * @return 3
		 * 
		 */

		public static const PERCENTAGE_OF_LOSS:String = "3";



		/**
		 * определение победителей и доноров на торгах
		 * @return 4
		 * 
		 */

		public static const WINNERS_AND_DONNORS:String = "4";
		
		/**
		 * результаты
		 * @return 5
		 * 
		 */

		public static const RESULTS:String = "5";
		
		/**
		 * конец игры
		 * @return 5
		 * 
		 */
		
		public static const GAME_FINISHED:String = "6";




	}
}