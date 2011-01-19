package com.mutado.linda.skins.slider 
{  
    import flash.filters.DropShadowFilter;
    
    import mx.controls.sliderClasses.SliderThumb;  
  
    public class SliderPointer extends SliderThumb  
    {  
  
		public function SliderPointer()  
		{  
			super();  
		}  
		  
		override protected function updateDisplayList( unscaledWidth : Number, unscaledHeight : Number ) : void
		{  
			super.updateDisplayList( unscaledWidth, unscaledHeight );  
			graphics.beginFill( 0x4f4f4f, 1 );  
			graphics.drawCircle( 5, 1, 6);  
			graphics.endFill( );
			
			// shadow
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.inner = true;
			shadow.blurX = 3;
			shadow.blurY = 3;
			shadow.angle = -90;
			shadow.quality = 3;
			shadow.distance = 2;
			shadow.color = 0x000000;
			shadow.alpha = .55;
			filters = [ shadow ];  
		}  
	}  
}  