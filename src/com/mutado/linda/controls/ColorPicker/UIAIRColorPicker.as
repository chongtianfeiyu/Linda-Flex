package com.mutado.linda.controls.ColorPicker
{
	import com.mutado.linda.core.linda_ns;
	
	import flash.display.NativeWindowType;
	import flash.events.Event;
	
	use namespace linda_ns;
	
	public class UIAIRColorPicker extends UIFlexColorPicker
	{
				
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
			
		private var _picker : ColorPickerWindow;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIAIRColorPicker()
		{
			super();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function click() : void
		{
			if ( windowed ) {
				if ( _picker != null ) return;
				_picker = new ColorPickerWindow();
				_picker.title = "Color Picker";
				_picker.alwaysInFront = true;
				_picker.type = NativeWindowType.UTILITY;
				_picker.styleName = getStyle( "colorPickerWindowStyleName" );
				_picker.initColorInfo = info.clone();
				_picker.addEventListener( ColorPickerBoxEvent.CLOSE, _onClose );
				_picker.addEventListener( ColorPickerBoxEvent.CHANGE, _onChange );
				_picker.addEventListener( Event.CLOSE, _onClose );
				_picker.open( true );
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onClose( e : Event ) : void
		{
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CLOSE ) );
			_picker = null;
		}
		
		private function _onChange( e : Event ) : void
		{
			info = _picker.colorBox.info;
			color = info.color;
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CHANGE ) );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
	}
}