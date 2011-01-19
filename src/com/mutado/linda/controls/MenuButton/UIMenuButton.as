package com.mutado.linda.controls.MenuButton
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.util.UIPosition;
	
	use namespace linda_ns;
	
	public class UIMenuButton extends UIAdvancedButton
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIMenuButton()
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
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function over() : void
		{
			styleName = getStyle( "buttonOverStyle" );
		}
		
		override protected function out() : void
		{
			styleName = null;
		}		
		
	}
}