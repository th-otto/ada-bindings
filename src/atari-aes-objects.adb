package body Atari.Aes.Objects is

procedure Add(
            tree  : OBJECT_ptr;
            Parent: int16;
            Child : int16)
           is
begin
	aes_control.opcode := 40;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Parent;
	aes_intin(1) := Child;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
end;


function objc_delete(
            tree      : OBJECT_ptr;
            Obj       : int16)
           return int16 is
begin
	aes_control.opcode := 41;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Obj;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


procedure objc_draw(
            tree      : OBJECT_ptr;
            Start     : int16;
            Depth     : int16;
            Cx        : int16;
            Cy        : int16;
            Cw        : int16;
            Ch        : int16)
           is
begin
	aes_control.opcode := 42;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Start;
	aes_intin(1) := Depth;
	aes_intin(2) := Cx;
	aes_intin(3) := Cy;
	aes_intin(4) := Cw;
	aes_intin(5) := Ch;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
end;


procedure objc_draw(
            tree      : OBJECT_ptr;
            Start     : int16;
            Depth     : int16;
            r         : in Rectangle)
           is
begin
	aes_control.opcode := 42;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Start;
	aes_intin(1) := Depth;
	aes_intin(2) := r.g_x;
	aes_intin(3) := r.g_y;
	aes_intin(4) := r.g_w;
	aes_intin(5) := r.g_h;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
end;


function objc_find(
            tree      : OBJECT_ptr;
            Start     : int16;
            Depth     : int16;
            Mx        : int16;
            My        : int16)
           return int16 is
begin
	aes_control.opcode := 43;
	aes_control.num_intin := 4;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Start;
	aes_intin(1) := Depth;
	aes_intin(2) := Mx;
	aes_intin(3) := My;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


procedure objc_offset(
            tree      : OBJECT_ptr;
            Obj       : int16;
            X         : out int16;
            Y         : out int16)
           is
begin
	aes_control.opcode := 44;
	aes_control.num_intin := 1;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Obj;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	X := aes_intout(1);
	Y := aes_intout(2);
end;


function objc_order(
            tree      : OBJECT_ptr;
            Obj       : int16;
            NewPos    : int16)
           return int16 is
begin
	aes_control.opcode := 45;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Obj;
	aes_intin(1) := NewPos;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function objc_edit(
            tree      : OBJECT_ptr;
            Obj       : int16;
            Kchar     : int16;
            Index     : in out int16;
            Kind      : int16)
           return int16 is
begin
	aes_control.opcode := 46;
	aes_control.num_intin := 4;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Obj;
	aes_intin(1) := Kchar;
	aes_intin(2) := Index;
	aes_intin(3) := Kind;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	Index := aes_intout(1);
	return aes_intout(0);
end;


function objc_edit(
            tree      : OBJECT_ptr;
            Obj       : int16;
            Kchar     : int16;
            Index     : in out int16;
            Kind      : int16;
            r         : out Rectangle)
           return int16 is
begin
	aes_control.opcode := 46;
	aes_control.num_intin := 4;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := Obj;
	aes_intin(1) := Kchar;
	aes_intin(2) := Index;
	aes_intin(3) := Kind;
	aes_addrin(0) := tree.all'Address;
	aes_addrin(1) := r'Address;
	aes_trap;
	Index := aes_intout(1);
	return aes_intout(0);
end;


procedure objc_change(
            tree      : OBJECT_ptr;
            Start     : int16;
            Depth     : int16;
            Cx        : int16;
            Cy        : int16;
            Cw        : int16;
            Ch        : int16;
            NewState  : int16;
            Redraw    : int16)
           is
begin
	aes_control.opcode := 47;
	aes_control.num_intin := 8;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Start;
	aes_intin(1) := Depth;
	aes_intin(2) := Cx;
	aes_intin(3) := Cy;
	aes_intin(4) := Cw;
	aes_intin(5) := Ch;
	aes_intin(6) := NewState;
	aes_intin(7) := Redraw;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
end;


procedure objc_change(
            tree      : OBJECT_ptr;
            Start     : int16;
            Depth     : int16;
            r         : in Rectangle;
            NewState  : int16;
            Redraw    : int16)
           is
begin
	aes_control.opcode := 47;
	aes_control.num_intin := 8;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Start;
	aes_intin(1) := Depth;
	aes_intin(2) := r.g_x;
	aes_intin(3) := r.g_y;
	aes_intin(4) := r.g_w;
	aes_intin(5) := r.g_h;
	aes_intin(6) := NewState;
	aes_intin(7) := Redraw;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
end;


function objc_sysvar(
            mode      : int16;
            which     : int16;
            in1       : int16;
            in2       : int16;
            out1      : out int16;
            out2      : out int16)
           return int16 is
begin
	aes_control.opcode := 48;
	aes_control.num_intin := 4;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := mode;
	aes_intin(1) := which;
	aes_intin(2) := in1;
	aes_intin(3) := in2;
	aes_trap;
	out1 := aes_intout(1);
	out2 := aes_intout(2);
	return aes_intout(0);
end;


function objc_xfind(
            tree      : OBJECT_ptr;
            Start     : int16;
            Depth     : int16;
            Mx        : int16;
            My        : int16)
           return int16 is
begin
	aes_control.opcode := 49;
	aes_control.num_intin := 4;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Start;
	aes_intin(1) := Depth;
	aes_intin(2) := Mx;
	aes_intin(3) := My;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


end Atari.Aes.Objects;
