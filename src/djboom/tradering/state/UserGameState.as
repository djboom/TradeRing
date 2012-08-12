package djboom.tradering.state {

	/**
	 * Cостояния игрока.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 *
	 * Copyright (c) 2011, DJ BooM
	 * 
	 */

	public class UserGameState {

		// ----------------------------------------------------------------------------
		// Константы класса.
		// ----------------------------------------------------------------------------

		/**
		 * Не участвует ни в одной из игр.
		 * 
		 */


		public static const USER_IDLE:String = "userIdle";

		/**
		 * Ожидает игроков.
		 * 
		 */

		public static const USER_WAIT:String = "userWait";


		/**
		 * Участвует в игре.
		 * 
		 */

		public static const USER_PLAY:String = "userPlay";

	}
}