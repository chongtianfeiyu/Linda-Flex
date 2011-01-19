package com.mutado.linda.controls.GenericHSeparator
{
	import mx.containers.HBox;
	import mx.controls.HRule;
	import mx.controls.Spacer;

	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/SeparatorStyles.as"
	
	public class UIGenericHSeparator extends HBox
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		private var _dividerUI : HRule;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIGenericHSeparator()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			percentWidth = 100;
			_dividerUI = new HRule();
			_dividerUI.percentWidth = 100;
			addChild( _dividerUI );
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			_dividerUI.styleName = getStyle( "separatorStyleName" );
		}	
		
	}
}