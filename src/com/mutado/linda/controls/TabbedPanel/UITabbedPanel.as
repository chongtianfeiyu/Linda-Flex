package com.mutado.linda.controls.TabbedPanel
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.events.UIEvent;
	import com.mutado.linda.interfaces.IUILindaComp;
	import com.mutado.linda.interfaces.IUITab;
	import com.mutado.linda.interfaces.IUITabbable;
	
	import mx.containers.Canvas;
	
	use namespace linda_ns;
	
	public class UITabbedPanel extends Canvas implements IUILindaComp, IUITabbable
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _preventClosing : Boolean;
		private var _tabUI : IUITab;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UITabbedPanel()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			percentHeight = 100;
			percentWidth = 100;
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function propagateProperties() : void
		{
			//
		}
		
		public function show() : void
		{
			visible = true;
			dispatchEvent( new UIEvent( UIEvent.SHOW ) );
		}
		
		public function hide() : void
		{
			visible = false;
			dispatchEvent( new UIEvent( UIEvent.HIDE ) );
		}
		
		public function close() : void
		{
			dispatchEvent( new UIEvent( UIEvent.CLOSE ) );
		}
		
		public function closing() : void
		{
			dispatchEvent( new UIEvent( UIEvent.CLOSING ) );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function set preventClosing( value : Boolean ) : void
		{
			_preventClosing = value;
		}
		
		public function get preventClosing() : Boolean
		{
			return _preventClosing;
		}
		
		override public function set label( value : String ) : void
		{
			if ( tabUI != null ) {
				tabUI.label = value
			}
			super.label = value;	
		}
		
		public function set tabUI( value : IUITab ) : void
		{
			_tabUI = value;
		}
		
		public function get tabUI() : IUITab
		{
			return _tabUI;
		}
		
	}
}