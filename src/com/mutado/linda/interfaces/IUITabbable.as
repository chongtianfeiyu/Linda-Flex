package com.mutado.linda.interfaces
{	
	public interface IUITabbable
	{
		function show() : void;
		function hide() : void;
		function close() : void;
		function closing() : void;
		function set preventClosing( value : Boolean ) : void;
		function get preventClosing() : Boolean;
		function set label( value : String ) : void;
		function get label() : String;
		function set tabUI( value : IUITab ) : void;
		function get tabUI() : IUITab;
	}
}