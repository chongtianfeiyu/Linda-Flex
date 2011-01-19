package com.mutado.linda.controls.SidebarListButton
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.util.UIPosition;
		
	use namespace linda_ns;
	
	public class UISidebarListButton extends UIAdvancedButton
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UISidebarListButton()
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
			if ( !isSelected ) {
				styleName = getStyle( "buttonOverStyle" );
			}
		}
		
		override protected function out() : void
		{
			if ( !isSelected ) {
				styleName = null;
			}
		}		
		
	}
}