package com.mutado.linda.containers
{

	import com.mutado.alice.log.Logger;
	import com.mutado.linda.controls.ShadowedLabel.ShadowedLabel;
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUIButton;
	import com.mutado.linda.interfaces.IUILindaComp;
	import com.mutado.linda.util.UIPosition;
	import com.mutado.linda.util.UIStyleAppender;
	import com.mutado.linda.util.UIStyleDeclaration;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import mx.containers.Box;
	import mx.containers.BoxDirection;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../metadata/styles/ShadowStyles.as"
	include "../../../../../metadata/styles/IconStyles.as"
	include "../../../../../metadata/styles/ButtonStyles.as"
	
	public class UIAdvancedButton extends Box implements IUILindaComp, IUIButton
	{
				
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
			
		private var _labelPosition : String;
		private var _boxUI : Box;
		private var _labelUI : ShadowedLabel;
		private var _iconUI : UIComponent;
		private var _toggleUI : UIComponent;
		private var _toggable : Boolean = false;
		private var _autoclick : Boolean = false;
		private var _toggleStyle : String;
		private var _hover : Boolean;
		private var _locked : Boolean;
		private var _press : Boolean;
		private var _multiline : Boolean;
		private var _selected : Boolean;
		private var _label : String;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIAdvancedButton()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_selected = false;
			setStyle( "disabledOverlayAlpha", 0 );
			setStyle( "verticalGap", 0 );
			setStyle( "horizontalGap", 0 );
			addEventListener( MouseEvent.MOUSE_OVER, _onOver );
			addEventListener( MouseEvent.MOUSE_OUT, _onOut );
			addEventListener( MouseEvent.MOUSE_DOWN, _onDown );
			addEventListener( MouseEvent.MOUSE_UP, _onUp );
			addEventListener( MouseEvent.CLICK, _onClick );
			addEventListener( FlexEvent.CREATION_COMPLETE, _onComplete );
		}
		
		private function _toggle() : void
		{
			if ( !_toggable || ( _toggleUI == null && _toggleStyle == null) ) return;
			if ( _toggleUI != null ) {
				_toggleUI.visible = _toggleUI.visible ? false : true;	
			}
			if ( _toggleStyle != null ) {
				styleName = styleName == _toggleStyle ? null : _toggleStyle; 
			}
			_selected = !_selected;				
		}
		
		private function _updateLabelPosition() : void
		{
			
		}
		
		private function _updateLabelText() : void
		{
			if ( _labelUI != null ) {
				_labelUI.text = label;	
			}
		}
		
		private function _updateVisibility( value : Boolean = true ) : void
		{
			buttonMode = enabled;
			mouseEnabled = enabled;
			var color:ColorTransform = new ColorTransform();
			if ( !value ) {
				color.redOffset   = -80;
				color.greenOffset = -80;
				color.blueOffset  = -80;
			} else {
				color.redOffset   = 0;
				color.greenOffset = 0;
				color.blueOffset  = 0;
			}
			transform.colorTransform = color;
			if ( !value ) {
				alpha = .4;
			} else {
				alpha = 1;
			}
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			
			if ( _toggleUI == null && _toggable ) { 
				var declaration : String = getStyle( "buttonToggleStyle" ) != null ?  getStyle( "buttonToggleStyle" ) : null;
				var Toggle : Class = declaration != null ? UIStyleDeclaration.styleDeclaration( "." + declaration ).getStyle( "buttonToggleImage" ) : null;
				if ( Toggle != null ) {
					var togg : DisplayObject = new Toggle() as DisplayObject; 
					var toggComp : UIComponent = new UIComponent();
					toggComp.addChild( togg );
					addChild( toggComp );	
					_toggleUI = toggComp;
					_toggleUI.visible = false;
				}
				_toggleStyle = getStyle( "buttonToggleStyle" );
			}
			
			if ( _iconUI == null ) {
				var Icon : Class = getStyle( "iconImage" );
				if ( Icon != null ) {
					var icon : DisplayObject = new Icon() as DisplayObject; 
					var iconComp : UIComponent = new UIComponent();
					iconComp.addChild( icon );
					_iconUI = iconComp;
					_iconUI.width = icon.width;
					_iconUI.height = icon.height;
				}	
			}
					
			if ( _labelUI == null && ( label != null || _labelPosition != null ) ) {
				_labelUI = new ShadowedLabel();
				_labelUI.text = label;
				if ( multiline ) {
					_labelUI.percentWidth = 100;
				} 
				_labelUI.mouseEnabled = false;
				_labelUI.mouseChildren = false;
			}
			
			// update inerithed properties
			propagateProperties();
			
			if ( _boxUI == null ) {
				var spacing : Number = getStyle( "iconSpacing" );
				_boxUI = new Box();
				_boxUI.setStyle( "verticalGap",  spacing ? spacing : 0 );
				_boxUI.setStyle( "horizontalGap", spacing ? spacing : 0 );
				_boxUI.setStyle( "horizontalAlign", "center" );
				_boxUI.setStyle( "verticalAlign", "middle" );
				_boxUI.mouseEnabled = false;
			}
			
			if ( _labelUI != null && multiline ) {
				_boxUI.percentWidth = 100;
			}
			
			if ( !contains(  _boxUI ) ) {
				switch ( _labelPosition ) {
					case UIPosition.LEFT :
						_boxUI.direction = BoxDirection.HORIZONTAL;
						_boxUI.addChild( _labelUI );
						_iconUI != null ? _boxUI.addChild( _iconUI ) : null;
					break;
					
					case UIPosition.RIGHT :
						_boxUI.direction = BoxDirection.HORIZONTAL;
						_iconUI != null ? _boxUI.addChild( _iconUI ) : null;
						_boxUI.addChild( _labelUI );
					break;
					
					case UIPosition.TOP :
						_boxUI.direction = BoxDirection.VERTICAL;
						_boxUI.addChild( _labelUI );
						_iconUI != null ? _boxUI.addChild( _iconUI ) : null;
					break;
					
					case UIPosition.BOTTOM :
						_boxUI.direction = BoxDirection.VERTICAL;
						_iconUI != null ? _boxUI.addChild( _iconUI ) : null;
						_boxUI.addChild( _labelUI );
					break;
					
					default:
						_iconUI != null ? _boxUI.addChild( _iconUI ) : null;				
				}
				addChild( _boxUI );
			}
		} 
		
		protected function over() : void
		{
			var color : ColorTransform = new ColorTransform();
			color.redOffset   = +35;
			color.greenOffset = +35;
			color.blueOffset  = +35;
			transform.colorTransform = color;
		}
		
		protected function out() : void
		{
			var color : ColorTransform = new ColorTransform();
			color.redOffset   = 0;
			color.greenOffset = 0;
			color.blueOffset  = 0;
			transform.colorTransform = color;
		}
		
		protected function down() : void
		{
			out();
			var color : ColorTransform = new ColorTransform();
			color.redOffset   = -75;
			color.greenOffset = -75;
			color.blueOffset  = -75;
			transform.colorTransform = color;
		}
		
		protected function up() : void
		{
			var color : ColorTransform = new ColorTransform();
			color.redOffset   = 0;
			color.greenOffset = 0;
			color.blueOffset  = 0;
			transform.colorTransform = color;
			if ( hover ) {
				over();	
			}
		}
		
		protected function outside() : void
		{
			out();
			up();
		}
		
		protected function click() : void
		{
			Logger.INFO( this + ".click() is not implemented!" );			
		}
		
		protected function get hover() : Boolean
		{
			return _hover;
		}
		
		protected function set hover( value : Boolean ) : void
		{
			_hover = value;
		}
		
		protected function get press() : Boolean
		{
			return _press;
		}
		
		protected function set press( value : Boolean ) : void
		{
			_press = value;
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onComplete( e : Event ) : void
		{
			removeEventListener( FlexEvent.CREATION_COMPLETE, _onComplete );
			if ( autoclick ) {
				simulateClick();
				autoclick = false;
			}
		}
		
		private function _onOver( e : Event ) : void
		{
			if ( locked ) return;
			hover = true;
			if ( !press ) {
				over();
			}
		}
		
		private function _onOut( e : Event ) : void
		{
			if ( locked ) return;
			hover = false;
			out();
			if ( press ) {
				try {
					e.target.stage.addEventListener( MouseEvent.MOUSE_UP, _onOutside );
				} catch( e : Error ) { }
			}
		}
		
		private function _onDown( e : Event ) : void
		{
			if ( locked ) return;
			press = true;
			down();
		}
		
		private function _onUp( e : Event ) : void
		{
			if ( locked ) return;
			press = false;
			up();
		}
		
		private function _onOutside( e : Event ) : void
		{
			press = false;
			outside();
			try {
				stage.removeEventListener( MouseEvent.MOUSE_UP, _onOutside );
			} catch ( e : Error ) { }
		}
		
		private function _onClick( e : Event ) : void
		{
			if ( locked ) return;
			click();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function propagateProperties() : void
		{
			var props : Array = [
				"color",
				"textAlign",
				"fontStyle",
				"fontWeight",
				"fontSize",
				"customShadowColor",
				"customShadowAlpha",
				"verticalAlign",
				"horizontalAlign"
			];
			
			for ( var i : uint = 0; i < props.length; i++ ) {
				if ( getStyle( props[ i ] ) != null ) {
					if ( _labelUI != null ) {
						_labelUI.setStyle( props[ i ], getStyle( props[ i ] ) );
					}  
				}
			}
		}
		
		public function simulateClick() : void
		{
			dispatchEvent( new MouseEvent( MouseEvent.CLICK ) );	
		}
		
		public function toggle() : void
		{
			_toggle();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function set labelPosition( dir : String ) : void
		{
			_labelPosition = dir;
			_updateLabelPosition();
		}
		
		public function get labelPosition() : String
		{
			return _labelPosition;
		}
		
		override public function get label() : String
		{
			return _label;
		}
		
		override public function set label( value : String ) : void
		{
			_label = value;
			_updateLabelText();
		}
		
		public function get toggable() : Boolean
		{
			return _toggable;
		}
		
		public function set toggable( value : Boolean ) : void
		{
			_toggable = value;
		}
		
		public function get autoclick() : Boolean
		{
			return _autoclick;
		}
		
		public function set autoclick( value : Boolean ) : void
		{
			_autoclick = value;
		}
		
		public function get locked() : Boolean
		{
			return _locked;
		}
		
		public function set locked( value : Boolean ) : void
		{
			_locked = value;
		}
		
		public function get multiline() : Boolean
		{
			return _multiline;
		}
		
		public function set multiline( value : Boolean ) : void
		{
			_multiline = value;
		}
		
		public function get isSelected() : Boolean
		{
			return _selected;
		}
		
		public function set isSelected( value : Boolean ) : void
		{
			_selected = value;
		}
		
		override public function set enabled( value : Boolean) : void
		{
			super.enabled = value;
			mouseEnabled = value;
			mouseChildren = value;
			_updateVisibility( value );
		}
		
		protected function get labelUI() : ShadowedLabel
		{
			return _labelUI;
		}
		
		protected function get boxUI() : Box
		{
			return _boxUI;
		}
		
		protected function set boxUI( value : Box ) : void
		{
			_boxUI = value;
		}
		
		protected function get iconUI() : UIComponent
		{
			return _iconUI;
		}
		
		protected function set iconUI( value : UIComponent ) : void
		{
			_iconUI = value;
		}
		
	}
}