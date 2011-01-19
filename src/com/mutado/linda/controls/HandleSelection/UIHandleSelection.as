package com.mutado.linda.controls.HandleSelection
{
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.util.ColorUtils;
	import com.mutado.alice.util.KeyProxy;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.events.UIEvent;
	import com.mutado.linda.util.UIPosition;
	import com.mutado.linda.util.UISelection;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.containers.Box;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/BorderStyles.as"
	
	public class UIHandleSelection extends Canvas
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
	
		private static var SelectionBitmap : BitmapData;
		
		private var _label : String;
		
		private var _topleft 			: UIComponent;
		private var _top	 			: UIComponent;
		private var _topright 			: UIComponent;
		private var _right		 		: UIComponent;
		private var _bottomright		: UIComponent;
		private var _bottom				: UIComponent;
		private var _bottomleft 		: UIComponent;
		private var _left		 		: UIComponent;
		
		
		private var _labelUI			: Label;
		private var _flagUI				: HBox; 
		private var _handlersUI			: Canvas;
		private var _drawingUI			: Canvas; 
		private var _selectionUI		: Box; 
		
		private var _internalWidth 		: Number;
		private var _internalHeight 	: Number;
		
		private var _keyProxy			: KeyProxy;
		
		private var _ratio 				: Number;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIHandleSelection()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			buttonMode = false;
			transformable = false;
			keyboardEnabled = false;
			selected = false;
			autoselect = false;
			changed = false;
			clipContent = false;
			mouseChildren = true;
			addEventListener( FlexEvent.CREATION_COMPLETE, _onComplete );
		}
		
		private function _updateText() : void
		{
			if ( _labelUI != null ) {
				_labelUI.text = label;
			}
		}
		
		private function _registerMouseListeners() : void
		{
			if ( _selectionUI != null ) {
				try {
					_unregisterMouseListeners();
				} catch ( e : Error ) { }
				_selectionUI.addEventListener( MouseEvent.MOUSE_OUT, _onOut, mouseCapture );
				_selectionUI.addEventListener( MouseEvent.MOUSE_DOWN, _onDown, mouseCapture );
				_selectionUI.addEventListener( MouseEvent.MOUSE_UP, _onUp, mouseCapture );
				_selectionUI.addEventListener( MouseEvent.DOUBLE_CLICK, dispatchEvent, mouseCapture );
			}	
		}
		
		private function _unregisterMouseListeners() : void
		{
			if ( _selectionUI != null ) {
				_selectionUI.removeEventListener( MouseEvent.MOUSE_OUT, _onOut, mouseCapture );
				_selectionUI.removeEventListener( MouseEvent.MOUSE_DOWN, _onDown, mouseCapture );
				_selectionUI.removeEventListener( MouseEvent.MOUSE_UP, _onUp, mouseCapture );
				_selectionUI.removeEventListener( MouseEvent.DOUBLE_CLICK, dispatchEvent, mouseCapture );
			}
		}
		
		private function _setKeys() : void
		{
			if ( _selectionUI != null ) {
				_keyProxy = new KeyProxy( this, 120 );
				// key
				stage.addEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown, true, 100 );
				stage.addEventListener( KeyboardEvent.KEY_UP, _onKeyUp );
				stage.focus = this;
			}
		}
		
		private function _removeKeys() : void
		{
			if ( _selectionUI != null && _keyProxy != null ) {
				_keyProxy.release();
				_keyProxy = null;
				// key
				stage.removeEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown, true );
				stage.removeEventListener( KeyboardEvent.KEY_UP, _onKeyUp );
				stage.focus = null;
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onComplete( e : Event ) : void
		{			
			if ( SelectionBitmap == null ) {
				var ClipClass : Class = UISelection.HALF; 
				var clip : Sprite = new ClipClass() as Sprite;
				SelectionBitmap = new BitmapData( clip.width, clip.height, true, 0x00ffffff );
				SelectionBitmap.draw( clip );
			}
			
			_labelUI = new Label();
			_labelUI.text = label;
			_labelUI.setStyle( "color", getStyle( "color" ) );
			
			_drawingUI = new Canvas();
			_drawingUI.clipContent = false;
			_drawingUI.transform.colorTransform = ColorUtils.colorize( getStyle( "borderColor" ) );
			addChild( _drawingUI );
			
			_selectionUI = new Box();
			_selectionUI.percentWidth = 100;
			_selectionUI.percentHeight = 100;
			addChild( _selectionUI );
			
			_flagUI = new HBox();
			_flagUI.setStyle( "backgroundColor", getStyle( "borderColor" ) );
			_flagUI.setStyle( "paddingRight", 2 );
			_flagUI.setStyle( "verticalAlign", "middle" );
			_flagUI.addChild( _labelUI );
			addChild( _flagUI );
			
			_handlersUI = new Canvas();
			_handlersUI.clipContent = false;
			addChild( _handlersUI );
			
			_topleft = new UIHandler( UIPosition.TOP_LEFT );
			_top = new UIHandler( UIPosition.TOP );
			_topright = new UIHandler( UIPosition.TOP_RIGHT );
			_right = new UIHandler( UIPosition.RIGHT );
			_bottomright = new UIHandler( UIPosition.BOTTOM_RIGHT );
			_bottom = new UIHandler( UIPosition.BOTTOM );
			_bottomleft = new UIHandler( UIPosition.BOTTOM_LEFT );
			_left = new UIHandler( UIPosition.LEFT );
			
			registerHandler( _topleft );
			registerHandler( _top );
			registerHandler( _topright );
			registerHandler( _right );
			registerHandler( _bottomright );
			registerHandler( _bottom );
			registerHandler( _bottomleft );
			registerHandler( _left );
			
			_handlersUI.addChild( _topleft );
			_handlersUI.addChild( _top );
			_handlersUI.addChild( _topright );
			_handlersUI.addChild( _right );
			_handlersUI.addChild( _bottom );
			_handlersUI.addChild( _bottomleft );
			_handlersUI.addChild( _left );
			_handlersUI.addChild( _bottomright );
			
			if ( isNaN( minWidth ) ) {
				minWidth = 1;
				minHeight = 1;
			}
			
			transformable = true;
			
			hideHandlers();
			draw();
			
			if ( autoselect ) {
				simulateClick();
			}
		}
		
		private function _onDown( e : Event ) : void
		{
			startDrag();
			_selectionUI.addEventListener( MouseEvent.MOUSE_MOVE, _onDrag, mouseCapture );
			//cursorManager.setCursor( UICursor.MOVE );
			if ( !selected ) {
				toggle();
				dispatchEvent( new UIEvent( UIEvent.SELECT ) );
			}
		}
		
		private function _onUp( e : Event ) : void
		{
			stopDrag();
			_selectionUI.removeEventListener( MouseEvent.MOUSE_MOVE, _onDrag );
			cursorManager.removeAllCursors();
			verifyChanged();
		}
		
		private function _onDrag( e : Event ) : void {
			changed = true;	
		}
		
		private function _onOut( e : Event ) : void
		{
			stopDrag();
			cursorManager.removeAllCursors();
			verifyChanged();
		}
		
		private function _onHandlerDown( e : Event ) : void
		{
			currentHandler = UIHandler( e.currentTarget );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, _onHandlerMove );
			stage.addEventListener( MouseEvent.MOUSE_UP, _onHandlerUp );	
		}
		
		private function _onHandlerMove( e : Event ) : void
		{
			moveHandler();
		}
		
		private function _onHandlerUp( e : Event ) : void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, _onHandlerMove );
			stage.removeEventListener( MouseEvent.MOUSE_UP, _onHandlerUp );
			currentHandler = null;
			dispatchEvent( new UIEvent( UIEvent.CHANGE ) );
		}
		
		private function _onKeyDown( e : KeyboardEvent ) : void
		{
			e.stopPropagation();
			e.stopImmediatePropagation();
			if ( _keyProxy == null ) {
				return;
			}
			var value : Number = _keyProxy.isDown( Keyboard.SHIFT ) ? UISelection.PAN_SHIFT_STEP : UISelection.PAN_NORMAL_STEP;
			changed = false;
				
			switch( e.keyCode ) {
				
				case Keyboard.UP:
					panTop( value * scaleCorrectionY );
					changed = true;
				break;
				
				case Keyboard.DOWN:
					panBottom( value * scaleCorrectionY );
					changed = true;
				break;
				
				case Keyboard.LEFT:
					panLeft( value * scaleCorrectionX );
					changed = true;
				break;
				
				case Keyboard.RIGHT:
					panRight( value * scaleCorrectionX );
					changed = true;
				break;
					
			}
		}
		
		private function _onKeyUp( e : Event ) : void
		{
			verifyChanged();
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function verifyChanged() : void
		{
			if ( changed ) {
				changed = false;
				dispatchEvent( new UIEvent( UIEvent.CHANGE ) );
			}
		}
		
		protected function draw() : void
		{
			graphics.clear();
						
			var thick : uint = getStyle( "borderThickness" );
			graphics.lineStyle( thick, getStyle( "borderShadowColor" ), 1, true );
			graphics.moveTo( -thick, -thick );
			graphics.lineTo( width , -thick );
			graphics.lineTo( width, height );	
			graphics.lineTo( -thick, height );
			graphics.lineTo( -thick, -thick );
			
			// update flag
			if ( _flagUI != null ) {
				_flagUI.setStyle( "backgroundColor", getStyle( "borderColor" ) );
			}
			
			if ( _drawingUI != null ) {
				_drawingUI.graphics.clear();
				if ( getStyle( "borderColor" ) != null ) {
					if ( SelectionBitmap != null ) {
						_drawingUI.graphics.beginBitmapFill( SelectionBitmap );
					}
				}  
				_drawingUI.graphics.moveTo( -thick, -thick );
				_drawingUI.graphics.lineTo( width , -thick );
				_drawingUI.graphics.lineTo( width, height );	
				_drawingUI.graphics.lineTo( -thick, height );
				_drawingUI.graphics.lineTo( -thick, -thick );	
				_drawingUI.graphics.endFill();
			}	
			
			if ( transformable ) {
				
				var thick2 : uint = 4;
				var step : uint = thick2 / 2;
				
				_topleft.x = 0;
				_topleft.y = 0;
				_top.x = Math.round( width / 2 );
				_topright.x = Math.round( width );
				_right.x = _topright.x;
				_right.y = Math.round( height / 2 );
				_bottomright.x = _topright.x;
				_bottomright.y = Math.round( height );				
				_bottom.x = _top.x;
				_bottom.y = _bottomright.y;
				_bottomleft.y =  _bottom.y;
				_left.y = _right.y;
				 
				if ( !isNaN( ratio ) ) {
					_top.visible = false;
					_topright.visible = false;
					_right.visible = false;
					_bottom.visible = false;
					_bottomleft.visible = false;
					_left.visible = false;
					_topleft.visible = false;
				}
				
				_handlersUI.width = width;
				_handlersUI.height = height;				
				
				_handlersUI.graphics.clear();
				_handlersUI.graphics.lineStyle( thick2, getStyle( "borderShadowColor" ), getStyle( "borderShadowAlpha" ), true );
				_handlersUI.graphics.moveTo( -step, -step );
				_handlersUI.graphics.lineTo( width + step, -step );
				_handlersUI.graphics.lineTo( width + step, height + step );	
				_handlersUI.graphics.lineTo( -step, height + step );
				_handlersUI.graphics.lineTo( -step, -step );
			}
		}
		
		protected function registerHandler( handler : UIComponent ) : void
		{
			handler.addEventListener( MouseEvent.MOUSE_DOWN, _onHandlerDown );
		}
		
		protected function moveHandler() : void
		{
			switch( currentHandler.position ) {
				
				case UIPosition.TOP_LEFT:
					moveTop();
					moveLeft();
				break;
				
				case UIPosition.TOP:
					moveTop();
				break;
				
				case UIPosition.TOP_RIGHT:
					moveTop();
					moveRight();
				break;
				
				case UIPosition.RIGHT:	
					moveRight();
				break;
				
				case UIPosition.BOTTOM_RIGHT:
					moveBottom();
					moveRight();
				break;
				
				case UIPosition.BOTTOM:	
					moveBottom();
				break;
				
				case UIPosition.BOTTOM_LEFT:
					moveBottom();
					moveLeft();
				break;
				
				case UIPosition.LEFT:
					moveLeft();
				break;
				
			}	
			draw();
		}
		
		protected function moveTop() : void
		{
			if ( ( height - mouseY ) > minHeight ) {
				height -= mouseY;
				y += mouseY;
			} else {
				var dy : Number = height - minHeight;
				height -= dy;
				y += dy;
			} 
		}
		
		protected function moveRight() : void
		{
			width = mouseX > minWidth ? mouseX : minWidth;
			if ( !isNaN( ratio ) ) {
				height = width * ratio;
			}
		}
		
		protected function moveBottom() : void
		{
			height = mouseY > minHeight ? mouseY : minHeight;
			if ( !isNaN( ratio ) ) {
				width = height / ratio;
			}
		}
		
		protected function moveLeft() : void
		{
			if ( ( width - mouseX ) > minWidth ) {
				width -= mouseX;
				x += mouseX;
			} else {
				var dx : Number = width - minWidth;
				width -= dx;
				x += dx;
			}
		}
		
		// Math.ceil to prevent graphical glitches
		
		protected function panTop( value : Number ) : void
		{
			y -= Math.ceil( value );
		}
		
		protected function panBottom( value : Number ) : void
		{
			y += Math.ceil( value );
		}
		
		protected function panLeft( value : Number ) : void
		{
			x -= Math.ceil( value );
		}
		
		protected function panRight( value : Number ) : void
		{
			x += Math.ceil( value );
		}	
		
		protected function checkDiagonalHandler() : void
		{
			if ( !isNaN( ratio ) && _handlersUI != null ) {
				_top.visible = false;
				_topright.visible = false;
				_right.visible = false;
				_bottom.visible = false;
				_bottomleft.visible = false;
				_left.visible = false;
				_topleft.visible = false;
			}
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function resize( w : Number, h : Number ) : void
		{
			width = w;
			height = h;
			draw();
		}
		
		public function lock() : void
		{
			mouseEnabled = false;
			_unregisterMouseListeners();
		}
		
		public function unlock() : void
		{
			mouseEnabled = true;
			_registerMouseListeners();
		}
		
		public function toggle() : void
		{
			selected = !selected;
			if ( selected ) {
				showHandlers();
				if ( parent != null ) {
					parent.setChildIndex( this, parent.numChildren - 1 );	
				}
			} else {
				hideHandlers();
			}
		}
		
		public function showHandlers() : void
		{
			if ( _handlersUI != null ) {
				_handlersUI.visible = true;
				checkDiagonalHandler();
			}
			if ( keyboardEnabled ) {
				_setKeys();	
			}
		}
		
		public function hideHandlers() : void
		{
			if ( _handlersUI != null ) {
				_handlersUI.visible = false;
			}
			if ( keyboardEnabled ) {
				_removeKeys();
			}
		}
		
		public function simulateClick() : void
		{
			toggle();
			dispatchEvent( new UIEvent( UIEvent.SELECT ) );
		}
		
		public function dismiss() : void
		{
			_removeKeys();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public var transformable : Boolean;
		public var keyboardEnabled : Boolean;
		public var selected : Boolean;
		public var autoselect : Boolean;
		public var scaleCorrectionX : Number = 1;
		public var scaleCorrectionY : Number = 1;
		public var mouseCapture : Boolean = false;
		
		protected var currentHandler : UIHandler;
		protected var changed : Boolean;
		
		protected function get flag() : HBox
		{
			return _flagUI;	
		}
		
		override public function set label( value : String ) : void
		{
			_label = value;
			_updateText();
		}
	
		override public function get label() : String
		{
			return _label;
		}
		
		protected function get internalWidth() : Number
		{
			return _internalWidth;
		}
		
		protected function set internalWidth( value : Number ) : void
		{
			_internalWidth = value;
		}
		
		protected function get internalHeight() : Number
		{
			return _internalHeight;
		}
		
		protected function set internalHeight( value : Number ) : void
		{
			_internalHeight = value;
		}
		
		override public function set width( value : Number ) : void
		{
			super.width = Math.round( value );
			internalWidth = Math.round( value );
		}
		
		override public function set height( value : Number ) : void
		{
			super.height = Math.round( value );
			internalHeight = Math.round( value );
		}
		
		override public function set x( value : Number ) : void
		{
			super.x = Math.round( value );
		}
		
		override public function set y( value : Number ) : void
		{
			super.y = Math.round( value );
		}
		
		public function get ratio() : Number
		{
			return _ratio; 
		}
		
		public function set ratio( value : Number ) : void
		{
			_ratio = value;
			checkDiagonalHandler();
		}
		
	}
}