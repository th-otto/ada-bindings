pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;
with Interfaces.C; use Interfaces.C;
with Interfaces;   use Interfaces;

package body Atari.Aes is

aes_control: aliased AESContrl;
aes_intin: aliased AESIntIn;
aes_intout: aliased AESIntOut;
aes_addrin: aliased AESAddrIn;
aes_addrout: aliased AESAddrOut;
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
    function to_address is new Ada.Unchecked_Conversion(AESPB_ptr, System.Address);
begin
    asm("move.l %0,%%d1" & LF & HT &
        "move.w #200,%%d0" & LF & HT &
        "trap #2" & LF & HT,
        volatile => true,
        inputs => System.Address'Asm_Input("g", to_address(pb)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
end;


procedure aes_trap is
begin
	aes(aes_pb'Access);
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
            ap_pbuff  : System.Address)
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
            ap_pbuff  : System.Address)
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
            length    : int16;
            ap_pbuff  : array_8_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(array_8_ptr, System.Address);
begin
	return appl_write(ap_id, length, to_address(ap_pbuff));
end;


function appl_find(name: chars_ptr) return int16 is
    function to_address is new Ada.Unchecked_Conversion(chars_ptr, System.Address);
begin
	aes_control.opcode := 13;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := to_address(name);
	aes_trap;
	return aes_intout(0);
end;


function appl_find(name: String) return int16 is
    c_str: String := name & ASCII.NUL;
    function to_address is new Ada.Unchecked_Conversion(System.Address, chars_ptr);
begin
	return appl_find(to_address(c_str'Address));
end;


function appl_tplay(
            mem       : System.Address;
            num       : int16;
            scale     : int16)
           return int16 is
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
	return aes_intout(0);
end;


function appl_trecord(
            mem       : System.Address;
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
    function to_address is new Ada.Unchecked_Conversion(chars_ptr, System.Address);
begin
	aes_control.opcode := 18;
	aes_control.num_intin := 1;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := mode;
	aes_addrin(0) := to_address(fname);
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
    function to_address is new Ada.Unchecked_Conversion(System.Address, chars_ptr);
begin
	return appl_search(mode, to_address(c_str'Address), c_type, ap_id);
end;


function appl_exit return int16 is
begin
	aes_control.opcode := 19;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	return aes_intout(0);
end;


function appl_control(
            ap_cid    : int16;
            ap_cwhat  : int16;
            ap_cout   : System.Address)
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
           return int16 is
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
	return aes_intout(0);
end;


function appl_xgetinfo(
            c_type    : int16;
            out1      : out int16;
            out2      : out int16;
            out3      : out int16;
            out4      : out int16)
           return int16 is
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
		return 0;
	end if;
	return appl_getinfo(c_type, out1, out2, out3, out4);
end;


function appl_getinfo(
            c_type    : int16;
            out1      : chars_ptr;
            out2      : chars_ptr;
            out3      : chars_ptr;
            out4      : chars_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(chars_ptr, System.Address);
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
		return 0;
	end if;
	aes_control.opcode := 130;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_intin(0) := c_type;
	aes_addrin(0) := to_address(out1);
	aes_addrin(1) := to_address(out2);
	aes_addrin(2) := to_address(out3);
	aes_addrin(3) := to_address(out4);
	aes_trap;
	return aes_intout(0);
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


function evnt_mouse(
            EnterExit  : int16;
            InX        : int16;
            InY        : int16;
            InW        : int16;
            InH        : int16;
            OutX       : out int16;
            OutY       : out int16;
            ButtonState: out int16;
            KeyState   : out int16)
           return int16 is
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
	return aes_intout(0);
end;


function evnt_mesag(
            MesagBuf  : short_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(short_ptr, System.Address);
begin
	aes_control.opcode := 23;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := to_address(MesagBuf);
	aes_trap;
	return aes_intout(0);
end;


function evnt_mesag(
            MesagBuf  : array_8_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(array_8_ptr, short_ptr);
begin
	return evnt_mesag(to_address(MesagBuf));
end;


function evnt_timer(
            Interval  : uint32)
           return int16 is
begin
	aes_control.opcode := 24;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := int16(Interval and 16#ffff#);
	aes_intin(1) := int16(Shift_Right(Interval, 16));
	aes_trap;
	return aes_intout(0);
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
            MesagBuf   : array_8_ptr;
            Interval   : uint32;
            OutX       : out int16;
            OutY       : out int16;
            ButtonState: out int16;
            KeyState   : out int16;
            Key        : out int16;
            ReturnCount: out int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(array_8_ptr, System.Address);
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
	aes_addrin(0) := to_address(MesagBuf);
	aes_trap;
	OutX := aes_intout(1);
	OutY := aes_intout(2);
	ButtonState := aes_intout(2);
	KeyState := aes_intout(3);
	Key := aes_intout(4);
	ReturnCount := aes_intout(5);
	return aes_intout(0);
end;



function evnt_multi(
            em_i       : in EVMULT_IN;
            MesagBuf   : array_8_ptr;
            em_o       : out EVMULT_OUT)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(array_8_ptr, System.Address);
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
	aes_addrin(0) := to_address(MesagBuf);
	aes_trap;
	em_o.emo_events := uint16(aes_intout(0));
	em_o.emo_mouse.p_x := aes_intout(1);
	em_o.emo_mouse.p_y := aes_intout(2);
	em_o.emo_mbutton := uint16(aes_intout(2));
	em_o.emo_kmeta := uint16(aes_intout(3));
	em_o.emo_kreturn := aes_intout(4);
	em_o.emo_mclicks := aes_intout(5);
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
            me_tree: in AEStree;
            me_mode: int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(AEStree, System.Address);
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
            me_tree : in AEStree;
            me_item : int16;
            me_check: int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(AEStree, System.Address);
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
            me_tree  : in AEStree;
            me_item  : int16;
            me_enable: int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(AEStree, System.Address);
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
            me_tree  : in AEStree;
            me_item  : int16;
            me_normal: int16)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(AEStree, System.Address);
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
            me_tree: in AEStree;
            me_item: int16;
            me_text: const_chars_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(AEStree, System.Address);
    function to_address2 is new Ada.Unchecked_Conversion(const_chars_ptr, System.Address);
begin
	aes_control.opcode := 34;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_addrin(0) := to_address(me_tree);
	aes_addrin(1) := to_address2(me_text);
	aes_trap;
	return aes_intout(0);
end;


function menu_register(
            ap_id  : int16;
            me_text: const_chars_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, System.Address);
begin
	aes_control.opcode := 35;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := ap_id;
	aes_addrin(0) := to_address(me_text);
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
            me_menu : in MENU;
            me_xpos : int16;
            me_ypos : int16;
            me_mdata: out MENU)
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
            me_tree : in AEStree;
            me_item : int16;
            me_mdata: MENU_ptr)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(MENU_ptr, System.Address);
begin
	aes_control.opcode := 37;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_flag;
	aes_intin(1) := me_item;
	aes_addrin(0) := me_tree'Address;
	aes_addrin(1) := to_address(me_mdata);
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
            me_tree : in AEStree;
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
	aes_addrin(0) := me_tree'Address;
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

function graf_mouse(
            Form       : Mouse_Type;
            FormAddress: MFORM_const_ptr := null)
           return int16 is
    function to_address is new Ada.Unchecked_Conversion(MFORM_const_ptr, System.Address);
begin
	aes_control.opcode := 78;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Form'Enum_Rep;
	aes_addrin(0) := to_address(FormAddress);
	aes_trap;
	return aes_intout(0);
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



function form_alert(fo_adefbttn: int16; alertstr: chars_ptr) return int16 is
    function to_address is new Ada.Unchecked_Conversion(chars_ptr, System.Address);
begin
	aes_control.opcode := 52;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := fo_adefbttn;
	aes_addrin(0) := to_address(alertstr);
	aes_trap;
	return aes_intout(0);
end;


function form_alert(fo_adefbttn: int16; alertstr: String) return int16 is
    c_str: String := alertstr & ASCII.NUL;
    function to_address is new Ada.Unchecked_Conversion(System.Address, chars_ptr);
begin
	return form_alert(fo_adefbttn, to_address(c_str'Address));
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
            r         : GRECT_const_ptr)
           return int16 is
begin
	return wind_create(Parts, r.g_x, r.g_y, r.g_w, r.g_h);
end;


function wind_xcreate(
            Parts     : int16;
            Wx        : int16;
            Wy        : int16;
            Ww        : int16;
            Wh        : int16;
            OutX      : short_ptr;
            OutY      : short_ptr;
            OutW      : short_ptr;
            OutH      : short_ptr)
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
	OutX.all := aes_intout(1);
	OutY.all := aes_intout(2);
	OutW.all := aes_intout(3);
	OutH.all := aes_intout(4);
	return aes_intout(0);
end;


function wind_xcreate(
            Parts     : int16;
            r         : GRECT_const_ptr;
            ret       : GRECT_ptr)
           return int16 is
begin
	return wind_xcreate(Parts, r.g_x, r.g_y, r.g_w, r.g_h, ret.g_x'Access, ret.g_y'Access, ret.g_w'Access, ret.g_h'Access);
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
            r           : GRECT_const_ptr)
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
            W1          : short_ptr;
            W2          : short_ptr;
            W3          : short_ptr;
            W4          : short_ptr)
           return int16 is
    type short_ptr_ptr is access all short_ptr;
    function to_address is new Ada.Unchecked_Conversion(System.Address, short_ptr_ptr);
    ptr: System.Address;
    pptr: short_ptr_ptr;
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
	      aes_intin(2) := W1.all;
	      aes_control.num_intin := 3;
	   when WF_INFO | WF_NAME =>
	      aes_control.num_intin := 4;
	      ptr := aes_intin(2)'Address;
	      pptr := to_address(ptr);
	      pptr.all := W1;
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
	       W1.all := aes_intout(1);
	       W2.all := aes_intout(2);
	       W3.all := aes_intout(3);
	       W4.all := aes_intout(4);
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
            W1          : short_ptr)
           return int16 is
    dummy: aliased int16;
begin
	return wind_get(WindowHandle, what, W1, dummy'Unchecked_Access, dummy'Unchecked_Access, dummy'Unchecked_Access);
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
    function to_address is new Ada.Unchecked_Conversion(System.Address, const_chars_ptr_ptr);
    ptr: System.Address;
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
            v           : System.Address;
            W3          : int16 := 0)
           return int16 is
    type address_ptr is access all System.Address;
    function to_address is new Ada.Unchecked_Conversion(System.Address, address_ptr);
    ptr: System.Address;
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


function wind_calc(
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
           return int16 is
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
	return aes_intout(0);
end;


function wind_calc(
            c_Type    : int16;
            Parts     : int16;
            c_In      : in GRECT;
            c_Out     : out GRECT)
           return int16 is
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
	return aes_intout(0);
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


function Is_Application return boolean is
    is_app: int16
       with Import => True,
       Convention => C,
       External_Name => "_app";
begin
	return is_app /= 0;
end;


end Atari.Aes;
