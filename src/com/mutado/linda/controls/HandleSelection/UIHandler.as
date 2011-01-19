package com.mutado.linda.controls.HandleSelection
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.util.UICursor;
	import com.mutado.linda.util.UIPosition;
	import com.mutado.linda.util.UISelection;
	
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;
	import mx.managers.CursorManagerPriority;

	public class UIHandler extends UIAdvancedButton
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _position : String;
		private var _cursorClass : Class;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIHandler( position : String = null )
		{
			super();
			_position = position;
			init();
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function init( handler : Class = null ) : void
		{
			var HandlerClass : Class = handler != null ? handler : UISelection.HANDLER;
			var dobj : DisplayObject = DisplayObject( new HandlerClass() ); 
			var comp : UIComponent = new UIComponent();
			comp.addChild( dobj );
			addChild( comp );
			
			defineCursor();
		}
		
		protected function defineCursor() : void
		{
			// switch cursor class
			switch ( position ) {
				
				case UIPosition.TOP:
				case UIPosition.BOTTOM:
					_cursorClass = UICursor.VERTICAL;
				break;
				
				case UIPosition.LEFT:
				case UIPosition.RIGHT:
					_cursorClass = UICursor.HORIZONTAL;
				break;
				
				case UIPosition.TOP_LEFT:
					_cursorClass = UICursor.DIAG_1;
				break;
				
				case UIPosition.TOP_RIGHT:
					_cursorClass = UICursor.DIAG_2;
				break;
				
				case UIPosition.BOTTOM_RIGHT:
					_cursorClass = UICursor.DIAG_3;
				break;
				
				case UIPosition.BOTTOM_LEFT:
					_cursorClass = UICursor.DIAG_4;
				break;
				
				case UIPosition.CENTER:
					_cursorClass = UICursor.MOVE;
				break;
				
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function over() : void
		{
			cursorManager.removeAllCursors();
			cursorManager.setCursor( _cursorClass, CursorManagerPriority.HIGH );
		}
		
		override protected function out() : void
		{
			cursorManager.removeAllCursors();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function set position( value : String ) : void
		{
			_position = value;
			defineCursor();
		}
		
		public function get position() : String
		{
			return _position;
		}
		
	}
}