package com.mutado.linda.controls.HDock
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import mx.containers.HBox;
	
	use namespace linda_ns;
	
	public class UIHDock extends HBox implements IUILindaComp
	{
		public function UIHDock()
		{
			super();
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