package com.mutado.linda.controls.SmoothImage
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	
	import mx.controls.Image;
	import mx.core.mx_internal;
    
    use namespace mx_internal;
    use namespace linda_ns;
    
    /**
     * SmoothImage
     *
     * Automatically turns smoothing on after image has loaded
     *
     * @author Ben Longoria
     */
    public class UISmoothImage extends Image  implements IUILindaComp
    {
        
        // ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
        public function UISmoothImage() : void 
        {
            super();
        }
        
        // ==================================================================================
		// PRIVATE
		// ==================================================================================
		
        override mx_internal function contentLoaderInfo_completeEventHandler(event:Event) : void 
        {
            var smoothLoader : Loader = event.target.loader as Loader;
            var smoothImage : Bitmap = smoothLoader.content as Bitmap;
            smoothImage.smoothing = true;
            super.contentLoaderInfo_completeEventHandler( event );
        }
        
        // ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function propagateProperties() : void
		{
			//
		}
		
    }
}