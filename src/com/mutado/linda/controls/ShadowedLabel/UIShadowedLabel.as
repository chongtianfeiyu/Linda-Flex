package com.mutado.linda.controls.ShadowedLabel
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import flash.filters.DropShadowFilter;
	
	import mx.controls.Label;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ShadowStyles.as"
	
	public class UIShadowedLabel extends Label implements IUILindaComp
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIShadowedLabel()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			selectable = false;
		}
		
		private function _buildShadow() : void
		{
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.blurX = 0;
			shadow.blurY = 0;
			shadow.angle = 90;
			shadow.quality = 1;
			shadow.distance = 1;
			shadow.color = getStyle("customShadowColor");
			shadow.alpha = getStyle("customShadowAlpha");
			filters = [ shadow ];
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			_buildShadow();
		}
		
		override protected function updateDisplayList( unscaledWidth : Number, unscaledHeight : Number ) : void
		{
			_buildShadow();
			super.updateDisplayList( unscaledWidth, unscaledHeight );
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

	}
}