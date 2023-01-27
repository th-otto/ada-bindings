pragma No_Strict_Aliasing;

package body Atari.Aes.Graf is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

procedure graf_rubberbox(
            Ix        : int16;
            Iy        : int16;
            Iw        : int16;
            Ih        : int16;
            Fw        : out int16;
            Fh        : out int16)
           is
begin
	aes_control.opcode := 70;
	aes_control.num_intin := 4;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Ix;
	aes_intin(1) := Iy;
	aes_intin(2) := Iw;
	aes_intin(3) := Ih;
	aes_trap;
	Fw := aes_intout(1);
	Fh := aes_intout(2);
end;


procedure graf_rubberbox(
            r         : in Rectangle;
            Fw        : out int16;
            Fh        : out int16)
           is
begin
	aes_control.opcode := 70;
	aes_control.num_intin := 4;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := r.g_x;
	aes_intin(1) := r.g_y;
	aes_intin(2) := r.g_w;
	aes_intin(3) := r.g_h;
	aes_trap;
	Fw := aes_intout(1);
	Fh := aes_intout(2);
end;


procedure graf_dragbox(
            Sw        : int16;
            Sh        : int16;
            Sx        : int16;
            Sy        : int16;
            Bx        : int16;
            By        : int16;
            Bw        : int16;
            Bh        : int16;
            Fw        : out int16;
            Fh        : out int16)
           is
begin
	aes_control.opcode := 71;
	aes_control.num_intin := 8;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Sx;
	aes_intin(1) := Sy;
	aes_intin(2) := Sw;
	aes_intin(3) := Sh;
	aes_intin(4) := Bx;
	aes_intin(5) := By;
	aes_intin(6) := Bw;
	aes_intin(7) := Bh;
	aes_trap;
	Fw := aes_intout(1);
	Fh := aes_intout(2);
end;


procedure graf_dragbox(
            little    : in Rectangle;
            big       : in Rectangle;
            Fw        : out int16;
            Fh        : out int16)
           is
begin
	aes_control.opcode := 71;
	aes_control.num_intin := 8;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := little.g_x;
	aes_intin(1) := little.g_y;
	aes_intin(2) := little.g_w;
	aes_intin(3) := little.g_h;
	aes_intin(4) := big.g_x;
	aes_intin(5) := big.g_y;
	aes_intin(6) := big.g_w;
	aes_intin(7) := big.g_h;
	aes_trap;
	Fw := aes_intout(1);
	Fh := aes_intout(2);
end;


procedure graf_movebox(
            Sw        : int16;
            Sh        : int16;
            Sx        : int16;
            Sy        : int16;
            Dx        : int16;
            Dy        : int16)
           is
begin
	aes_control.opcode := 72;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Sx;
	aes_intin(1) := Sy;
	aes_intin(2) := Sw;
	aes_intin(3) := Sh;
	aes_intin(4) := Dx;
	aes_intin(5) := Dy;
	aes_trap;
end;


procedure graf_movebox(
                r         : in grect;
                Dx        : int16;
                Dy        : int16)
               is
begin
	aes_control.opcode := 72;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := r.g_x;
	aes_intin(1) := r.g_y;
	aes_intin(2) := r.g_w;
	aes_intin(3) := r.g_h;
	aes_intin(4) := Dx;
	aes_intin(5) := Dy;
	aes_trap;
end;


procedure graf_growbox(
            Sx        : int16;
            Sy        : int16;
            Sw        : int16;
            Sh        : int16;
            Fx        : int16;
            Fy        : int16;
            Fw        : int16;
            Fh        : int16)
           is
begin
	aes_control.opcode := 73;
	aes_control.num_intin := 8;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Sx;
	aes_intin(1) := Sy;
	aes_intin(2) := Sw;
	aes_intin(3) := Sh;
	aes_intin(4) := Fx;
	aes_intin(5) := Fy;
	aes_intin(6) := Fw;
	aes_intin(7) := Fh;
	aes_trap;
end;


procedure graf_growbox(
            little    : in Rectangle;
            big       : in Rectangle)
           is
begin
	aes_control.opcode := 73;
	aes_control.num_intin := 8;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := little.g_x;
	aes_intin(1) := little.g_y;
	aes_intin(2) := little.g_w;
	aes_intin(3) := little.g_h;
	aes_intin(4) := big.g_x;
	aes_intin(5) := big.g_y;
	aes_intin(6) := big.g_w;
	aes_intin(7) := big.g_h;
	aes_trap;
end;


procedure graf_shrinkbox(
            Fx        : int16;
            Fy        : int16;
            Fw        : int16;
            Fh        : int16;
            Sx        : int16;
            Sy        : int16;
            Sw        : int16;
            Sh        : int16)
           is
begin
	aes_control.opcode := 74;
	aes_control.num_intin := 8;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Fx;
	aes_intin(1) := Fy;
	aes_intin(2) := Fw;
	aes_intin(3) := Fh;
	aes_intin(4) := Sx;
	aes_intin(5) := Sy;
	aes_intin(6) := Sw;
	aes_intin(7) := Sh;
	aes_trap;
end;


procedure graf_shrinkbox(
            big       : in Rectangle;
            little    : in Rectangle)
           is
begin
	aes_control.opcode := 74;
	aes_control.num_intin := 8;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := big.g_x;
	aes_intin(1) := big.g_y;
	aes_intin(2) := big.g_w;
	aes_intin(3) := big.g_h;
	aes_intin(4) := little.g_x;
	aes_intin(5) := little.g_y;
	aes_intin(6) := little.g_w;
	aes_intin(7) := little.g_h;
	aes_trap;
end;


function graf_watchbox(
            tree      : Objects.Object_Ptr;
            Obj       : int16;
            InState   : int16;
            OutState  : int16)
           return int16 is
begin
	aes_control.opcode := 75;
	aes_control.num_intin := 4;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	aes_intin(1) := Obj;
	aes_intin(2) := InState;
	aes_intin(3) := OutState;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function graf_slidebox(
            tree      : Objects.Object_Ptr;
            Parent    : int16;
            Obj       : int16;
            Direction : int16)
           return int16 is
begin
	aes_control.opcode := 75;
	aes_control.num_intin := 4;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Parent;
	aes_intin(1) := Obj;
	aes_intin(2) := Direction;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function graf_handle(
            Wchar     : out int16;
            Hchar     : out int16;
            Wbox      : out int16;
            Hbox      : out int16)
           return int16 is
begin
	aes_control.opcode := 77;
	aes_control.num_intin := 0;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	Wchar := aes_intout(1);
	Hchar := aes_intout(2);
	Wbox := aes_intout(3);
	Hbox := aes_intout(4);
	return aes_intout(0);
end;


function graf_handle(
            Wchar     : out int16;
            Hchar     : out int16;
            Wbox      : out int16;
            Hbox      : out int16;
            device    : out int16)
           return int16 is
begin
	aes_control.opcode := 77;
	aes_control.num_intin := 0;
	aes_control.num_intout := 6;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	Wchar := aes_intout(1);
	Hchar := aes_intout(2);
	Wbox := aes_intout(3);
	Hbox := aes_intout(4);
	device := aes_intout(5);
	return aes_intout(0);
end;


procedure graf_mouse(
            Form       : Mouse_Type;
            FormAddress: MFORM_const_ptr := null)
           is
begin
	aes_control.opcode := 78;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Form'Enum_Rep;
	aes_addrin(0) := FormAddress.all'Address;
	aes_trap;
end;


procedure graf_mkstate(
            Mx         : out int16;
            My         : out int16;
            ButtonState: out int16;
            KeyState   : out int16) is
begin
	aes_control.opcode := 79;
	aes_control.num_intin := 0;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	Mx := aes_intout(1);
	My := aes_intout(1);
	ButtonState := aes_intout(1);
	KeyState := aes_intout(1);
end;


function graf_multirubber(
            bx        : int16;
            by        : int16;
            minw      : int16;
            minh      : int16;
            rec       : Rectangle_Ptr;
            rw        : out int16;
            rh        : out int16)
           return int16 is
begin
	aes_control.opcode := 69;
	aes_control.num_intin := 4;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := bx;
	aes_intin(1) := by;
	aes_intin(2) := minw;
	aes_intin(3) := minh;
	aes_addrin(0) := rec.all'Address;
	aes_trap;
	rw := aes_intout(1);
	rh := aes_intout(2);
	return aes_intout(0);
end;



end Atari.Aes.Graf;
