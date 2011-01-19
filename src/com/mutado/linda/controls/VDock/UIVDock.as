package com.mutado.linda.controls.VDock
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import mx.containers.VBox;
	
	use namespace linda_ns;

	public class UIVDock extends VBox implements IUILindaComp
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIVDock()
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