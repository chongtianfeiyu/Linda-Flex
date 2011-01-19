package com.mutado.linda.controls.DashedSelection
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.util.UISelection;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.containers.Canvas;
	import mx.events.FlexEvent;
	
	use namespace linda_ns;
	
	public class UIDashedSelection extends Canvas
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		private static const SIZE : Number					= 1;
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private static var SelectionClip : MovieClip;
		
		private static var _timer : Timer;
		private static var _bd : BitmapData;
		
		private var _ratio : Number;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIDashedSelection()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			addEventListener( FlexEvent.CREATION_COMPLETE, _onCreationComplete );
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onCreationComplete( e : Event ) : void
		{
			if ( SelectionClip == null ) {
				var ClipClass : Class = UISelection.DASHED; 
				SelectionClip = new ClipClass() as MovieClip;
			}
			_timer = new Timer( 1000 / 24 );
			_timer.addEventListener( TimerEvent.TIMER, _onTimer );
			_timer.start();
		}
		
		private function _onTimer( e : Event ) : void
		{
			draw();
		}
		
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function draw() : void
		{
			if ( _bd != null ) {
				_bd.dispose();
			}
			_bd = new BitmapData( SelectionClip.width, SelectionClip.height, false );
			_bd.draw( SelectionClip );
			var w : Number = width < minWidth ? minWidth : width;
			var h : Number = height < minHeight ? minHeight : height;
			if ( !isNaN( ratio ) ) {
				if ( w > h ) {
					w = h / ratio;
				} else {
					h = w * ratio;
				}
			}
			graphics.clear();
			graphics.beginBitmapFill( _bd );
			graphics.moveTo( 0, 0 );
			graphics.lineTo( w, 0 );
			graphics.lineTo( w, h );	
			graphics.lineTo( 0, h );
			graphics.lineTo( 0, SIZE );
			graphics.lineTo( SIZE, SIZE );
			graphics.lineTo( SIZE, h - SIZE );
			graphics.lineTo( w - SIZE, h - SIZE );
			graphics.lineTo( w - SIZE, SIZE );
			graphics.lineTo( 0, SIZE );
			graphics.lineTo( 0, 0 );
			graphics.endFill();		
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function resize( w : Number, h : Number ) : void
		{
			width = Math.round( w );
			height = Math.round( h );
			draw();
		}
		
		public function dismiss() : void
		{
			if ( _timer != null ) {
				_timer.stop();
				_timer = null;
			}
			if ( _bd != null ) {
				_bd.dispose();
			}
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get ratio() : Number
		{
			return _ratio;
		}
		
		public function set ratio( value : Number )  : void
		{
			_ratio = value;
		}
		
	}
}