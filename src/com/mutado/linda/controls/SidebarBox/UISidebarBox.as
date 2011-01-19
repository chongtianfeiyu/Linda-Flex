package com.mutado.linda.controls.SidebarBox
{
	
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import flash.geom.ColorTransform;
	
	import mx.containers.Box;
	import mx.containers.BoxDirection;
	
	use namespace linda_ns;
	
	public class UISidebarBox extends Box implements IUILindaComp
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UISidebarBox()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			direction = BoxDirection.VERTICAL;
		}
		
		private function _updateVisibility() : void
		{
			buttonMode = enabled;
			mouseEnabled = enabled;
			var color:ColorTransform = new ColorTransform();
			if ( !enabled ) {
				color.redOffset   = -80;
				color.greenOffset = -80;
				color.blueOffset  = -80;
			} else {
				color.redOffset   = 0;
				color.greenOffset = 0;
				color.blueOffset  = 0;
			}
			transform.colorTransform = color;
			if ( !enabled ) {
				alpha = .4;
			} else {
				alpha = 1;
			}
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function propagateProperties() : void
		{
			//
		}
	
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		override public function set enabled( value : Boolean) : void
		{
			super.enabled = value;
			mouseEnabled = value;
			mouseChildren = value;
			_updateVisibility();
		}
		
	}
}