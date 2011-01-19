package com.mutado.linda.util
{
	import mx.styles.CSSStyleDeclaration;
	import mx.core.*;

	public class UIStyleDeclaration
	{		
		public static function styleDeclaration( declaration : String ) : CSSStyleDeclaration
		{
			VERSION::SDK4 {
				return mx.core.FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration( "." + declaration );
			}
			VERSION::SDK3 {
				return StyleManager.getStyleDeclaration( "." + declaration );
			}
		}		
	}
	
}