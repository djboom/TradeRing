package djboom.tradering.display.simple {
	import djboom.display.smart.SmartShape;

	/**
	 * Стрелка.
	 * <br>
	 * 
	 * @author DJ BooM 
	 * @since 15.06.2012
	 * 
	 */

	public class Arrow extends SmartShape {

		// ----------------------------------------------------------------------------
		// Конструктор.
		// ----------------------------------------------------------------------------

		public function Arrow() {
			super();

			graphics.beginFill(0xffffff);
			graphics.moveTo(0, 0);
			graphics.lineTo(8, 0);
			graphics.lineTo(4, 5);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
	}
}