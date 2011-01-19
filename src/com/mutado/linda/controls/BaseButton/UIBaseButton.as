package com.mutado.linda.controls.BaseButton
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.util.UIPosition;
	import com.mutado.linda.util.UIStyleAppender;
	
	import flash.filters.DropShadowFilter;
	
	import mx.containers.Canvas;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/GradientStyles.as"
	
	public class UIBaseButton extends UIAdvancedButton
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIBaseButton()
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
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			_buildShadow();
			if ( getStyle( "gradientStyleName" ) != null ) {
				UIStyleAppender.appendStyle( this, getStyle( "gradientStyleName" ) );
			}
		}

	}
}