package com.mutado.linda.controls.DockableCanvas
{
	import com.mutado.linda.controls.TabButton.TabButton;
	import com.mutado.linda.controls.ToggleBar.ToggleBar;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.events.UIEvent;
	import com.mutado.linda.interfaces.IUILindaComp;
	import com.mutado.linda.interfaces.IUITab;
	import com.mutado.linda.interfaces.IUITabbable;
	import com.mutado.linda.util.UIPosition;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.BoxDirection;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.events.FlexEvent;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/TabStyles.as"
	include "../../../../../../metadata/styles/ContentStyles.as"
	include "../../../../../../metadata/styles/DockStyles.as"

	public class UIDockableCanvas extends Canvas implements IUILindaComp
	{
			
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _position : String;
		private var _collapsable : Boolean = true;
		private var _tabClosable : Boolean = false;
		
		private var _vbox : VBox;
		private var _top : Canvas;
		private var _arrow : Canvas;
		private var _tabs : ToggleBar;
		private var _content : Canvas;
		private var _initialized : Boolean;
		
		private var _currentView : IUITabbable;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIDockableCanvas()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init( e : FlexEvent = null ) : void
		{
			_vbox = new VBox();
			_vbox.percentHeight = 100;
			_vbox.percentWidth = 100;
			_top = new Canvas();
			_top.height = 12;
			_top.percentWidth = 100;
			_tabs = new ToggleBar();
			_tabs.direction = BoxDirection.HORIZONTAL;
			_tabs.percentWidth = 100;
			_tabs.addEventListener( UIEvent.CHANGE, _onTabChange );
			_content = new Canvas();
			_content.horizontalScrollPolicy = "off";
			_content.verticalScrollPolicy = "off";
			_content.percentWidth = 100;
			_content.percentHeight = 100;
			
			_vbox.addChild( _top );
			_vbox.addChild( _tabs );
			_vbox.addChild( _content );
			
			addChild( _vbox );
			
			_initialized = true;
			
			addEventListener( FlexEvent.CREATION_COMPLETE, _onComplete );
		}
		
		private function _updatePosition() : void
		{
			styleName = position;
			_arrow = new Canvas();
			_arrow.styleName = "arrow" + position;
			_arrow.percentHeight = 100;
			_arrow.width = 14;
			var hb : HBox = new HBox();
			hb.percentHeight = 100;
			hb.percentWidth = 100;
			var tc : Canvas = new Canvas();
			tc.percentWidth = 100;
			tc.percentHeight = 100;
			if ( position == UIPosition.LEFT ) {
				hb.addChild( _arrow );
				hb.addChild( tc );	
			} else {
				hb.addChild( tc );
				hb.addChild( _arrow );
			}
			_top.removeAllChildren();
			_top.addChild( hb );
		}
		
		private function _updateCollapsable() : void
		{
			if ( !_collapsable ) {
				_vbox.removeChild( _top );	
			} else {
				_vbox.addChild( _top );
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onComplete( e : Event ) : void
		{
			if ( _tabs.numChildren > 0 ) {
				TabButton( _tabs.getChildAt( 0 ) ).simulateClick();
			}
		}
		
		private function _onTabChange( e : Event ) : void
		{
			if ( _currentView != null ) {
				_currentView.hide();	
			}	
			if ( _tabs.currentView != null ) {
				_currentView = IUITab( _tabs.currentView ).targetUI; 
				_currentView.show();	
			}
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			_vbox.styleName = getStyle( "dockBoxStyleName" );
			_top.styleName = getStyle( "dockTopStyleName" );
			_tabs.styleName = getStyle( "dockTabsStyleName" );
			_content.styleName = getStyle( "contentStyleName" );
			if ( getStyle( "contentStyleName" ) != null ) {
				_content.styleName = getStyle( "contentStyleName" );
			}
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function propagateProperties() : void
		{
			// TODO	propagateProperties
		}
		
		override public function addChild( child : DisplayObject ) : DisplayObject 
		{
			if ( _initialized  == true ) {
				if ( child is IUITabbable ) {
					var tabbable : IUITabbable = IUITabbable( child );
					var tab : TabButton = new TabButton();
					tab.labelPosition = UIPosition.RIGHT;
					tab.toggable = true;
					tab.closable = tabClosable;
					tab.targetUI = tabbable;
					tab.label = tabbable.label;
					tabbable.tabUI = tab;
					if ( getStyle( "tabButtonStyleName" ) != null ) {
						tab.setStyle( "tabButtonStyleName", getStyle( "tabButtonStyleName" ) );
						//tab.styleName = getStyle( "tabButtonStyleName" );
					}
					if ( getStyle( "tabButtonSelectedStyleName" ) != null ) {
						tab.setStyle( "tabButtonSelectedStyleName", getStyle( "tabButtonSelectedStyleName" ) );
					}
					_tabs.addChild( tab );
				}
				return _content.addChild( child );
			}
			return super.addChild( child );
		}
		
		override public function removeChild( child : DisplayObject ) : DisplayObject
		{
			if ( _initialized ) {
				/*if ( child is IUITabbable ) {
					_tabs.removeChild( DisplayObject( IUITabbable( child ).tabUI ) );
				}*/
				return _content.removeChild( child );
			}
			return super.removeChild( child );
		}
		
		override public function getChildByName( name : String ) : DisplayObject
		{
			if ( _initialized ) {
				return _content.getChildByName( name );
			}
			return super.getChildByName( name );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get currentView() : IUITabbable
		{
			return _currentView;	
		}
		
		public function set position( dir : String ) : void
		{
			_position = dir;
			_updatePosition();
		}
		
		public function get position() : String
		{
			return _position;
		}
		
		public function set collapsable( flag : Boolean ) : void
		{
			_collapsable = flag;
			_updateCollapsable();
		}
		
		public function get collapsable() : Boolean
		{
			return _collapsable;
		}
		
		public function set tabClosable( flag : Boolean ) : void
		{
			_tabClosable = flag;
		}
		
		public function get tabClosable() : Boolean
		{
			return _tabClosable;
		}
		
	}
}