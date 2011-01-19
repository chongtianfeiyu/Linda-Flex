package com.mutado.linda.controls.ColorPicker
{
	import com.mutado.alice.images.util.CropTool;
	import com.mutado.linda.controls.IconButton.UIIconButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.util.UICursor;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	
	use namespace linda_ns;

	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ColorPickerStyles.as"
	
	public class UIEyeDropper extends UIIconButton
	{
				
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		private const DROPPER_SIZE : uint				= 200;
		private const DROPPER_SCALE : uint				= 8;
		private const DROP_WIDTH : Number				= DROPPER_SIZE / DROPPER_SCALE;
		private const DROP_HEIGHT : Number				= DROPPER_SIZE / DROPPER_SCALE;
		private const DROPPER_SAFE_AREA : uint			= 4;
		private const POINT_SIZE : uint					= 1;
		private const POINT_GAP_SIZE : uint				= 4;
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _info : ColorInfo;
		private var _dropperModal : Canvas;
		private var _dropper : Canvas;
		private var _dropperDisplay : Canvas;
		private var _timer : Timer;
		private var _targetArea : DisplayObject;
		private var _dropArea : BitmapData;
		private var _dropImage : Image;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIEyeDropper()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_timer = new Timer( 0 );
			_timer.addEventListener( TimerEvent.TIMER, _onDragTimer );
		}
		
		private function _openDropper() : void
		{
			if ( _dropper != null ) {
				_closeDropper();
				return;
			}
			locked = true;
			// create modal
			var dropperModal : Canvas = new Canvas();
			dropperModal.width = Capabilities.screenResolutionX;
			dropperModal.height = Capabilities.screenResolutionY;
			dropperModal.clipContent = false;
			// create container
			var dropperContainer : Canvas = new Canvas();
			dropperContainer.clipContent = false;
			dropperContainer.width = DROPPER_SIZE;
			dropperContainer.height = DROPPER_SIZE;
			// dropper display
			var dropperDisplay : Canvas = new Canvas();
			dropperDisplay.percentWidth = 100;
			dropperDisplay.percentHeight = 100;
			dropperDisplay.x = -dropperContainer.width / 2;
			dropperDisplay.y = -dropperContainer.height / 2;
			// dropper mask
			var dropperMask : Canvas = new Canvas();
			dropperMask.percentWidth = 100;
			dropperMask.percentHeight = 100;
			dropperMask.styleName = getStyle( "eyeDropperDropMaskStyleName" );
			dropperMask.cacheAsBitmap = true;
			dropperMask.x = -dropperContainer.width / 2;
			dropperMask.y = -dropperContainer.height / 2;
			dropperDisplay.cacheAsBitmap = true;
			dropperDisplay.mask = dropperMask;
			// create difference cross
			var cross : Canvas = new Canvas();
			cross.graphics.lineStyle( 
				POINT_SIZE, 
				0xffffff, 
				1, 
				true, 
				LineScaleMode.NORMAL, 
				CapsStyle.SQUARE, 
				JointStyle.MITER, 
				1 );
			cross.graphics.moveTo( DROPPER_SIZE / 2, DROPPER_SAFE_AREA );
			cross.graphics.lineTo( DROPPER_SIZE / 2, DROPPER_SIZE / 2 - POINT_GAP_SIZE );
			cross.graphics.moveTo( DROPPER_SIZE - DROPPER_SAFE_AREA, DROPPER_SIZE / 2 );
			cross.graphics.lineTo( DROPPER_SIZE / 2 + POINT_GAP_SIZE, DROPPER_SIZE / 2 );
			cross.graphics.moveTo( DROPPER_SAFE_AREA, DROPPER_SIZE / 2 );
			cross.graphics.lineTo( DROPPER_SIZE / 2 - POINT_GAP_SIZE, DROPPER_SIZE / 2 );
			cross.graphics.moveTo( DROPPER_SIZE / 2, DROPPER_SIZE - DROPPER_SAFE_AREA );
			cross.graphics.lineTo( DROPPER_SIZE / 2, DROPPER_SIZE / 2 + POINT_GAP_SIZE );
			cross.x = -dropperContainer.width / 2;
			cross.y = -dropperContainer.height / 2;
			cross.blendMode = BlendMode.INVERT;
			// create dropper
			var overlay : Canvas = new Canvas();
			overlay.styleName = getStyle( "eyeDropperDropStyleName" );
			overlay.percentWidth = 100;
			overlay.percentHeight = 100;
			overlay.x = -dropperContainer.width / 2;
			overlay.y = -dropperContainer.height / 2;
			// display list
			dropperContainer.addChild( dropperDisplay );
			dropperContainer.addChild( cross );
			dropperContainer.addChild( overlay );
			dropperContainer.addChild( dropperMask );
			dropperModal.addChild( dropperContainer );
			// popup dropper
			PopUpManager.addPopUp( dropperModal, this );
			// save reference
			_dropperModal = dropperModal;
			_dropper = dropperContainer;
			_dropperDisplay = dropperDisplay;
			// listeners
			_dropperModal.addEventListener( MouseEvent.MOUSE_DOWN, _onDropColor );
			// start
			_startDragDropper();
		}
		
		private function _startDragDropper() : void
		{
			//_timer.start();
			_dropperModal.addEventListener( MouseEvent.MOUSE_MOVE, _onDragTimer );
			_updateDropper();
			if ( parentApplication.cursorManager != null ) {
				parentApplication.cursorManager.setCursor( UICursor.PRECISION_SMALL );	
			} else {
				CursorManager.getInstance().setCursor( UICursor.PRECISION_SMALL );	
			}
		}
		
		private function _updateDropper() : void
		{
			var caty : Number = Math.abs( pointer.y - center.y );
			var rad : Number = Math.acos( caty / centerDistance );
			var distance : Number = centerDistance - DROPPER_SIZE;
			var nx : Number = distance * Math.sin( rad );
			var ny : Number = distance * Math.cos( rad );
			if ( pointer.x > center.x ) {
				nx = center.x + nx;
			} else {
				nx = center.x - nx;
			}
			if ( pointer.y > center.y ) {
				ny = center.y + ny;
			} else {
				ny = center.y - ny;
			}
			_dropper.x = nx;
			_dropper.y = ny;
			_dropSelection();
		}
		
		private function _dropSelection() : void
		{
			if ( _dropArea != null ) {
				_dropArea.dispose();
			}
			// create bitmap
			var crop : CropTool = new CropTool( targetArea );
			var rect : Rectangle =  new Rectangle( pointer.x - DROP_WIDTH / 2, pointer.y - DROP_HEIGHT / 2, DROP_WIDTH, DROP_HEIGHT );
			//_dropArea = crop.cropArea( rect, DROPPER_SCALE ); 
			_dropArea = crop.cropArea( rect );
			_dropImage = new Image();
			_dropImage.source = new Bitmap( _dropArea );
			_dropImage.scaleX = _dropImage.scaleY = DROPPER_SCALE;
			_dropperDisplay.removeAllChildren();
			_dropperDisplay.addChild( _dropImage );	
		}
		
		private function _dropColor() : void
		{
			info.color = _dropArea.getPixel32( DROP_WIDTH / 2, DROP_HEIGHT / 2 );
			dispatchEvent( new ColorPickerBoxEvent( EyeDropperEvent.COLOR_DROPPED ) );
			_closeDropper();
		}
		
		private function _closeDropper() : void
		{
			// remove active listeners
			_dropperModal.removeEventListener( MouseEvent.MOUSE_DOWN, _onDropColor );
			// stop timer // remove listeners
			_dropperModal.removeEventListener( MouseEvent.MOUSE_MOVE, _onDragTimer );
			//_timer.stop();
			// close popup
			PopUpManager.removePopUp( _dropperModal );
			// reset variables
			_dropperModal = null;
			_dropper = null;
			_dropperDisplay = null;
			_dropArea.dispose();
			// unlock
			locked = false;
			// restore cursos
			if ( parentApplication.cursorManager != null ) {
				parentApplication.cursorManager.removeAllCursors();	
			} else {
				CursorManager.getInstance().removeAllCursors();	
			}
			// dispatch close event
			dispatchEvent( new ColorPickerBoxEvent( EyeDropperEvent.CLOSE ) );
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			styleName = getStyle( "eyeDropperStyleName" );
			super.commitProperties();
		}
		
		override protected function click() : void
		{
			_openDropper();
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onDragTimer( e : Event ) : void
		{
			_updateDropper();	
		}
		
		private function _onDropColor( e : Event ) : void
		{
			_dropColor();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get center() : Point
		{
			return new Point( targetArea.width / 2, targetArea.height / 2 );	
		}
		
		protected function get pointer() : Point
		{
			return new Point( targetArea.mouseX, targetArea.mouseY );	
		}
		
		protected function get centerDistance() : Number
		{
			return Math.sqrt( Math.pow( pointer.x - center.x, 2 ) + Math.pow( pointer.y - center.y, 2 ) );
		}
		
		public function get targetArea() : DisplayObject
		{
			return _targetArea != null ? _targetArea : DisplayObject( parentApplication );
		}
		
		public function set targetArea( value : DisplayObject ) : void
		{
			_targetArea = value;
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