package com.mutado.linda.controls.ColorPicker
{
	import com.mutado.alice.error.InvalidFormatException;
	import com.mutado.linda.controls.IconButton.UIIconButton;
	import com.mutado.linda.core.linda_ns;
	
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	use namespace linda_ns;

	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ColorPickerStyles.as"
	
	public class UIFlexColorPicker extends UIIconButton
	{
				
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _windowed : Boolean;
		private var _canvas : Canvas;
		private var _picker : ColorPickerPanel;
		private var _info : ColorInfo;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIFlexColorPicker()
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
		
		private function close() : void
		{
			if ( windowed ) {
				PopUpManager.removePopUp( _picker );
				_picker = null;
			}
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			styleName = getStyle( "colorPickerStyleName" );
			super.commitProperties();
			var rectangle : Array = getStyle( "colorPickerRectangle" );
			if ( rectangle == null ) {
				throw new InvalidFormatException( "ColorPicker properties colorPickerRectangle[x, y, w, h] is required!" );
			}
			_canvas = new Canvas();			
			_canvas.width = rectangle[ 0 ];
			_canvas.height = rectangle[ 1 ];
			_canvas.x = rectangle[ 2 ];
			_canvas.y = rectangle[ 3 ];
			iconUI.addChild( _canvas );
			
			color = 0xffffff;
		}
		
		override protected function click() : void
		{
			if ( windowed ) {
				if ( _picker != null ) return;
				_picker = new ColorPickerPanel();
				_picker.title = "Color Picker";
				_picker.styleName = getStyle( "colorPickerPanelStyleName" );
				_picker.initColorInfo = info.clone();
				_picker.addEventListener( ColorPickerBoxEvent.CLOSE, _onClose );
				_picker.addEventListener( ColorPickerBoxEvent.CHANGE, _onChange );
				PopUpManager.addPopUp( _picker, UIComponent( parentApplication ) );
				PopUpManager.centerPopUp( _picker );
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onClose( e : Event ) : void
		{
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CLOSE ) );
			close();
		}
		
		private function _onChange( e : Event ) : void
		{
			info = _picker.colorBox.info;
			color = info.color;
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CHANGE ) );
			close();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function set windowed( value : Boolean ) : void
		{
			_windowed = value;
		}
		
		public function get windowed() : Boolean
		{
			return _windowed;
		}
		
		public function set color( color : uint ) : void
		{
			_canvas.setStyle( "backgroundColor", color );
		}
		
		public function get color() : uint
		{
			return uint( _canvas.getStyle( "backgroundColor" ) );
		}
		
		public function get info() : ColorInfo
		{
			if ( _info != null ) {
				return _info;
			} else { 
				info = new ColorInfo();
				return _info;
			}
		}
		
		public function set info( colorInfo : ColorInfo ) : void
		{
			_info = colorInfo;
		}
		
	}
}