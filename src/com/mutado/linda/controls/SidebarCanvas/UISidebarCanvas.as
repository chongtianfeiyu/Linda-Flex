package com.mutado.linda.controls.SidebarCanvas
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import flash.filters.DropShadowFilter;
	
	import mx.containers.Canvas;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ShadowStyles.as"
	
	public class UISidebarCanvas extends Canvas implements IUILindaComp
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UISidebarCanvas()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			//direction = BoxDirection.VERTICAL;
			percentHeight = 100;	
			percentWidth = 100;
		}
		
		private function _buildShadow() : void
		{
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.blurX = 0;
			shadow.blurY = 0;
			shadow.angle = 90;
			shadow.quality = 1;
			shadow.distance = 1;
			shadow.color = getStyle( "customShadowColor" );
			shadow.alpha = getStyle( "customShadowAlpha" );
			filters = [ shadow ];
		}
		
		private function _updateVisibility() : void
		{
			
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();	
			_buildShadow();
		}
		
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
			_updateVisibility();
		}
		
	}
}