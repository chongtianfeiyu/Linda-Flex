package com.mutado.linda.interfaces
{	
	public interface IUIButton
	{
		function simulateClick() : void;
		function toggle() : void;
		function set labelPosition( dir : String ) : void;
		function get labelPosition() : String;		
		function get label() : String;
		function set label( value : String ) : void;
		function get toggable() : Boolean;
		function set toggable( value : Boolean ) : void;
		function get locked() : Boolean;		
		function set locked( value : Boolean ) : void;		
		function set enabled( value : Boolean) : void;
	}
}