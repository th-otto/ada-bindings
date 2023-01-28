pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;
with Interfaces; use Interfaces;

package body Atari.Aes is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);


aes_pb: aliased AESPB := (
    global => aes_global'Access,
    control => aes_control'Access,
    intin => aes_intin'Access,
    intout => aes_intout'Access,
    addrin => aes_addrin'Access,
    addrout => aes_addrout'Access
);


procedure crystal(pb: AESPB_ptr) is
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
	crystal(aes_pb'Access);
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
            r         : in Rectangle)
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
            r         : in Rectangle;
            ret       : out Rectangle)
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
            r           : in Rectangle)
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
function wind_get(
            WindowHandle: int16;
            What        : wind_get_set_type;
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
function wind_set(
            WindowHandle: int16;
            What        : wind_get_set_type;
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


procedure rc_copy(
            src: in Rectangle;
            dst: out Rectangle) is
begin
	dst := src;
end;


function rc_equal(
            r1: in Rectangle;
            r2: in Rectangle)
           return boolean is
begin
	return r1.g_x = r2.g_x and then
	       r1.g_y = r2.g_y and then
	       r1.g_w = r2.g_w and then
	       r1.g_h = r2.g_h;
end;


function rc_intersect(
            src: in Rectangle;
            dst: in out Rectangle)
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
            area   : out Rectangle) is
begin
	area.g_x := c_array(0);
	area.g_y := c_array(1);
	area.g_w := c_array(2) - c_array(0) + 1;
	area.g_h := c_array(3) - c_array(1) + 1;
end;


procedure grect_to_array(
            area   : in Rectangle;
            c_array: out short_array) is
begin
	c_array(0) := area.g_x;
	c_array(1) := area.g_y;
	c_array(2) := area.g_x + area.g_w - 1;
	c_array(3) := area.g_y + area.g_h - 1;
end;


function vq_aes return int16 is
    ret: int16;
begin
	aes_global(0) := 0;
	aes_control.opcode := 10;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	ret := aes_intout(0);
	if (aes_global(0) = 0) then
	   ret := -1;
	end if;
	return ret;
end;


function vq_aes return boolean is
begin
	return vq_aes >= 0;
end;


end Atari.Aes;
