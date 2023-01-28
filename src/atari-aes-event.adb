pragma No_Strict_Aliasing;

with Interfaces; use Interfaces;

package body Atari.Aes.Event is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);


function Keybd return int16 is
begin
	aes_control.opcode := 20;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	return aes_intout(0);
end;


function Button(
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


procedure Mouse(
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


function Message(MesagBuf: out short_array) return int16 is
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


function Message(MesagBuf: out Message_Buffer) return int16 is
begin
	return evnt_mesag(MesagBuf.arr);
end;


procedure Timer(
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


function Timer(
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



function Multi(
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



function Multi(
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


function Double_Click(
            ToSet     : int16;
            SetGet    : boolean)
           return int16 is
begin
	aes_control.opcode := 26;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := ToSet;
	aes_intin(1) := SetGet'Enum_Rep;
	aes_trap;
	return aes_intout(0);
end;


end Atari.Aes.Event;
