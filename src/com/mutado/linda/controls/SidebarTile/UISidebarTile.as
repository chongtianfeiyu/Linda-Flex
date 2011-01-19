package com.mutado.linda.controls.SidebarTile
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.events.UIEvent;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.containers.Tile;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ShadowStyles.as"
	
	public class UISidebarTile extends Tile implements IUILindaComp
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _currentView : UIAdvancedButton;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UISidebarTile()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			percentWidth = 100;
			//percentHeight = 100;	
		}
		
		private function _buildShadow() : void
		{
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.blurX = 0;
			shadow.blurY = 0;
			shadow.angle = 90;
			shadow.quality = 1;
			shadow.distance = 1;
			shadow.color = getStyle( "customShadowColor" );
			shadow.alpha = getStyle( "customShadowAlpha" );
			filters = [ shadow ];
		}
		
		private function _updateVisibility() : void
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
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			_buildShadow();
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
				child.addEventListener( UIEvent.CLOSE, _onChildClose );
			}
			return super.addChild( child );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		override public function set enabled( value : Boolean) : void
		{
			super.enabled = value;
			_updateVisibility();
		}
		
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