package djboom.tradering.interfaces {

	import com.greensock.interfaces.ISWFLoader;

	/**
	 * Интерфейс приложения.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public interface IApplication {
		
		function set assets(value:ISWFLoader):void;
		
		function set sessionID(value:String):void;
		
		function set playerId(value:String):void;

		function set gameServerPath(value:String):void;
		
		function set gameServerRequest(value:String):void;

	}
}
