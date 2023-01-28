pragma No_Strict_Aliasing;

package body Atari.Aes.Window is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Draw(
            WindowHandle: int16;
            startob     : int16)
           return int16 is
begin
	aes_control.opcode := 99;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := startob;
	aes_trap;
	return aes_intout(0);
end;


function Create(
            Parts     : int16;
            Wx        : int16;
            Wy        : int16;
            Ww        : int16;
            Wh        : int16)
           return int16 is
begin
	aes_control.opcode := 100;
	aes_control.num_intin := 5;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Parts;
	aes_intin(1) := Wx;
	aes_intin(2) := Wy;
	aes_intin(3) := Ww;
	aes_intin(4) := Wh;
	aes_trap;
	return aes_intout(0);
end;


function Create(
            Parts     : int16;
            r         : in Rectangle)
           return int16 is
begin
	return wind_create(Parts, r.g_x, r.g_y, r.g_w, r.g_h);
end;


-- wind_xcreate
function Create(
            Parts     : int16;
            Wx        : int16;
            Wy        : int16;
            Ww        : int16;
            Wh        : int16;
            OutX      : out int16;
            OutY      : out int16;
            OutW      : out int16;
            OutH      : out int16)
           return int16 is
begin
	aes_control.opcode := 100;
	aes_control.num_intin := 5;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Parts;
	aes_intin(1) := Wx;
	aes_intin(2) := Wy;
	aes_intin(3) := Ww;
	aes_intin(4) := Wh;
	aes_trap;
	OutX := aes_intout(1);
	OutY := aes_intout(2);
	OutW := aes_intout(3);
	OutH := aes_intout(4);
	return aes_intout(0);
end;


-- wind_xcreate
function Create(
            Parts     : int16;
            r         : in Rectangle;
            ret       : out Rectangle)
           return int16 is
begin
	return Create(Parts, r.g_x, r.g_y, r.g_w, r.g_h, ret.g_x, ret.g_y, ret.g_w, ret.g_h);
end;


function Open(
            WindowHandle: int16;
            Wx          : int16;
            Wy          : int16;
            Ww          : int16;
            Wh          : int16)
           return int16 is
begin
	aes_control.opcode := 101;
	aes_control.num_intin := 5;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := Wx;
	aes_intin(2) := Wy;
	aes_intin(3) := Ww;
	aes_intin(4) := Wh;
	aes_trap;
	return aes_intout(0);
end;


function Open(
            WindowHandle: int16;
            r           : in Rectangle)
           return int16 is
begin
	return wind_open(WindowHandle, r.g_x, r.g_y, r.g_w, r.g_h);
end;


function Close(
            WindowHandle: int16)
           return int16 is
begin
	aes_control.opcode := 102;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_trap;
	return aes_intout(0);
end;


function Delete(
            WindowHandle: int16)
           return int16 is
begin
	aes_control.opcode := 103;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_trap;
	return aes_intout(0);
end;


function Get(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : out int16;
            W2          : out int16;
            W3          : out int16;
            W4          : out int16)
           return int16 is
    ptr: void_ptr;
begin
	aes_control.opcode := 104;
	aes_control.num_intin := 2;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
	case What is
	   when WF_DCOLOR | WF_COLOR =>
	      aes_control.num_intin := 3;
	      --
	      -- strange binding for WF_DCOLOR & WF_COLOR use
	      -- output parameters also as input;
	      -- suppress warnings about it
	      --
Pragma Warnings(off);
 	      aes_intin(2) := W1;
Pragma Warnings(on);
	   when WF_INFO | WF_NAME =>
	      aes_control.num_intin := 4;
	      ptr := aes_intin(2)'Address;
	      void_ptr'Deref(ptr) := W1'Address;
 	      raise Standard'Abort_Signal with "use Get(String) instead";
	   when others =>
	       null;
	end case;
	aes_intout(3) := 0;
	aes_intout(4) := 0;

	aes_trap;

	case What is
	   when WF_INFO | WF_NAME =>
	       --  special case where W1 shall not be overwritten
	       null;
	   when others =>
	       W1 := aes_intout(1);
	       W2 := aes_intout(2);
	       W3 := aes_intout(3);
	       W4 := aes_intout(4);
	end case;
	return aes_intout(0);
end;


function Get(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : chars_ptr)
           return int16 is
    ptr: void_ptr;
begin
	aes_control.opcode := 104;
	aes_control.num_intin := 4;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
	case What is
	   when WF_INFO | WF_NAME =>
	      aes_control.num_intin := 4;
	      ptr := aes_intin(2)'Address;
	      void_ptr'Deref(ptr) := W1.all'Address;
	   when others =>
 	      raise Standard'Abort_Signal with "illegal mode for Get(String)";
	end case;
	aes_intout(3) := 0;
	aes_intout(4) := 0;

	aes_trap;

	case What is
	   when WF_INFO | WF_NAME =>
	       --  special case where W1 shall not be overwritten
	       null;
	   when others =>
	       null;
	end case;
	return aes_intout(0);
end;


function Get(
            WindowHandle: int16;
            What        : Action_Type;
            r           : out Rectangle)
           return int16 is
begin
	aes_control.opcode := 104;
	aes_control.num_intin := 2;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;

	aes_trap;

	r.g_x := aes_intout(1);
	r.g_y := aes_intout(2);
	r.g_w := aes_intout(3);
	r.g_h := aes_intout(4);
	return aes_intout(0);
end;


-- wind_xget
function Get(
            WindowHandle: int16;
            What        : Action_Type;
            clip        : in Rectangle;
            r           : out Rectangle)
           return int16 is
begin
	aes_control.opcode := 104;
	aes_control.num_intin := 6;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
	aes_intin(2) := clip.g_x;
	aes_intin(3) := clip.g_y;
	aes_intin(4) := clip.g_w;
	aes_intin(5) := clip.g_h;

	aes_trap;

	r.g_x := aes_intout(1);
	r.g_y := aes_intout(2);
	r.g_w := aes_intout(3);
	r.g_h := aes_intout(4);
	return aes_intout(0);
end;


function Get(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : out int16)
           return int16 is
    dummy: int16;
    dummy2: int16;
    dummy3: int16;
begin
	return wind_get(WindowHandle, what, W1, dummy, dummy2, dummy3);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : int16;
            W2          : int16;
            W3          : int16;
            W4          : int16)
           return int16 is
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
	aes_intin(2) := W1;
	aes_intin(3) := W2;
	aes_intin(4) := W3;
	aes_intin(5) := W4;

	aes_trap;

	return aes_intout(0);
end;



function Set(
            WindowHandle: int16;
            What        : Action_Type;
            r           : in Rectangle)
           return int16 is
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
	aes_intin(2) := r.g_x;
	aes_intin(3) := r.g_y;
	aes_intin(4) := r.g_w;
	aes_intin(5) := r.g_h;

	aes_trap;

	return aes_intout(0);
end;


-- wind_xset
function Set(
            WindowHandle: int16;
            What        : Action_Type;
            s           : in Rectangle;
            r           : out Rectangle)
           return int16 is
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
	aes_intin(2) := s.g_x;
	aes_intin(3) := s.g_y;
	aes_intin(4) := s.g_w;
	aes_intin(5) := s.g_h;

	aes_trap;

	r.g_x := aes_intout(1);
	r.g_y := aes_intout(2);
	r.g_w := aes_intout(3);
	r.g_h := aes_intout(4);
	return aes_intout(0);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            str         : const_chars_ptr)
           return int16 is
    ptr: void_ptr;
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
    ptr := aes_intin(2)'Address;
    const_chars_ptr'Deref(ptr) := str;
	aes_intin(4) := 0;
	aes_intin(5) := 0;

	aes_trap;

	return aes_intout(0);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : int16 := 0)
           return int16 is
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
	aes_intin(2) := W1;
	aes_intin(3) := 0;
	aes_intin(4) := 0;
	aes_intin(5) := 0;

	aes_trap;

	return aes_intout(0);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            v           : void_ptr;
            W3          : int16 := 0)
           return int16 is
    ptr: void_ptr;
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
    ptr := aes_intin(2)'Address;
    void_ptr'Deref(ptr) := v;
	aes_intin(4) := W3;
	aes_intin(5) := 0;

	aes_trap;

	return aes_intout(0);
end;


function Find(
            X         : int16;
            Y         : int16)
           return int16 is
begin
	aes_control.opcode := 106;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := X;
	aes_intin(1) := Y;

	aes_trap;

	return aes_intout(0);
end;


function Update(
            Code      : int16)
           return int16 is
begin
	aes_control.opcode := 107;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Code;

	aes_trap;

	return aes_intout(0);
end;


procedure Calc(
            c_Type    : int16;
            Parts     : int16;
            InX       : int16;
            InY       : int16;
            InW       : int16;
            InH       : int16;
            OutX      : out int16;
            OutY      : out int16;
            OutW      : out int16;
            OutH      : out int16)
           is
begin
	aes_control.opcode := 108;
	aes_control.num_intin := 6;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_Type;
	aes_intin(1) := Parts;
	aes_intin(2) := InX;
	aes_intin(3) := InY;
	aes_intin(4) := InW;
	aes_intin(5) := InH;

	aes_trap;

	OutX := aes_intout(1);
	OutY := aes_intout(2);
	OutW := aes_intout(3);
	OutH := aes_intout(4);
end;


procedure Calc(
            c_Type    : int16;
            Parts     : int16;
            c_In      : in Rectangle;
            c_Out     : out Rectangle)
           is
begin
	aes_control.opcode := 108;
	aes_control.num_intin := 6;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_Type;
	aes_intin(1) := Parts;
	aes_intin(2) := c_In.g_x;
	aes_intin(3) := c_In.g_y;
	aes_intin(4) := c_In.g_w;
	aes_intin(5) := c_In.g_h;

	aes_trap;

	c_Out.g_x := aes_intout(1);
	c_Out.g_y := aes_intout(2);
	c_Out.g_w := aes_intout(3);
	c_Out.g_h := aes_intout(4);
end;


--  procedure New is
--  begin
--  	aes_control.opcode := 109;
--  	aes_control.num_intin := 0;
--  	aes_control.num_intout := 0;
--  	aes_control.num_addrin := 0;
--  	aes_control.num_addrout := 0;
--  
--  	aes_trap;
--  end;



end Atari.Aes.Window;
