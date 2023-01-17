with Text_IO;
use Text_IO;
with Ada.Characters;
with System;

procedure hello is
type String_Access is access all String;
      s : aliased string := "" & ASCII.NUL;
      s0 : constant String_Access := s'Access;
begin
   Put_Line("Hello world!");
   Put_Line("address'Size=" & integer'image(s0'Size));
   Put_Line("address'Size=" & integer'image(Standard'Address_Size));
   Put_Line("Max_Priority=" & integer'image(System.Max_Priority));
end hello;
