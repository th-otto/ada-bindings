pragma No_Strict_Aliasing;
with Interfaces; use Interfaces;

package body Atari.Aes.Edit is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Create return Editinfo_Ptr is
begin
    aes_control.opcode := 210;
    aes_control.num_intin := 0;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 1;
    aes_trap;
    return Editinfo_Ptr'Deref(aes_addrout(0)'Address);
end;


function Open(tree: Objects.OBJECT_ptr; Obj: int16) return boolean is
begin
    aes_control.opcode := 211;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := Obj;
    aes_addrin(0) := tree.all'Address;
    aes_trap;
    return aes_intout(0) /= 0;
end;


procedure Close(tree: Objects.Object_Ptr; Obj: int16) is
begin
    aes_control.opcode := 212;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := Obj;
    aes_addrin(0) := tree.all'Address;
    aes_trap;
end;


procedure Delete(x: Editinfo_ptr) is
begin
    aes_control.opcode := 213;
    aes_control.num_intin := 0;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := x.all'Address;
    aes_trap;
end;


function Cursor(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            whdl  : int16;
            show  : int16)
           return int16 is
begin
    aes_control.opcode := 214;
    aes_control.num_intin := 3;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := whdl;
    aes_intin(2) := show;
    aes_trap;
    return aes_intout(0);
end;


function Event(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            whdl  : int16;
            ev    : Wdialog.EVNT_ptr;
            errc  : out int32)
           return int16 is
begin
    aes_control.opcode := 215;
    aes_control.num_intin := 2;
    aes_control.num_intout := 3;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_addrin(1) := ev.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := whdl;
    aes_trap;
    errc := int32'Deref(aes_intout(1)'Address);
    return aes_intout(0);
end;


function Get_Buffer(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            buf   : out chars_ptr;
            buflen: out int32;
            txtlen: out int32)
           return boolean is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 1;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 0;
    aes_trap;
    buf := chars_ptr'Deref(aes_addrout(1)'Address);
    buflen := int32'Deref(aes_intout(1)'Address);
    txtlen := int32'Deref(aes_intout(3)'Address);
    return aes_intout(0) /= 0;
end;


function Get_Format(
            tree    : Objects.Object_Ptr;
            Obj     : int16;
            tabwidth: out int16;
            autowrap: out int16)
           return boolean is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 3;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 1;
    aes_trap;
    tabwidth := aes_intout(1);
    autowrap := aes_intout(2);
    return aes_intout(0) /= 0;
end;


function Get_Color(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            tcolor: out int16;
            bcolor: out int16)
           return boolean is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 3;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 2;
    aes_trap;
    tcolor := aes_intout(1);
    bcolor := aes_intout(2);
    return aes_intout(0) /= 0;
end;


function Get_Font(
            tree   : Objects.Object_Ptr;
            Obj    : int16;
            fontID : out int16;
            fontH  : out int16;
            fontPix: out int16;
            mono   : out int16)
           return boolean is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 3;
    aes_trap;
    fontID := aes_intout(1);
    fontH := aes_intout(2);
    mono := aes_intout(3);
    fontPix := aes_intout(4);
    return aes_intout(0) /= 0;
end;


function Get_Cursor(
            tree     : Objects.Object_Ptr;
            Obj      : int16;
            cursorpos: out chars_ptr)
           return boolean is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 1;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 4;
    aes_trap;
    cursorpos := chars_ptr'Deref(aes_addrout(0)'Address);
    return aes_intout(0) /= 0;
end;


procedure Get_Pos(
            tree     : Objects.Object_Ptr;
            Obj      : int16;
            xscroll  : out int16;
            yscroll  : out int32;
            cyscroll : out chars_ptr;
            cursorpos: out chars_ptr;
            cx       : out int16;
            cy       : out int16) is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 6;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 2;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 5;
    aes_trap;
    xscroll := aes_intout(1);
    yscroll := int32'Deref(aes_intout(2)'Address);
    cx := aes_intout(4);
    cy := aes_intout(5);
    cyscroll := chars_ptr'Deref(aes_addrout(0)'Address);
    cursorpos := chars_ptr'Deref(aes_addrout(1)'Address);
end;


function Get_Dirty(
            tree  : Objects.Object_Ptr;
            Obj   : int16)
           return boolean is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 7;
    aes_trap;
    return aes_intout(0) /= 0;
end;


procedure Get_Sel(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            bsel  : out chars_ptr;
            esel  : out chars_ptr) is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 8;
    aes_trap;
    bsel := chars_ptr'Deref(aes_addrout(0)'Address);
    esel := chars_ptr'Deref(aes_addrout(1)'Address);
end;


procedure Get_Scrollinfo(
            tree   : Objects.Object_Ptr;
            Obj    : int16;
            nlines : out int32;
            yscroll: out int32;
            yvis   : out int16;
            yval   : out int16;
            ncols  : out int16;
            xscroll: out int16;
            xvis   : out int16) is
begin
    aes_control.opcode := 216;
    aes_control.num_intin := 2;
    aes_control.num_intout := 10;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 9;
    aes_trap;
    nlines := int32'Deref(aes_intout(1)'Address);
    yscroll := int32'Deref(aes_intout(3)'Address);
    yvis := aes_intout(5);
    yval := aes_intout(6);
    ncols := aes_intout(7);
    xscroll := aes_intout(8);
    xvis := aes_intout(9);
end;


procedure Set_Buffer(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            buf   : chars_ptr;
            buflen: int32) is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 4;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_addrin(1) := buf.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 0;
    int32'Deref(aes_intin(2)'Address) := buflen;
    aes_trap;
end;


procedure Set_Format(
            tree    : Objects.Object_Ptr;
            Obj     : int16;
            tabwidth: int16;
            autowrap: int16) is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 4;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 1;
    aes_intin(2) := tabwidth;
    aes_intin(3) := autowrap;
    aes_trap;
end;


procedure Set_Color(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            tcolor: int16;
            bcolor: int16) is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 4;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 2;
    aes_intin(2) := tcolor;
    aes_intin(3) := bcolor;
    aes_trap;
end;


procedure Set_Font(
            tree   : Objects.Object_Ptr;
            Obj    : int16;
            fontID : int16;
            fontH  : int16;
            fontPix: int16;
            mono   : int16) is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 6;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 3;
    aes_intin(2) := fontID;
    aes_intin(3) := fontH;
    aes_intin(4) := mono;
    aes_intin(5) := fontPix;
    aes_trap;
end;


function Set_Cursor(
            tree     : Objects.Object_Ptr;
            Obj      : int16;
            cursorpos: chars_ptr) return boolean is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 2;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_addrin(1) := cursorpos.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 4;
    aes_trap;
    return aes_intout(0) /= 0;
end;


procedure Set_Pos(
            tree     : Objects.Object_Ptr;
            Obj      : int16;
            xscroll  : int16;
            yscroll  : int32;
            cyscroll : chars_ptr;
            cursorpos: chars_ptr;
            cx       : int16;
            cy       : int16) is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 7;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 3;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_addrin(1) := cyscroll.all'Address;
    aes_addrin(2) := cursorpos.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 5;
    aes_intin(2) := xscroll;
    int32'Deref(aes_intin(3)'Address) := yscroll;
    aes_intin(5) := cx;
    aes_intin(6) := cy;
    aes_trap;
end;


function Resized(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            oldrh : out int16;
            newrh : out int16)
           return boolean is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 2;
    aes_control.num_intout := 3;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 6;
    aes_trap;
    oldrh := aes_intout(1);
    newrh := aes_intout(2);
    return aes_intout(0) /= 0;
end;


procedure Set_Dirty(
            tree  : Objects.Object_Ptr;
            Obj   : int16;
            dirty : boolean) is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 3;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 7;
    aes_intin(2) := dirty'Enum_Rep;
    aes_trap;
end;


function Scroll(
            tree   : Objects.Object_Ptr;
            Obj    : int16;
            whdl   : int16;
            yscroll: int32;
            xscroll: int16)
           return boolean is
begin
    aes_control.opcode := 217;
    aes_control.num_intin := 6;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := tree.all'Address;
    aes_intin(0) := Obj;
    aes_intin(1) := 9;
    aes_intin(2) := whdl;
    int32'Deref(aes_intin(3)'Address) := yscroll;
    aes_intin(5) := xscroll;
    aes_trap;
    return aes_intout(0) /= 0;
end;


end Atari.Aes.Edit;
