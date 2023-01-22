with Ada.Unchecked_Conversion;

package body Atari.Aes.Extensions is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);


procedure objc_wdraw(
            tree      : OBJECT_ptr;
            Start     : int16;
            Depth     : int16;
            clip      : in GRECT;
            whandle   : int16)
           is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 60;
	aes_control.num_intin := 3;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := Start;
	aes_intin(1) := Depth;
	aes_intin(2) := whandle;
	aes_addrin(0) := to_address(tree);
	aes_addrin(1) := clip'Address;
	aes_trap;
end;


procedure objc_wchange(
            tree     : OBJECT_ptr;
            obj      : int16;
            new_state: int16;
            clip     : access GRECT;
            whandle  : int16) is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 61;
	aes_control.num_intin := 3;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := obj;
	aes_intin(1) := new_state;
	aes_intin(2) := whandle;
	aes_addrin(0) := to_address(tree);
	aes_addrin(1) := clip'Address;
	aes_trap;
end;


function graf_wwatchbox(
            tree      : OBJECT_ptr;
            Obj       : int16;
            InState   : int16;
            OutState  : int16;
            whandle   : int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 62;
	aes_control.num_intin := 4;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := obj;
	aes_intin(1) := InState;
	aes_intin(2) := OutState;
	aes_intin(3) := whandle;
	aes_addrin(0) := to_address(tree);
	aes_trap;
	return aes_intout(0);
end;


function form_wbutton(
            tree      : OBJECT_ptr;
            fo_bobject: int16;
            fo_bclicks: int16;
            fo_bnxtobj: out int16;
            whandle   : int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 63;
	aes_control.num_intin := 3;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := fo_bobject;
	aes_intin(1) := fo_bclicks;
	aes_intin(2) := whandle;
	aes_addrin(0) := to_address(tree);
	aes_trap;
	fo_bnxtobj := aes_intout(1);
	return aes_intout(0);
end;


function form_wkeybd(
            tree         : OBJECT_ptr;
            fo_kobject   : int16;
            fo_kobnext   : int16;
            fo_kchar     : int16;
            fo_knxtobject: out int16;
            fo_knxtchar  : out int16;
            whandle      : int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 64;
	aes_control.num_intin := 4;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := fo_kobject;
	aes_intin(1) := fo_kobnext;
	aes_intin(2) := fo_kchar;
	aes_intin(3) := whandle;
	aes_addrin(0) := to_address(tree);
	aes_trap;
	fo_knxtobject := aes_intout(1);
	fo_knxtchar := aes_intout(2);
	return aes_intout(0);
end;


function objc_wedit(
            tree   : OBJECT_ptr;
            obj    : int16;
            key    : int16;
            idx    : in out int16;
            kind   : int16;
            whandle: int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 65;
	aes_control.num_intin := 5;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := obj;
	aes_intin(1) := key;
	aes_intin(2) := idx;
	aes_intin(3) := kind;
	aes_intin(4) := whandle;
	aes_addrin(0) := to_address(tree);
	aes_trap;
	idx := aes_intout(1);
	return aes_intout(0);
end;


function objc_xedit(
            tree  : OBJECT_ptr;
            obj   : int16;
            key   : int16;
            xpos  : in out int16;
            subfn : int16;
            r     : in GRECT)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 46;
	aes_control.num_intin := 4;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := obj;
	aes_intin(1) := key;
	aes_intin(2) := xpos;
	aes_intin(3) := subfn;
	aes_addrin(0) := to_address(tree);
	aes_addrin(1) := r'Address;
	aes_trap;
	xpos := aes_intout(1);
	return aes_intout(0);
end;


function form_popup(
            tree  : OBJECT_ptr;
            x     : int16;
            y     : int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
begin
	aes_control.opcode := 135;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := x;
	aes_intin(1) := y;
	aes_addrin(0) := to_address(tree);
	aes_trap;
	return aes_intout(0);
end;


function xfrm_popup(
            tree       : OBJECT_ptr;
            x          : int16;
            y          : int16;
            firstscrlob: int16;
            lastscrlob : int16;
            nlines     : int16;
            init       : init_proc_ptr;
            param      : System.Address;
            lastscrlpos: in out int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
    function to_address2 is new Ada.Unchecked_Conversion(init_proc_ptr, System.Address);
begin
	aes_control.opcode := 135;
	aes_control.num_intin := 6;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_intin(0) := x;
	aes_intin(1) := y;
	aes_intin(2) := firstscrlob;
	aes_intin(3) := lastscrlob;
	aes_intin(4) := nlines;
	aes_intin(5) := lastscrlpos;
	aes_addrin(0) := to_address(tree);
	aes_addrin(1) := to_address2(init);
	aes_addrin(2) := param;
	aes_trap;
	lastscrlpos := aes_intout(1);
	return aes_intout(0);
end;


function form_xdo(
            tree    : OBJECT_ptr;
            startob : int16;
            lastcrsr: out int16;
            tabs    : XDO_INF_ptr;
            flydial : void_ptr_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, System.Address);
    function to_address2 is new Ada.Unchecked_Conversion(XDO_INF_ptr, System.Address);
    function to_address3 is new Ada.Unchecked_Conversion(void_ptr_ptr, System.Address);
begin
	aes_control.opcode := 50;
	aes_control.num_intin := 1;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_intin(0) := startob;
	aes_addrin(0) := to_address(tree);
	aes_addrin(1) := to_address2(tabs);
	aes_addrin(1) := to_address3(flydial);
	aes_trap;
	lastcrsr := aes_intout(1);
	return aes_intout(0);
end;


function form_xdial(
            fo_diflag  : int16;
            fo_dilittlx: int16;
            fo_dilittly: int16;
            fo_dilittlw: int16;
            fo_dilittlh: int16;
            fo_dibigx  : int16;
            fo_dibigy  : int16;
            fo_dibigw  : int16;
            fo_dibigh  : int16;
            flydial    : void_ptr_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(void_ptr_ptr, System.Address);
    function to_null is new Ada.Unchecked_Conversion(chars_ptr, System.Address);
begin
	aes_control.opcode := 51;
	aes_control.num_intin := 9;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := fo_diflag;
	aes_intin(1) := fo_dilittlx;
	aes_intin(2) := fo_dilittly;
	aes_intin(3) := fo_dilittlw;
	aes_intin(4) := fo_dilittlh;
	aes_intin(5) := fo_dibigx;
	aes_intin(6) := fo_dibigy;
	aes_intin(7) := fo_dibigw;
	aes_intin(8) := fo_dibigh;
	aes_addrin(0) := to_address(flydial);
	aes_addrin(1) := to_null(null);
	aes_trap;
	return aes_intout(0);
end;


function form_xdial(
            fo_diflag : int16;
            fo_dilittl: in GRECT;
            fo_dibig  : in GRECT;
            flydial   : void_ptr_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(void_ptr_ptr, System.Address);
    function to_null is new Ada.Unchecked_Conversion(chars_ptr, System.Address);
begin
	aes_control.opcode := 51;
	aes_control.num_intin := 9;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := fo_diflag;
	aes_intin(1) := fo_dilittl.g_x;
	aes_intin(2) := fo_dilittl.g_y;
	aes_intin(3) := fo_dilittl.g_w;
	aes_intin(4) := fo_dilittl.g_h;
	aes_intin(5) := fo_dibig.g_x;
	aes_intin(6) := fo_dibig.g_y;
	aes_intin(7) := fo_dibig.g_w;
	aes_intin(8) := fo_dibig.g_h;
	aes_addrin(0) := to_address(flydial);
	aes_addrin(1) := to_null(null);
	aes_trap;
	return aes_intout(0);
end;


function appl_options(
            mode: int16;
            aopts0: int16;
            aopts1: int16;
            aopts2: int16;
            aopts3: int16;
            out0: out int16;
            out1: out int16;
            out2: out int16;
            out3: out int16)
           return int16 is
begin
	aes_control.opcode := 137;
	aes_control.num_intin := 5;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := mode;
	aes_intin(1) := aopts0;
	aes_intin(2) := aopts1;
	aes_intin(3) := aopts2;
	aes_intin(4) := aopts3;
	aes_trap;
	out0 := aes_intout(1);
	out1 := aes_intout(2);
	out2 := aes_intout(3);
	out3 := aes_intout(4);
	return aes_intout(0);
end;



















end Atari.Aes.Extensions;
