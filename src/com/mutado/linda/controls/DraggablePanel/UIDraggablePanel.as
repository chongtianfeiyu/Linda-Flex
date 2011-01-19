package com.mutado.linda.controls.DraggablePanel
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Panel;
	import mx.core.UIComponent;
	import mx.core.Window;

	public class UIDraggablePanel extends Panel
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
	
		public function UIDraggablePanel()
		{
			super();
		}

		// ==================================================================================
		// HANDLERS
		// ==================================================================================
	
		private function _onMouseDown( e : Event ) : void
		{
			if ( target == null ) {
				target = this;
			}
			if ( target is Window ) {
				Window( target ).nativeWindow.startMove();
			} else {
				target.startDrag()
			}
		}
		
		private function _onMouseUp( e : Event ) : void 
		{
			if ( target == null ) {
				target = this;
			}
			if ( target is Window ) {
				Window( target ).nativeWindow.restore();
			} else {
				target.startDrag()
			}
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
	
		override protected function createChildren() : void
		{
			super.createChildren();
			super.addEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown )
			super.addEventListener( MouseEvent.MOUSE_UP, _onMouseUp )
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public var target : UIComponent;
		
	}
}