package com.mutado.linda.controls.GenericVSeparator
{
	import mx.containers.VBox;
	import mx.controls.Spacer;
	import mx.controls.VRule;

	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/SeparatorStyles.as"
	
	public class UIGenericVSeparator extends VBox
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		private var _dividerUI : VRule;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIGenericVSeparator()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			percentHeight = 100;
			_dividerUI = new VRule();
			_dividerUI.percentHeight = 100;
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