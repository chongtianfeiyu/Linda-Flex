package com.mutado.linda.controls.ColorPicker
{
	
	import com.mutado.alice.display.ColorMatrix;
	import com.mutado.alice.util.ColorUtils;
	import com.mutado.linda.controls.BaseButton.BaseButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	import com.mutado.linda.skins.slider.SliderPointer;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.containers.Box;
	import mx.containers.Canvas;
	import mx.controls.HSlider;
	import mx.events.FlexEvent;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ColorPickerStyles.as"
	
	public class UIColorPickerBox extends Box implements IUILindaComp
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		private static var SPECTRUM_RADIUS : uint				= 150;
		private static var SAFE_AREA : uint						= 1;
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _spectrumTimer : Timer; 
		private var _colorBitmap : BitmapData; 
		private var _over : Boolean;  
		private var _info : ColorInfo;  
		
		// UIS
		
		[Bindable] public var $spectrumCanvas : Canvas;
		[Bindable] public var $spectrumContainer : Canvas;
		[Bindable] public var $spectrum : Canvas;
		[Bindable] public var $glow : Canvas;
		[Bindable] public var $pointer : Canvas;
		[Bindable] public var $selectedColor : Canvas;
		[Bindable] public var $hSlider : HSlider;
		[Bindable] public var $sSlider : HSlider;
		[Bindable] public var $bSlider : HSlider;
		[Bindable] public var $buttonOk : BaseButton;
		[Bindable] public var $buttonCancel : BaseButton;
		[Bindable] public var $buttonReset : BaseButton;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIColorPickerBox()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_spectrumTimer = new Timer( 1 );
			_spectrumTimer.addEventListener( TimerEvent.TIMER, _onDragPointer );
			_info = new ColorInfo();
			// default listeners
			addEventListener( FlexEvent.CREATION_COMPLETE, _onComplete );
			addEventListener( FlexEvent.REMOVE, _onRemove );
		}
		
		private function _buildSpectrum() : void
		{
			SPECTRUM_RADIUS = $spectrumCanvas.width / 2;
			
			$spectrumContainer.x =  SPECTRUM_RADIUS;
			$spectrumContainer.y =  SPECTRUM_RADIUS;
			
			var gfx : Graphics = $spectrum.graphics;
			var nRadius		: Number = SPECTRUM_RADIUS;
			var nRadians   	: Number;
			var nR         	: Number;
			var nG         	: Number;
			var nB         	: Number;
			var nColor     	: Number;
			var objMatrix  	: Matrix;
			var nX         	: Number;
			var nY         	: Number;
			var iThickness 	: int;
			
			gfx.clear();
			
			iThickness = 1 + int(nRadius / 50);
			
			for( var i : uint = 0; i < 360; i++ )
			{
				nRadians = i * ( Math.PI / 180 );
				
				nR = Math.cos( nRadians )                   * 127 + 128 << 16;
				nG = Math.cos( nRadians + 2 * Math.PI / 3 ) * 127 + 128 << 8;
				nB = Math.cos( nRadians + 4 * Math.PI / 3 ) * 127 + 128;
				
				nColor = nR | nG | nB;
			
				nX = nRadius * Math.cos( nRadians );
				nY = nRadius * Math.sin( nRadians );
				
				objMatrix = new Matrix();
				objMatrix.createGradientBox( nRadius * 2, nRadius * 2, nRadians, -nRadius, -nRadius );
				
				gfx.lineStyle( iThickness, 0, 1, false, LineScaleMode.NONE, CapsStyle.NONE );
				gfx.lineGradientStyle( GradientType.LINEAR, [ 0xFFFFFF, nColor ], [ 100, 100 ], [ 127, 255 ], objMatrix );
				gfx.moveTo( 0, 0 );
				gfx.lineTo( nX, nY );
			}
			
			// apply filters
			
			// shadow
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.blurX = 5;
			shadow.blurY = 5;
			shadow.angle = 90;
			shadow.quality = 3;
			shadow.distance = 2;
			shadow.color = 0x000000;
			shadow.alpha = .45;
			
			// glow
			$glow.x = -SPECTRUM_RADIUS;
			$glow.y = -SPECTRUM_RADIUS;
			$glow.width = SPECTRUM_RADIUS * 2;
			$glow.height = SPECTRUM_RADIUS * 2;
			$glow.alpha = .2;
			$glow.blendMode = BlendMode.ADD;
			
			$spectrumCanvas.filters = [ shadow ];
		}

		private function _captureColorWheel() : void
		{
			$pointer.visible = false;
			$glow.visible = false;
			_colorBitmap = new BitmapData( $spectrumCanvas.width, $spectrumCanvas.height, true, 0x00000000 );
			_colorBitmap.draw( $spectrumCanvas, null, null, null, null, true );
			$pointer.visible = true;
			$glow.visible = true;
		}
		
		private function _updateColorWheel() : void
		{
			$pointer.visible = false;
			$glow.visible = false;
			_colorBitmap.draw( $spectrumCanvas, null, null, null, null, true );
			$pointer.visible = true;
			$glow.visible = true;
			_pickColor( info.position );
		}
		
		private function _setupSliders() : void
		{	
			$hSlider.minimum = -180;
			$hSlider.maximum = 180;
			$hSlider.value = info.hue;
			$hSlider.tickInterval = 1;
			$hSlider.liveDragging = true;
			$hSlider.sliderThumbClass = SliderPointer;
			
			$sSlider.minimum = -100;
			$sSlider.maximum = 100;
			$sSlider.value = info.saturation;
			$sSlider.tickInterval = 1;
			$sSlider.liveDragging = true;
			$sSlider.sliderThumbClass = SliderPointer;
			
			$bSlider.minimum = -100;
			$bSlider.maximum = 100;
			$bSlider.value = info.brightness;
			$bSlider.tickInterval = 1;
			$bSlider.liveDragging = true;
			$bSlider.sliderThumbClass = SliderPointer;
			
			$hSlider.addEventListener( Event.CHANGE, _onHueChange );
			$sSlider.addEventListener( Event.CHANGE, _onSaturationChange );
			$bSlider.addEventListener( Event.CHANGE, _onBrightnessChange );		
		}
		
		private function _setupPointer() : void
		{
			$spectrumCanvas.addEventListener( MouseEvent.MOUSE_DOWN, _onStartDragPointer );
			$spectrumCanvas.addEventListener( MouseEvent.MOUSE_OVER, _onOverDragPointer );
			$spectrumCanvas.addEventListener( MouseEvent.MOUSE_OUT, _onOutDragPointer );
			$spectrumCanvas.addEventListener( MouseEvent.MOUSE_UP, _onStopDragPointer );
			$spectrumCanvas.addEventListener( MouseEvent.CLICK, _onClickDragPointer );
		}
		
		private function _setupButtons() : void
		{
			$buttonCancel.addEventListener( MouseEvent.CLICK, _onCancelColor );
			$buttonOk.addEventListener( MouseEvent.CLICK, _onConfirmColor );
			$buttonReset.addEventListener( MouseEvent.CLICK, _onResetColor );
		}
		
		private function _startDragPointer() : void
		{
			addEventListener( MouseEvent.MOUSE_MOVE, _onDragPointer );
			//_spectrumTimer.start();
		}
		
		private function _stopDragPointer() : void
		{ 
			removeEventListener( MouseEvent.MOUSE_MOVE, _onDragPointer );
			//_spectrumTimer.stop();
		}
		
		private function _extractPointInfo() : void
		{
			var p1 : Point = new Point( 0, 0 );
			var p2 : Point = new Point( $pointer.parent.mouseX, $pointer.parent.mouseY );
			var d : Number = Math.sqrt( Math.pow( p2.x - p1.x, 2 ) + Math.pow( p2.y - p1.y, 2 ) );
			if ( d >= SPECTRUM_RADIUS - SAFE_AREA ) {
				p2 = _constrainPointer( p1, p2, d );
			}
			_pickColor( p2 );
		}
		
		private function _constrainPointer( p1 : Point, p2 : Point, d : Number ) : Point
		{
			var cat1 : Number = Math.abs( p2.x - p1.x );
			var cat2 : Number = Math.abs( p2.y - p1.y );
			var rad : Number = Math.asin( cat2 / d );
			var nx : Number = ( SPECTRUM_RADIUS - SAFE_AREA ) * Math.cos( rad )
			var ny : Number = ( SPECTRUM_RADIUS - SAFE_AREA ) * Math.sin( rad );
			if ( p2.x > p1.x ) {
				nx = p1.x + nx;
			} else {
				nx = p1.x - nx;
			}
			if ( p2.y > p1.y ) {
				ny = p1.y + ny;
			} else {
				ny = p1.y - ny;
			}
			return new Point( nx, ny );
		}
		
		private function _pickColor( p : Point ) : void
		{
			info.position = p;
			_movePointer();
			var px : Number = info.position.x + $spectrumCanvas.width / 2;
			var py : Number = info.position.y + $spectrumCanvas.height / 2;
			_changeColor( _colorBitmap.getPixel( px, py ) );
		}
		
		private function _movePointer() : void
		{
			$pointer.x = Math.ceil( info.position.x - $pointer.width / 2 );
			$pointer.y = Math.ceil( info.position.y - $pointer.height / 2 );
		}
		
		private function _changeColor( color : uint ) : void
		{
			info.color = color;
			$selectedColor.transform.colorTransform = ColorUtils.colorize( color );
		}
		
		private function _updateHSB() : void
		{
			var matrix : ColorMatrix = new ColorMatrix();
			$spectrum.rotation = info.hue;
			matrix.adjustSaturation( info.saturation );
			matrix.adjustBrightness( info.brightness );
			$spectrum.filters = [ new ColorMatrixFilter( matrix ) ]; 
			// update spectrum
			_updateColorWheel();
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================

		private function _onComplete( e : Event ) : void
		{
			_setupPointer();
			_buildSpectrum();
			_captureColorWheel();
			_setupSliders();
			_setupButtons();
			_updateHSB();
		}
		private function _onRemove( e : Event ) : void 
		{
			_colorBitmap.dispose();
		}
		
		private function _onClickDragPointer( e : Event ) : void
		{
			if ( over ) {
				_extractPointInfo();
			}
		}
		
		private function _onStartDragPointer( e : Event ) : void
		{
			_startDragPointer();
		}
		
		private function _onOverDragPointer( e : Event ) : void
		{
			over = true;	
		}
		
		private function _onOutDragPointer( e : Event ) : void
		{
			over = false;
		}
		
		private function _onStopDragPointer( e : Event ) : void
		{
			_stopDragPointer();
		}
		
		private function _onDragPointer( e : Event ) : void
		{
			if ( over ) {
				_extractPointInfo();
			}
		}
		
		private function _onHueChange( e : Event ) : void
		{
			info.hue = $hSlider.value;
			_updateHSB();
		}
		
		private function _onSaturationChange( e : Event ) : void
		{
			info.saturation = $sSlider.value;
			_updateHSB();	
		}
		
		private function _onBrightnessChange( e : Event ) : void
		{
			info.brightness = $bSlider.value;
			_updateHSB();
		}
		
		private function _onCancelColor( e : Event ) : void
		{
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CLOSE ) );
		}
		
		private function _onConfirmColor( e : Event ) : void
		{
			dispatchEvent( new ColorPickerBoxEvent( ColorPickerBoxEvent.CHANGE ) );
		}
		
		private function _onResetColor( e : Event ) : void
		{
			info = new ColorInfo();
			$hSlider.value = 0;
			$sSlider.value = 0;
			$bSlider.value = 0;
			_updateHSB();
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void 
		{
			super.commitProperties();
		 	styleName = getStyle( "colorPickerStyleName" );	
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
		
		public function get over() : Boolean 
		{
			return _over;
		}
		
		public function set over( value : Boolean ) : void 
		{
			_over = value;
		}
		
		public function get info() : ColorInfo
		{
			return _info;
		}
		
		public function set info( colorInfo : ColorInfo ) : void
		{
			_info = colorInfo;
		}
		
	}
}