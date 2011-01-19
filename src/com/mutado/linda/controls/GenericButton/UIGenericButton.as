package com.mutado.linda.controls.GenericButton
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.util.UIPosition;
	
	use namespace linda_ns;
	
	public class UIGenericButton extends UIAdvancedButton
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIGenericButton()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			labelPosition = UIPosition.RIGHT;
			percentWidth = 100;
		}	

	}
}