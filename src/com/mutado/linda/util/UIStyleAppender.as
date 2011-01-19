package com.mutado.linda.util
{
	import com.mutado.alice.abstract.Abstract;
	
	import mx.core.UIComponent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	public class UIStyleAppender
	{
		private static var PROPERTIES : Array	= [
			"fontSize", 
			"color", 
			"fontWeight", 
			"fontFamily",
			"fontStyle",
			"backgroundImage",
			"backgroundSize",
			"tabVerticalOverlap",
			"tabClosePaddingRight",
			"customShadowColor",
			"customShadowAlpha",
			"paddingTop",
			"paddingBottom",
			"paddingRight",
			"paddingLeft"
		];
		
		public static function appendStyle( target : UIComponent, declaration : String ) : void
		{
			var style : CSSStyleDeclaration = UIStyleDeclaration.styleDeclaration( declaration );
			if ( style != null ) {
				for ( var index : *  in PROPERTIES ) {
					var property : String = PROPERTIES[index];
					var value : * = style.getStyle( property );
					if ( value != null ) {
						target.setStyle( property, style.getStyle( property ) );	
					}
				}	
			}
		}

	}
}