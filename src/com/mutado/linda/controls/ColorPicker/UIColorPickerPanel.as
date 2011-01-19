package com.mutado.linda.controls.ColorPicker
{
	import flash.events.Event;
	
	import mx.containers.Box;
	import mx.containers.Panel;
	import mx.validators.ValidationResult;

	public class UIColorPickerPanel extends Panel
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _boxUI : Box;
		private var _colorPickerBoxUI : ColorPickerBox;
		private var _initColorInfo : ColorInfo;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIColorPickerPanel()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function childrenCreated() : void
		{
			_boxUI = new Box();
			_colorPickerBoxUI = new ColorPickerBox();
			_colorPickerBoxUI.info = initColorInfo;
			_boxUI.percentWidth = 100;
			_boxUI.percentHeight = 100;
			_boxUI.addChild( _colorPickerBoxUI );
			addChild( _boxUI );
			
			_colorPickerBoxUI.addEventListener( ColorPickerBoxEvent.CLOSE, _onClose );
			_colorPickerBoxUI.addEventListener( ColorPickerBoxEvent.CHANGE, _onChange );
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onClose( e : Event ) : void
		{
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CLOSE ) );
		}
		
		private function _onChange( e : Event ) : void
		{
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CHANGE ) );
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CLOSE ) );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get colorBox() : UIColorPickerBox
		{
			return _colorPickerBoxUI;
		}
		
		public function get initColorInfo() : ColorInfo
		{
			return _initColorInfo;
		}
		
		public function set initColorInfo( colorInfo : ColorInfo ) : void
		{
			if ( colorInfo != null ) {
				_initColorInfo = colorInfo;
			}
		}
		
	}
}