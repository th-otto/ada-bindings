pragma No_Strict_Aliasing;

package body Atari.Aes.Graf is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

procedure Rubber_Box(
            Ix        : Int16;
            Iy        : Int16;
            Iw        : Int16;
            Ih        : Int16;
            Fw        : out Int16;
            Fh        : out Int16)
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


procedure Rubber_Box(
            r         : in Rectangle;
            Fw        : out Int16;
            Fh        : out Int16)
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


procedure Drag_Box(
            Sw        : Int16;
            Sh        : Int16;
            Sx        : Int16;
            Sy        : Int16;
            Bx        : Int16;
            By        : Int16;
            Bw        : Int16;
            Bh        : Int16;
            Fw        : out Int16;
            Fh        : out Int16)
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


procedure Drag_Box(
            little    : in Rectangle;
            big       : in Rectangle;
            Fw        : out Int16;
            Fh        : out Int16)
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


procedure Move_Box(
            Sw        : Int16;
            Sh        : Int16;
            Sx        : Int16;
            Sy        : Int16;
            Dx        : Int16;
            Dy        : Int16)
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


procedure Move_Box(
                r         : in Rectangle;
                Dx        : Int16;
                Dy        : Int16)
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


procedure Grow_Box(
            Sx        : Int16;
            Sy        : Int16;
            Sw        : Int16;
            Sh        : Int16;
            Fx        : Int16;
            Fy        : Int16;
            Fw        : Int16;
            Fh        : Int16)
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


procedure Grow_Box(
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


procedure Shrink_Box(
            Fx        : Int16;
            Fy        : Int16;
            Fw        : Int16;
            Fh        : Int16;
            Sx        : Int16;
            Sy        : Int16;
            Sw        : Int16;
            Sh        : Int16)
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


procedure Shrink_Box(
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


function Watch_Box(
            tree      : Objects.Object_Ptr;
            Obj       : Int16;
            InState   : Int16;
            OutState  : Int16)
           return Int16 is
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


function Slide_Box(
            tree      : Objects.Object_Ptr;
            Parent    : Int16;
            Obj       : Int16;
            Direction : Int16)
           return Int16 is
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


function Handle(
            Wchar     : out Int16;
            Hchar     : out Int16;
            Wbox      : out Int16;
            Hbox      : out Int16)
           return Int16 is
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


function Handle(
            Wchar     : out Int16;
            Hchar     : out Int16;
            Wbox      : out Int16;
            Hbox      : out Int16;
            device    : out Int16)
           return Int16 is
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


procedure Mouse(
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


procedure Mkstate(
            Mx         : out Int16;
            My         : out Int16;
            ButtonState: out Int16;
            KeyState   : out Int16) is
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


function Multirubber(
            bx        : Int16;
            by        : Int16;
            minw      : Int16;
            minh      : Int16;
            rec       : Rectangle_Ptr;
            rw        : out Int16;
            rh        : out Int16)
           return Int16 is
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
