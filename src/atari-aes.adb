pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;
with Interfaces.C; use Interfaces.C;
with Interfaces;   use Interfaces;

package body Atari.Aes is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

has_agi: int16 := -1;


aes_pb: aliased AESPB := (
    global => aes_global'Access,
    control => aes_control'Access,
    intin => aes_intin'Access,
    intout => aes_intout'Access,
    addrin => aes_addrin'Access,
    addrout => aes_addrout'Access
);


procedure aes(pb: AESPB_ptr) is
    use ASCII;
begin
    asm("move.l %0,%%d1" & LF & HT &
        "move.w #200,%%d0" & LF & HT &
        "trap #2" & LF & HT,
        volatile => true,
        inputs => void_ptr'Asm_Input("g", pb.all'Address),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
end;


procedure aes_trap is
begin
	aes(aes_pb'Access);
end;


function to_address(tree: AEStree_ptr) return void_ptr is
begin
	return tree.all'Address;
end;


function gl_ap_version return int16 is
begin
	return aes_global(0);
end;


function gl_numapps return int16 is
begin
	return aes_global(1);
end;


function gl_apid return int16 is
begin
	return aes_global(2);
end;



function appl_init return int16 is
begin
	aes_control.opcode := 10;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	return aes_intout(0);
end;


function appl_read(
            ap_id     : int16;
            length    : int16;
            ap_pbuff  : void_ptr)
           return int16 is
begin
	aes_control.opcode := 11;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := ap_id;
	aes_intin(1) := length;
	aes_addrin(0) := ap_pbuff;
	aes_trap;
	return aes_intout(0);
end;


function appl_write(
            ap_id     : int16;
            length    : int16;
            ap_pbuff  : void_ptr)
           return int16 is
begin
	aes_control.opcode := 12;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := ap_id;
	aes_intin(1) := length;
	aes_addrin(0) := ap_pbuff;
	aes_trap;
	return aes_intout(0);
end;


function appl_write(
            ap_id     : int16;
            ap_pbuff  : Message_Buffer)
           return int16 is
begin
	return appl_write(ap_id, 16, ap_pbuff'Address);
end;


function appl_find(name: chars_ptr) return int16 is
begin
	aes_control.opcode := 13;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := name.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function appl_find(name: String) return int16 is
    c_str: String := name & ASCII.NUL;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, chars_ptr);
begin
	return appl_find(to_address(c_str'Address));
end;


procedure appl_tplay(
            mem       : void_ptr;
            num       : int16;
            scale     : int16)
           is
begin
	aes_control.opcode := 14;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := num;
	aes_intin(1) := scale;
	aes_addrin(0) := mem;
	aes_trap;
end;


function appl_trecord(
            mem       : void_ptr;
            count     : int16)
           return int16 is
begin
	aes_control.opcode := 15;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := count;
	aes_addrin(0) := mem;
	aes_trap;
	return aes_intout(0);
end;


function appl_bvset(
            bvdisk    : int16;
            bvhard    : int16)
           return int16 is
begin
	aes_control.opcode := 16;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := bvdisk;
	aes_intin(1) := bvhard;
	aes_trap;
	return aes_intout(0);
end;


--
-- in the C version,
-- there used to be 2 version of this kind:
-- appl_yield(), which traps into AES,
-- and _appl_yield(), which uses the Atari specific
-- AES opcode #201. Both essentially have the same effect,
-- but the former is not available in all AES versions,
-- and we can't have both version because ADA does not allow
-- identifiers to start with a '_'. So we implement only the
-- latter here.
--
procedure appl_yield is
    use ASCII;
begin
    asm("move.w #201,%%d0" & LF & HT &
        "trap #2" & LF & HT,
        volatile => true,
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
end;


function appl_search(
            mode      : int16;
            fname     : chars_ptr;
            c_type    : out int16;
            ap_id     : out int16)
           return int16 is
begin
	aes_control.opcode := 18;
	aes_control.num_intin := 1;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := mode;
	aes_addrin(0) := fname.all'Address;
	aes_trap;
	c_type := aes_intout(1);
	ap_id := aes_intout(2);
	return aes_intout(0);
end;


function appl_search(
            mode      : int16;
            fname     : String;
            c_type    : out int16;
            ap_id     : out int16)
           return int16 is
    c_str: String := fname & ASCII.NUL;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, chars_ptr);
begin
	return appl_search(mode, to_address(c_str'Address), c_type, ap_id);
end;


procedure appl_exit is
begin
	aes_control.opcode := 19;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
end;


function appl_control(
            ap_cid    : int16;
            ap_cwhat  : int16;
            ap_cout   : void_ptr)
           return int16 is
begin
	aes_control.opcode := 129;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := ap_cid;
	aes_intin(1) := ap_cwhat;
	aes_addrin(0) := ap_cout;
	aes_trap;
	return aes_intout(0);
end;


function appl_getinfo(
            c_type    : int16;
            out1      : out int16;
            out2      : out int16;
            out3      : out int16;
            out4      : out int16)
           return boolean is
begin
	aes_control.opcode := 130;
	aes_control.num_intin := 1;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_type;
	aes_trap;
	out1 := aes_intout(1);
	out2 := aes_intout(2);
	out3 := aes_intout(3);
	out4 := aes_intout(4);
	return aes_intout(0) /= 0;
end;


function appl_xgetinfo(
            c_type    : int16;
            out1      : out int16;
            out2      : out int16;
            out3      : out int16;
            out4      : out int16)
           return boolean is
begin
	if (has_agi < 0) then
		if (aes_global(0) >= 1024 or else
		          appl_find("?AGI\0\0\0\0") >= 0) then
		    has_agi := 1;
		else
	        has_agi := 0;
		end if;
	end if;
	if (has_agi = 0) then
		return false;
	end if;
	return appl_getinfo(c_type, out1, out2, out3, out4);
end;


function appl_getinfo(
            c_type    : int16;
            out1      : chars_ptr;
            out2      : chars_ptr;
            out3      : chars_ptr;
            out4      : chars_ptr)
           return boolean is
begin
	if (has_agi < 0) then
		if (aes_global(0) >= 1024 or else
		          appl_find("?AGI\0\0\0\0") >= 0) then
		    has_agi := 1;
		else
	        has_agi := 0;
		end if;
	end if;
	if (has_agi = 0) then
		return false;
	end if;
	aes_control.opcode := 130;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_type;
	aes_addrin(0) := out1.all'Address;
	aes_addrin(1) := out2.all'Address;
	aes_addrin(2) := out3.all'Address;
	aes_addrin(3) := out4.all'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


function evnt_keybd return int16 is
begin
	aes_control.opcode := 20;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	return aes_intout(0);
end;


function evnt_button(
            Clicks     : int16;
            WhichButton: int16;
            WhichState : int16;
            Mx         : out int16;
            My         : out int16;
            ButtonState: out int16;
            KeyState   : out int16)
           return int16 is
begin
	aes_control.opcode := 21;
	aes_control.num_intin := 3;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := Clicks;
	aes_intin(1) := WhichButton;
	aes_intin(2) := WhichState;
	aes_trap;
	Mx := aes_intout(1);
	My := aes_intout(2);
	ButtonState := aes_intout(2);
	KeyState := aes_intout(3);
	return aes_intout(0);
end;


procedure evnt_mouse(
            EnterExit  : int16;
            InX        : int16;
            InY        : int16;
            InW        : int16;
            InH        : int16;
            OutX       : out int16;
            OutY       : out int16;
            ButtonState: out int16;
            KeyState   : out int16)
           is
begin
	aes_control.opcode := 22;
	aes_control.num_intin := 5;
	aes_control.num_intout := 5;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := EnterExit;
	aes_intin(1) := InX;
	aes_intin(2) := InY;
	aes_intin(3) := InW;
	aes_intin(4) := InH;
	aes_trap;
	OutX := aes_intout(1);
	OutY := aes_intout(2);
	ButtonState := aes_intout(2);
	KeyState := aes_intout(3);
end;


function evnt_mesag(MesagBuf: out short_array) return int16 is
begin
	aes_control.opcode := 23;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := MesagBuf'Address;
	aes_trap;
	return aes_intout(0);
end;


function evnt_mesag(MesagBuf: out Message_Buffer) return int16 is
begin
	return evnt_mesag(MesagBuf.arr);
end;


procedure evnt_timer(
            Interval  : uint32)
           is
begin
	aes_control.opcode := 24;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := int16(Interval and 16#ffff#);
	aes_intin(1) := int16(Shift_Right(Interval, 16));
	aes_trap;
end;


function evnt_timer(
            locount  : int16;
            hicount  : int16)
           return int16 is
begin
	aes_control.opcode := 24;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := locount;
	aes_intin(1) := hicount;
	aes_trap;
	return aes_intout(0);
end;



function evnt_multi(
            c_Type     : int16;
            Clicks     : int16;
            WhichButton: int16;
            WhichState : int16;
            EnterExit1 : int16;
            In1X       : int16;
            In1Y       : int16;
            In1W       : int16;
            In1H       : int16;
            EnterExit2 : int16;
            In2X       : int16;
            In2Y       : int16;
            In2W       : int16;
            In2H       : int16;
            MesagBuf   : out Message_Buffer;
            Interval   : uint32;
            OutX       : out int16;
            OutY       : out int16;
            ButtonState: out int16;
            KeyState   : out int16;
            Key        : out int16;
            ReturnCount: out int16)
           return int16 is
begin
	aes_control.opcode := 25;
	aes_control.num_intin := 16;
	aes_control.num_intout := 7;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_Type;
	aes_intin(1) := Clicks;
	aes_intin(2) := WhichButton;
	aes_intin(3) := WhichState;
	aes_intin(4) := EnterExit1;
	aes_intin(5) := In1X;
	aes_intin(6) := In1Y;
	aes_intin(7) := In1W;
	aes_intin(8) := In1H;
	aes_intin(9) := EnterExit2;
	aes_intin(10) := In2X;
	aes_intin(11) := In2Y;
	aes_intin(12) := In2W;
	aes_intin(13) := In2H;
	aes_intin(14) := int16(Interval and 16#ffff#);
	aes_intin(15) := int16(Shift_Right(Interval, 16));
	aes_addrin(0) := MesagBuf'Address;
	aes_trap;
	OutX := aes_intout(1);
	OutY := aes_intout(2);
	ButtonState := aes_intout(3);
	KeyState := aes_intout(4);
	Key := aes_intout(5);
	ReturnCount := aes_intout(6);
	return aes_intout(0);
end;



function evnt_multi(
            em_i       : in EVMULT_IN;
            MesagBuf   : out Message_Buffer;
            em_o       : out EVMULT_OUT)
           return int16 is
begin
	aes_control.opcode := 25;
	aes_control.num_intin := 16;
	aes_control.num_intout := 7;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := em_i.emi_flags;
	aes_intin(1) := em_i.emi_bclicks;
	aes_intin(2) := int16(em_i.emi_bmask);
	aes_intin(3) := int16(em_i.emi_bstate);
	aes_intin(4) := em_i.emi_m1leave;
	aes_intin(5) := em_i.emi_m1.g_x;
	aes_intin(6) := em_i.emi_m1.g_y;
	aes_intin(7) := em_i.emi_m1.g_w;
	aes_intin(8) := em_i.emi_m1.g_h;
	aes_intin(9) := em_i.emi_m2leave;
	aes_intin(10) := em_i.emi_m2.g_x;
	aes_intin(11) := em_i.emi_m2.g_y;
	aes_intin(12) := em_i.emi_m2.g_w;
	aes_intin(13) := em_i.emi_m2.g_h;
	aes_intin(14) := em_i.emi_tlow;
	aes_intin(15) := em_i.emi_thigh;
	aes_addrin(0) := MesagBuf'Address;
	aes_trap;
	em_o.emo_events := uint16(aes_intout(0));
	em_o.emo_mouse.p_x := aes_intout(1);
	em_o.emo_mouse.p_y := aes_intout(2);
	em_o.emo_mbutton := uint16(aes_intout(3));
	em_o.emo_kmeta := uint16(aes_intout(4));
	em_o.emo_kreturn := aes_intout(5);
	em_o.emo_mclicks := aes_intout(6);
	return aes_intout(0);
end;


function evnt_dclick(
            ToSet     : int16;
            SetGet    : int16)
           return int16 is
begin
	aes_control.opcode := 26;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := ToSet;
	aes_intin(1) := SetGet;
	aes_trap;
	return aes_intout(0);
end;


function menu_bar(
            me_tree: AEStree_ptr;
            me_mode: int16)
           return int16 is
begin
	aes_control.opcode := 30;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_mode;
	aes_addrin(0) := to_address(me_tree);
	aes_trap;
	return aes_intout(0);
end;


function menu_icheck(
            me_tree : in AEStree_ptr;
            me_item : int16;
            me_check: int16)
           return int16 is
begin
	aes_control.opcode := 30;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_intin(1) := me_check;
	aes_addrin(0) := to_address(me_tree);
	aes_trap;
	return aes_intout(0);
end;


function menu_ienable(
            me_tree  : in AEStree_ptr;
            me_item  : int16;
            me_enable: int16)
           return int16 is
begin
	aes_control.opcode := 32;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_intin(1) := me_enable;
	aes_addrin(0) := to_address(me_tree);
	aes_trap;
	return aes_intout(0);
end;


function menu_tnormal(
            me_tree  : in AEStree_ptr;
            me_item  : int16;
            me_normal: int16)
           return int16 is
begin
	aes_control.opcode := 33;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_intin(1) := me_normal;
	aes_addrin(0) := to_address(me_tree);
	aes_trap;
	return aes_intout(0);
end;


function menu_text(
            me_tree: in AEStree_ptr;
            me_item: int16;
            me_text: const_chars_ptr)
           return int16 is
begin
	aes_control.opcode := 34;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_addrin(0) := to_address(me_tree);
	aes_addrin(1) := me_text.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function menu_register(
            ap_id  : int16;
            me_text: const_chars_ptr)
           return int16 is
begin
	aes_control.opcode := 35;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := ap_id;
	aes_addrin(0) := me_text.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function menu_unregister(
            id    : int16)
           return int16 is
begin
	aes_control.opcode := 36;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := id;
	aes_trap;
	return aes_intout(0);
end;


function menu_popup(
            me_menu : in AMENU;
            me_xpos : int16;
            me_ypos : int16;
            me_mdata: out AMENU)
           return int16 is
begin
	aes_control.opcode := 36;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_xpos;
	aes_intin(1) := me_ypos;
	aes_addrin(0) := me_menu'Address;
	aes_addrin(1) := me_mdata'Address;
	aes_trap;
	return aes_intout(0);
end;


function menu_attach(
            me_flag : int16;
            me_tree : AEStree_ptr;
            me_item : int16;
            me_mdata: AMENU_ptr)
           return int16 is
begin
	aes_control.opcode := 37;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_flag;
	aes_intin(1) := me_item;
	aes_addrin(0) := to_address(me_tree);
	aes_addrin(1) := me_mdata.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function menu_click(
            click : int16;
            setit : int16)
           return int16 is
begin
	aes_control.opcode := 37;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := click;
	aes_intin(1) := setit;
	aes_trap;
	return aes_intout(0);
end;


function menu_istart(
            me_flag : int16;
            me_tree : AEStree_ptr;
            me_imenu: int16;
            me_item : int16)
           return int16 is
begin
	aes_control.opcode := 38;
	aes_control.num_intin := 3;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_flag;
	aes_intin(1) := me_imenu;
	aes_intin(2) := me_item;
	aes_addrin(0) := to_address(me_tree);
	aes_trap;
	return aes_intout(0);
end;


function menu_settings(
            me_flag  : int16;
            me_values: in MN_SET)
           return int16 is
begin
	aes_control.opcode := 39;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_flag;
	aes_addrin(0) := me_values'Address;
	aes_trap;
	return aes_intout(0);
end;



procedure objc_add(
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
            r         : in GRECT)
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
            r         : out GRECT)
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
            r         : in GRECT;
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





function form_do(
            tree      : OBJECT_ptr;
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


function form_dial(
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


function form_dial(
            Flag      : int16;
            little    : in GRECT;
            big       : in GRECT)
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


function form_alert(fo_adefbttn: int16; alertstr: chars_ptr) return int16 is
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


function form_alert(fo_adefbttn: int16; alertstr: String) return int16 is
    c_str: String := alertstr & ASCII.NUL;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, chars_ptr);
begin
	return form_alert(fo_adefbttn, to_address(c_str'Address));
end;


function form_error(
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
function form_error(
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

function form_center(
            tree      : OBJECT_ptr;
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


function form_center(
            tree      : OBJECT_ptr;
            r         : out GRECT)
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


function form_keybd(
            tree      : OBJECT_ptr;
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


function form_button(
            tree      : OBJECT_ptr;
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
            r         : in GRECT;
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
            little    : in GRECT;
            big       : in GRECT;
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
            little    : in GRECT;
            big       : in GRECT)
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
            big       : in GRECT;
            little    : in GRECT)
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
            tree      : OBJECT_ptr;
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
            tree      : OBJECT_ptr;
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
            rec       : GRECT_ptr;
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




function scrp_read(
            Scrappath : chars_ptr)
           return int16 is
begin
	aes_control.opcode := 80;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := Scrappath.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function scrp_write(
            Scrappath : const_chars_ptr)
           return int16 is
begin
	aes_control.opcode := 81;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := Scrappath.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function scrp_clear return int16 is
begin
	aes_control.opcode := 82;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	return aes_intout(0);
end;




function fsel_input(
            path       : chars_ptr;
            file       : chars_ptr;
            exit_button: out int16)
           return int16 is
begin
	aes_control.opcode := 90;
	aes_control.num_intin := 0;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := path.all'Address;
	aes_addrin(1) := file.all'Address;
	aes_trap;
	exit_button := aes_intout(1);
	return aes_intout(0);
end;


function fsel_exinput(
            path       : chars_ptr;
            file       : chars_ptr;
            exit_button: out int16;
            title      : const_chars_ptr)
           return int16 is
begin
	aes_control.opcode := 91;
	aes_control.num_intin := 0;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_addrin(0) := path.all'Address;
	aes_addrin(1) := file.all'Address;
	aes_addrin(2) := title.all'Address;
	aes_trap;
	exit_button := aes_intout(1);
	return aes_intout(0);
end;


function fsel_boxinput(
            path       : chars_ptr;
            file       : chars_ptr;
            exit_button: out int16;
            title      : const_chars_ptr;
            callback   : FSEL_CALLBACK)
           return int16 is
begin
	aes_control.opcode := 91;
	aes_control.num_intin := 0;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_addrin(0) := path.all'Address;
	aes_addrin(1) := file.all'Address;
	aes_addrin(2) := title.all'Address;
	aes_addrin(3) := callback.all'Address;
	aes_trap;
	exit_button := aes_intout(1);
	return aes_intout(0);
end;




function wind_draw(
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


function wind_create(
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


function wind_create(
            Parts     : int16;
            r         : in GRECT)
           return int16 is
begin
	return wind_create(Parts, r.g_x, r.g_y, r.g_w, r.g_h);
end;


-- wind_xcreate
function wind_create(
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
function wind_create(
            Parts     : int16;
            r         : in GRECT;
            ret       : out GRECT)
           return int16 is
begin
	return wind_create(Parts, r.g_x, r.g_y, r.g_w, r.g_h, ret.g_x, ret.g_y, ret.g_w, ret.g_h);
end;


function wind_open(
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


function wind_open(
            WindowHandle: int16;
            r           : in GRECT)
           return int16 is
begin
	return wind_open(WindowHandle, r.g_x, r.g_y, r.g_w, r.g_h);
end;


function wind_close(
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


function wind_delete(
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


function wind_get(
            WindowHandle: int16;
            What        : wind_get_set_type;
            W1          : out int16;
            W2          : out int16;
            W3          : out int16;
            W4          : out int16)
           return int16 is
    type short_ptr_ptr is access all void_ptr;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, short_ptr_ptr);
    ptr: void_ptr;
    pptr: aliased short_ptr_ptr;
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
	      pptr := to_address(ptr);
	      pptr.all := W1'Address;
 	      raise Standard'Abort_Signal with "use wind_get(str) instead";
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


function wind_get(
            WindowHandle: int16;
            What        : wind_get_set_type;
            W1          : chars_ptr)
           return int16 is
    type short_ptr_ptr is access all void_ptr;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, short_ptr_ptr);
    function to_address2 is new Ada.Unchecked_Conversion(chars_ptr, void_ptr);
    ptr: void_ptr;
    pptr: aliased short_ptr_ptr;
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
	      pptr := to_address(ptr);
	      pptr.all := to_address2(W1);
	   when others =>
 	      raise Standard'Abort_Signal with "use wind_get() instead";
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


function wind_get(
            WindowHandle: int16;
            What        : wind_get_set_type;
            r           : out GRECT)
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
function wind_get(
            WindowHandle: int16;
            What        : wind_get_set_type;
            clip        : in GRECT;
            r           : out GRECT)
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


function wind_get(
            WindowHandle: int16;
            What        : wind_get_set_type;
            W1          : out int16)
           return int16 is
    dummy: int16;
    dummy2: int16;
    dummy3: int16;
begin
	return wind_get(WindowHandle, what, W1, dummy, dummy2, dummy3);
end;


function wind_set(
            WindowHandle: int16;
            What        : wind_get_set_type;
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



function wind_set(
            WindowHandle: int16;
            What        : wind_get_set_type;
            r           : in GRECT)
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
function wind_set(
            WindowHandle: int16;
            What        : wind_get_set_type;
            s           : in GRECT;
            r           : out GRECT)
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


function wind_set(
            WindowHandle: int16;
            What        : wind_get_set_type;
            str         : const_chars_ptr)
           return int16 is
    type const_chars_ptr_ptr is access all const_chars_ptr;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, const_chars_ptr_ptr);
    ptr: void_ptr;
    pptr: const_chars_ptr_ptr;
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
    ptr := aes_intin(2)'Address;
    pptr := to_address(ptr);
    pptr.all := str;
	aes_intin(4) := 0;
	aes_intin(5) := 0;

	aes_trap;

	return aes_intout(0);
end;


function wind_set(
            WindowHandle: int16;
            What        : wind_get_set_type;
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


function wind_set(
            WindowHandle: int16;
            What        : wind_get_set_type;
            v           : void_ptr;
            W3          : int16 := 0)
           return int16 is
    type address_ptr is access all void_ptr;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, address_ptr);
    ptr: void_ptr;
    pptr: address_ptr;
begin
	aes_control.opcode := 105;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := WindowHandle;
	aes_intin(1) := What'Enum_Rep;
    ptr := aes_intin(2)'Address;
    pptr := to_address(ptr);
    pptr.all := v;
	aes_intin(4) := W3;
	aes_intin(5) := 0;

	aes_trap;

	return aes_intout(0);
end;


function wind_find(
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


function wind_update(
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


procedure wind_calc(
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


procedure wind_calc(
            c_Type    : int16;
            Parts     : int16;
            c_In      : in GRECT;
            c_Out     : out GRECT)
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


procedure wind_new is
begin
	aes_control.opcode := 109;
	aes_control.num_intin := 0;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;

	aes_trap;
end;




function rsrc_load(
            Name      : const_chars_ptr)
           return int16 is
begin
	aes_control.opcode := 110;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;

	aes_addrin(0) := Name.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function rsrc_load(
            Name      : String)
           return int16 is
    c_str: String := Name & ASCII.NUL;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, const_chars_ptr);
begin
	return rsrc_load(to_address(c_str'Address));
end;


function rsrc_free return int16 is
begin
	aes_control.opcode := 111;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;

	aes_trap;
	return aes_intout(0);
end;


function rsrc_gaddr(
            c_Type    : int16;
            Index     : int16;
            Addr      : out void_ptr)
           return int16 is
begin
	aes_control.opcode := 112;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 1;
	aes_intin(0) := c_Type;
	aes_intin(1) := Index;
	aes_trap;
	addr := aes_addrout(0);
	return aes_intout(0);
end;


function rsrc_gaddr(
            Index     : int16)
           return AESTREE_ptr is
    treeadr: void_ptr;
    treeptr: AEStree_ptr;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, AEStree_ptr);
begin
	if rsrc_gaddr(R_TREE, Index, treeadr) = 0 then
	   return null;
	end if;
	treeptr := to_address(treeadr);
	return treeptr;
end;


function rsrc_gaddr(Index: int16) return const_chars_ptr is
    stradr: void_ptr;
    strptr: const_chars_ptr;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, const_chars_ptr);
begin
	if rsrc_gaddr(R_STRING, Index, stradr) = 0 then
	   return null;
	end if;
	strptr := to_address(stradr);
	return strptr;
end;



function rsrc_saddr(
            c_Type    : int16;
            Index     : int16;
            Addr      : void_ptr)
           return int16 is
begin
	aes_control.opcode := 113;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_Type;
	aes_intin(1) := Index;
	aes_addrin(0) := Addr;
	aes_trap;
	return aes_intout(0);
end;


procedure rsrc_obfix(
            tree      : OBJECT_ptr;
            Index     : int16)
           is
    function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, void_ptr);
begin
	aes_control.opcode := 114;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Index;
	aes_addrin(0) := to_address(tree);
	aes_trap;
end;


function rsrc_rcfix(
            rc_header : void_ptr)
           return int16 is
begin
	aes_control.opcode := 115;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := rc_header;
	aes_trap;
	return aes_intout(0);
end;



function shel_read(
            Command   : chars_ptr;
            Tail      : chars_ptr)
           return int16 is
begin
	aes_control.opcode := 120;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := Command.all'Address;
	aes_addrin(1) := Tail.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function shel_write(
            c_Exit    : int16;
            Graphic   : int16;
            Aes       : int16;
            Command   : void_ptr;
            Tail      : chars_ptr)
           return int16 is
begin
	aes_control.opcode := 121;
	aes_control.num_intin := 3;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_Exit;
	aes_intin(1) := Graphic;
	aes_intin(2) := Aes;
	aes_addrin(0) := Command;
	aes_addrin(1) := tail.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function shel_get(
            Buf       : chars_ptr;
            Len       : int16)
           return int16 is
begin
	aes_control.opcode := 122;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Len;
	aes_addrin(0) := Buf.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function shel_put(
            Buf       : chars_ptr;
            Len       : int16)
           return int16 is
begin
	aes_control.opcode := 123;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Len;
	aes_addrin(0) := Buf.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function shel_find(
            buf       : chars_ptr)
           return int16 is
begin
	aes_control.opcode := 124;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := buf.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function shel_envrn(
            result    : out chars_ptr;
            param     : chars_ptr)
           return int16 is
    ptr: chars_ptr;
begin
	aes_control.opcode := 125;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := ptr'Address;
	aes_addrin(1) := param.all'Address;
	aes_trap;
	result := ptr;
	return aes_intout(0);
end;


procedure shel_rdef(
            lpcmd     : chars_ptr;
            lpdir     : chars_ptr) is
begin
	aes_control.opcode := 126;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := lpcmd.all'Address;
	aes_addrin(1) := lpdir.all'Address;
	aes_trap;
end;


procedure shel_wdef(
            lpcmd     : chars_ptr;
            lpdir     : chars_ptr) is
begin
	aes_control.opcode := 127;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := lpcmd.all'Address;
	aes_addrin(1) := lpdir.all'Address;
	aes_trap;
end;


function shel_help(
            sh_hmode  : int16;
            sh_hfile  : chars_ptr;
            sh_hkey   : chars_ptr)
           return int16 is
begin
	aes_control.opcode := 128;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := sh_hmode;
	aes_addrin(0) := sh_hfile.all'Address;
	aes_addrin(1) := sh_hkey.all'Address;
	aes_trap;
	return aes_intout(0);
end;



function vq_aes return int16 is
    ret: int16;
begin
	aes_global(0) := 0;
	ret := appl_init;
	if (aes_global(0) = 0) then
	   ret := -1;
	end if;
	return ret;
end;

function vq_aes return boolean is
begin
	return vq_aes >= 0;
end;





function max(a,b:int16) return int16 is
begin
	if a > b then
		return a;
	else
		return b;
	end if;
end;




function min(a,b:int16) return int16 is
begin
	if a < b then
		return a;
	else
		return b;
	end if;
end;


procedure rc_copy(
            src: in GRECT;
            dst: out GRECT) is
begin
	dst := src;
end;


function rc_equal(
            r1: in GRECT;
            r2: in GRECT)
           return boolean is
begin
	return r1.g_x = r2.g_x and then
	       r1.g_y = r2.g_y and then
	       r1.g_w = r2.g_w and then
	       r1.g_h = r2.g_h;
end;


function rc_intersect(
            src: in GRECT;
            dst: in out GRECT)
           return boolean is
	x,y,w,h:	int16;
begin
	x := max(dst.g_x, src.g_x);
	y := max(dst.g_y, src.g_y);
	w := min(dst.g_x + dst.g_w, src.g_x + src.g_w);
	h := min(dst.g_y + dst.g_h, src.g_y + src.g_h);
	dst.g_x := x;
	dst.g_y := y;
	dst.g_w := w - x;
	dst.g_h := h - y;
	if (w>x) and then (h>y) then
		return true;
	else
		return false;
	end if;
end;


procedure array_to_grect(
            c_array: short_array;
            area   : out GRECT) is
begin
	area.g_x := c_array(0);
	area.g_y := c_array(1);
	area.g_w := c_array(2) - c_array(0) + 1;
	area.g_h := c_array(3) - c_array(1) + 1;
end;


procedure grect_to_array(
            area   : in GRECT;
            c_array: out short_array) is
begin
	c_array(0) := area.g_x;
	c_array(1) := area.g_y;
	c_array(2) := area.g_x + area.g_w - 1;
	c_array(3) := area.g_y + area.g_h - 1;
end;


function Is_Application return boolean is
    is_app: int16
       with Import => True,
       Convention => C,
       External_Name => "_app";
begin
	return is_app /= 0;
end;


function Is_MultiTask return boolean is
begin
	return gl_numapps /= 1;
end;


end Atari.Aes;
