package com.mutado.linda.controls.ThumbButton
{
	import com.mutado.linda.containers.UIAdvancedButton;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.util.UIPosition;
	
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ThumbStyles.as"
	
	public class UIThumbButton extends UIAdvancedButton
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _source : Object;
		private var _container : UIComponent;
		private var _thumbUI : Image;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIThumbButton()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			labelPosition = UIPosition.BOTTOM;
			container = new Canvas();
			addEventListener( FlexEvent.CREATION_COMPLETE, _onComplete );
			addEventListener( ChildExistenceChangedEvent.CHILD_REMOVE, _onChildRemove );
		}
		
		private function _swapThumb() : void
		{
			if ( boxUI != null ) {
				if ( _thumbUI == null ) {
					_thumbUI = new Image();
					container.addChild( _thumbUI );
					boxUI.addChildAt( container, 0 );
					_thumbUI.percentWidth = 100;
					_thumbUI.percentHeight = 100;
					_thumbUI.setStyle( "verticalAlign", "middle" );
					_thumbUI.setStyle( "horizontalAlign", "center" );
					_buildShadow();					
				}
				_thumbUI.source = "";
				_thumbUI.source = null;
				_thumbUI.source = source;
			}
		}
		
		private function _buildShadow() : void
		{
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.blurX = 5;
			shadow.blurY = 5;
			shadow.angle = 90;
			shadow.quality = 1;
			shadow.distance = 1;
			shadow.color = getStyle("customShadowColor");
			shadow.alpha = getStyle("customShadowAlpha");
			_thumbUI.filters = [ shadow ];
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onComplete( e : Event ) : void
		{
			_swapThumb();			
		}
		
		private function _onChildRemove( e : Event ) : void 
		{	
			if ( _thumbUI != null ) {
				_thumbUI.source = "";
			}
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void 
		{
			container.styleName = getStyle( "thumbStyleName" );
			super.commitProperties();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
	
		public function set container( value : UIComponent ) : void
		{
			_container = value;
		}	
				
		public function get container() : UIComponent
		{
			return _container;
		}
		
		public function set source( value : Object ) : void
		{
			_source = value;
			_swapThumb();
		}
		
		public function get source() : Object
		{
			return _source;
		}
				
	}
}