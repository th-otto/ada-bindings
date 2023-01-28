pragma No_Strict_Aliasing;

package body Atari.Aes.Form is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Run(
            tree      : Objects.Object_Ptr;
            StartObj  : int16)
           return int16 is
begin
	aes_control.opcode := 50;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := StartObj;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Dial(
            Flag      : int16;
            Sx        : int16;
            Sy        : int16;
            Sw        : int16;
            Sh        : int16;
            Bx        : int16;
            By        : int16;
            Bw        : int16;
            Bh        : int16)
           return int16 is
begin
	aes_control.opcode := 51;
	aes_control.num_intin := 9;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Flag;
	aes_intin(1) := Sx;
	aes_intin(2) := Sy;
	aes_intin(3) := Sw;
	aes_intin(4) := Sh;
	aes_intin(5) := Bx;
	aes_intin(6) := By;
	aes_intin(7) := Bw;
	aes_intin(8) := Bh;
	aes_trap;
	return aes_intout(0);
end;


function Dial(
            Flag      : int16;
            little    : in Rectangle;
            big       : in Rectangle)
           return int16 is
begin
	aes_control.opcode := 51;
	aes_control.num_intin := 9;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Flag;
	aes_intin(1) := little.g_x;
	aes_intin(2) := little.g_y;
	aes_intin(3) := little.g_w;
	aes_intin(4) := little.g_h;
	aes_intin(5) := big.g_x;
	aes_intin(6) := big.g_y;
	aes_intin(7) := big.g_w;
	aes_intin(8) := big.g_h;
	aes_trap;
	return aes_intout(0);
end;


function Alert(fo_adefbttn: int16; alertstr: const_chars_ptr) return int16 is
begin
	aes_control.opcode := 52;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := fo_adefbttn;
	aes_addrin(0) := alertstr.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Alert(fo_adefbttn: int16; alertstr: String) return int16 is
    c_str: constant String := alertstr & ASCII.NUL;
    adr: void_ptr := c_str(c_str'First)'Address;
begin
	return form_alert(fo_adefbttn, const_chars_ptr'Deref(adr'Address));
end;


function Error(
            ErrorCode : int16)
           return int16 is
begin
	aes_control.opcode := 53;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := ErrorCode;
	aes_trap;
	return aes_intout(0);
end;


-- form_xerr
function Error(
            ErrorCode : int32;
            filename: String)
           return int16 is
    c_str: String := filename & ASCII.NUL;
begin
	aes_control.opcode := 53;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := int16(Shift_Right(uint32(ErrorCode), 16));
	aes_intin(1) := int16(uint32(ErrorCode) and 16#ffff#);
	aes_addrin(0) := c_str'Address;
	aes_trap;
	return aes_intout(0);
end;

function Center(
            tree      : Objects.Object_Ptr;
            Cx        : out int16;
            Cy        : out int16;
            Cw        : out int16;
            Ch        : out int16)
           return int16 is
begin
	aes_control.opcode := 54;
	aes_control.num_intin := 0;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	Cx := aes_intout(1);
	Cy := aes_intout(2);
	Cw := aes_intout(3);
	Ch := aes_intout(4);
	return aes_intout(0);
end;


function Center(
            tree      : Objects.Object_Ptr;
            r         : out Rectangle)
           return int16 is
begin
	aes_control.opcode := 54;
	aes_control.num_intin := 0;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	r.g_x := aes_intout(1);
	r.g_y := aes_intout(2);
	r.g_w := aes_intout(3);
	r.g_h := aes_intout(4);
	return aes_intout(0);
end;


function Keybd(
            tree      : Objects.Object_Ptr;
            Kobject   : int16;
            Kobnext   : int16;
            Kchar     : int16;
            Knxtobject: out int16;
            Knxtchar  : out int16)
           return int16 is
begin
	aes_control.opcode := 55;
	aes_control.num_intin := 3;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Kobject;
	aes_intin(1) := Kobnext;
	aes_intin(2) := Kchar;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	Knxtobject := aes_intout(1);
	Knxtchar := aes_intout(2);
	return aes_intout(0);
end;


function Button(
            tree      : Objects.Object_Ptr;
            Bobject   : int16;
            Bclicks   : int16;
            Bnxtobj   : out int16)
           return int16 is
begin
	aes_control.opcode := 56;
	aes_control.num_intin := 2;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Bobject;
	aes_intin(1) := Bclicks;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	Bnxtobj := aes_intout(1);
	return aes_intout(0);
end;


end Atari.Aes.Form;
