package com.mutado.linda.controls.ColorPicker
{
	import flash.geom.Point;
	
	public class ColorInfo
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _position : Point;
		private var _saturation : int;
		private var _brightness : int;
		private var _hue : int;
		
		private var _color : uint;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function ColorInfo()
		{
			position = new Point( 0, 0 );
			hue = 0;
			saturation = 0;
			brightness = 0;
			color = 0xffffff;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function clone() : ColorInfo
		{
			var ci : ColorInfo= new ColorInfo();
			ci.position = position;
			ci.hue = hue;
			ci.saturation = saturation;
			ci.brightness = brightness;
			ci.color = color;
			return ci;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		
		public function get position() : Point
		{
			return _position;
		}
		
		public function set position( value : Point ) : void
		{
			_position = value;
		}
		
		public function get hue() : int
		{
			return _hue;
		}
		
		public function set hue( value : int ) : void
		{
			_hue = value;
		}
		
		public function get saturation() : int
		{
			return _saturation;
		}
		
		public function set saturation( value : int ) : void
		{
			_saturation = value;
		}
		
		public function get brightness() : int
		{
			return _brightness;
		}
		
		public function set brightness( value : int ) : void
		{
			_brightness = value;
		}
		
		public function get color() : uint
		{
			return _color;
		}
		
		public function set color( value : uint ) : void
		{
			_color = value;
		}
		
		
	}
}