package com.mutado.linda.interfaces
{		
	public interface IUITab extends IUIButton
	{
		function close() : void;
		function set targetUI( value : IUITabbable ) : void;
		function get targetUI() : IUITabbable;
		function set closable( value : Boolean ) : void;
		function get closable() : Boolean;
	}
}