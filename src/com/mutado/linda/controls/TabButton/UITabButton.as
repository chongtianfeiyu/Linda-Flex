package com.mutado.linda.controls.TabButton
{
	import com.mutado.alice.log.Logger;
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.controls.IconButton.IconButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.events.UIEvent;
	import com.mutado.linda.interfaces.IUITab;
	import com.mutado.linda.interfaces.IUITabbable;
	import com.mutado.linda.util.UIPosition;
	import com.mutado.linda.util.UIStyleAppender;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.events.FlexEvent;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/TabStyles.as"
	include "../../../../../../metadata/styles/BorderStyles.as"
	
	public class UITabButton extends UIAdvancedButton implements IUITab
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _normalStyleName : String;
		private var _selectedStyleName : String;
		private var _tabVerticalOverlap : Object;
		private var _closable : Boolean;
		private var _targetUI : IUITabbable;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UITabButton()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			addEventListener( FlexEvent.CREATION_COMPLETE, _onComplete );
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			if ( iconUI == null && closable ) {
				setStyle( "paddingRight", getStyle( "tabClosePaddingRight" ) );
				iconUI = new IconButton();
				iconUI.styleName = getStyle( "tabCloseStyleName" );
				labelPosition = UIPosition.LEFT;
				iconUI.addEventListener( MouseEvent.CLICK, _onCloseClick );
				iconUI.mouseChildren = false;	
			}		
			
			if ( getStyle( "tabButtonStyleName" ) != null ) {
				_normalStyleName = getStyle( "tabButtonStyleName" );	
			}
			 
			if ( getStyle( "tabButtonSelectedStyleName" ) != null ) {
				_selectedStyleName = getStyle( "tabButtonSelectedStyleName" );
			}
				
			if ( getStyle( "tabVerticalOverlap" ) != null ) {
				_tabVerticalOverlap = getStyle( "tabVerticalOverlap" );	
			}
			
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.blurX = 0;
			shadow.blurY = 0;
			shadow.angle = 0;
			shadow.quality = 1;
			shadow.distance = 1;
			shadow.strength= 100;
			shadow.color = getStyle("borderShadowColor");
			shadow.alpha = getStyle("borderShadowAlpha");
			filters = [ shadow ];
			
			super.commitProperties();
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onCloseClick( e : MouseEvent ) : void
		{
			if ( !targetUI.preventClosing ) {
				close();
			} else {
				targetUI.closing();
			}
		}
		
		private function _onComplete( e : Event ) : void
		{
			simulateClick();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function close() : void
		{
			if ( parent != null ) {
				parent.removeChild( this );
			}
			targetUI.close()
			//dispatchEvent( new UIEvent( UIEvent.CLOSE ) );
			locked = true;
		}
		
		override public function toggle() : void
		{ 
			if ( styleName == _selectedStyleName ) {
				locked = false;
				styleName = _normalStyleName;
				UIStyleAppender.appendStyle( this, getStyle( "tabButtonCustomStyleName" ) );
				height = height - Number( _tabVerticalOverlap != null ? _tabVerticalOverlap : 0 );
			} else {
				locked = true;
				styleName = _selectedStyleName;
				UIStyleAppender.appendStyle( this, getStyle( "tabButtonCustomSelectedStyleName" ) );
				height = height + Number( _tabVerticalOverlap != null ? _tabVerticalOverlap : 0 );
				out();
			}
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function set targetUI( value : IUITabbable ) : void
		{
			_targetUI = value;
		}
		
		public function get targetUI() : IUITabbable 
		{
			return _targetUI;
		}
		
		public function set closable( value : Boolean ) : void
		{
			_closable = value;
		}
		
		public function get closable() : Boolean
		{
			return _closable;
		}
	}
	
}