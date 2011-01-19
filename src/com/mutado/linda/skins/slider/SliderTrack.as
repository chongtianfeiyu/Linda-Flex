package com.mutado.linda.skins.slider 
{  
    import flash.filters.DropShadowFilter;
    
    import mx.core.UIComponent;  
  
    public class SliderTrack extends UIComponent  
    {  
		override public function get height() : Number
		{  
			return 20;  
		}  
		  
		override protected function updateDisplayList( unscaledWidth : Number, unscaledHeight : Number) : void
		{  
			super.updateDisplayList( unscaledWidth, unscaledHeight );  
			graphics.beginFill( 0xcecece );
			graphics.drawRoundRect( -5, 0, unscaledWidth + 10, 10, 10, 10 );
			graphics.endFill();
			
			// shadow
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.inner = true;
			shadow.blurX = 4;
			shadow.blurY = 4;
			shadow.angle = 90;
			shadow.quality = 3;
			shadow.distance = 2;
			shadow.color = 0x000000;
			shadow.alpha = .45;
			filters = [ shadow ];
		}
	}  
} 