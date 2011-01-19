package com.mutado.linda.controls.ToggleBar
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.events.UIEvent;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Box;
	
	use namespace linda_ns;
	
	public class UIToggleBar extends Box implements IUILindaComp
	{
				
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _currentView : UIAdvancedButton;	
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIToggleBar()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			
		}

		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		protected function _onChildClick( e : Event ) : void
		{
			var button : UIAdvancedButton = UIAdvancedButton( e.currentTarget );
			// abort click if locked
			if ( button.locked ) {
				return;
			} 
			// toggle opened
			if ( _currentView != null ) {
				_currentView.toggle();	
			}
			// update
			_currentView = button;
			_currentView.toggle();
			// send event
			dispatchEvent( new UIEvent( UIEvent.CHANGE ) );
		}
		
		private function _onChildClose( e : Event ) : void
		{
			// if closed is selected > toggle nearest
			if ( _currentView == e.currentTarget ) {
				var index : uint = getChildIndex( DisplayObject( e.currentTarget ) );
				var next : DisplayObject = null;
				var prev : DisplayObject = null;
				try {
					next = getChildAt( index + 1 );
				} catch ( e : Error ) { }
				try {
					prev = getChildAt( index - 1 );
				} catch ( e : Error ) { }
				if ( next != null ) {
					_currentView = UIAdvancedButton( next );
				} else {
					if ( prev != null ) {
						_currentView = UIAdvancedButton( prev );
					} else {
						_currentView = null;
					}
				}
				if ( _currentView != null ) {
					// send event
					_currentView.toggle();
					dispatchEvent( new UIEvent( UIEvent.CHANGE ) );
				}				
			}
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function propagateProperties() : void
		{
			//
		}
		
		override public function addChild( child : DisplayObject ) : DisplayObject
		{
			if ( child is UIAdvancedButton && UIAdvancedButton( child ).toggable ) {
				child.addEventListener( MouseEvent.CLICK, _onChildClick );
				//child.addEventListener( UIEvent.CLOSE, _onChildClose );
			}
			return super.addChild( child );
		}
		
		override public function addChildAt( child : DisplayObject, index : int ) : DisplayObject
		{
			if ( child is UIAdvancedButton && UIAdvancedButton( child ).toggable ) {
				child.addEventListener( MouseEvent.CLICK, _onChildClick );
				//child.addEventListener( UIEvent.CLOSE, _onChildClose );
			}
			return super.addChildAt( child, index );
		}
		
		//TODO add removeChild and removeChildren methods
		
		override public function removeChild( child : DisplayObject ) : DisplayObject
		{
			// if closed is selected > toggle nearest
			if ( _currentView == child ) {
				var index : uint = getChildIndex( child );
				var next : DisplayObject = null;
				var prev : DisplayObject = null;
				try {
					next = getChildAt( index + 1 );
				} catch ( e : Error ) { }
				try {
					prev = getChildAt( index - 1 );
				} catch ( e : Error ) { }
				if ( next != null && next is UIAdvancedButton ) {
					_currentView = UIAdvancedButton( next );
				} else {
					if ( prev != null && prev is UIAdvancedButton ) {
						_currentView = UIAdvancedButton( prev );
					} else {
						_currentView = null;
					}
				}
				if ( _currentView != null ) {
					// send event
					_currentView.toggle();
				}				
			}
			var result : DisplayObject = super.removeChild( child );
			dispatchEvent( new UIEvent( UIEvent.CHANGE ) );
			return result;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get currentView() : UIAdvancedButton
		{
			return _currentView;
		}
		
		public function set currentView( value : UIAdvancedButton ) : void
		{
			_currentView = value;
		}
	
	}
}