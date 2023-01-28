pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Interfaces; use Interfaces;

package body Atari.Aes.Application is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

has_agi: int16 := -1;


procedure stripnull(str: in out String) is
begin
	if str'Last > 0 and then str(str'Last) = Character'First then
		str := str(str'First .. str'Last - 1);
	end if;
end;


function Version return int16 is
begin
	return aes_global(0);
end;


function Num_Apps return int16 is
begin
	return aes_global(1);
end;


function Id return int16 is
begin
	return aes_global(2);
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
	return Num_Apps /= 1;
end;


function Init return int16 is
begin
	aes_control.opcode := 10;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	return aes_intout(0);
end;


function Read(
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


function Write(
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


function Write(
            ap_id     : int16;
            ap_pbuff  : Event.Message_Buffer)
           return int16 is
begin
	return Write(ap_id, 16, ap_pbuff'Address);
end;


function Find(name: const_chars_ptr) return int16 is
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


function Find(name: String) return int16 is
    c_str: constant String := name & ASCII.NUL;
    ptr: constant void_ptr := c_str(c_str'First)'Address;
begin
	return Find(const_chars_ptr'Deref(ptr));
end;


procedure Tplay(
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


function Trecord(
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


function Bitvector_Set(
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
procedure Yield is
    use ASCII;
begin
    asm("move.w #201,%%d0" & LF & HT &
        "trap #2" & LF & HT,
        volatile => true,
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
end;


function Search(
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


function Search(
            mode      : int16;
            fname     : in out String;
            c_type    : out int16;
            ap_id     : out int16)
           return int16 is
    c_str: String := fname & ASCII.NUL;
    ptr: constant void_ptr := c_str(c_str'First)'Address;
    ret: int16;
begin
	ret := appl_search(mode, chars_ptr'Deref(ptr), c_type, ap_id);
	stripnull(c_str);
	fname := c_str;
	return ret;
end;


procedure AExit is
begin
	aes_control.opcode := 19;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
end;


function Control(
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


function Get_Info_Internal(
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


function Get_Info(
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
	return Get_Info_Internal(c_type, out1, out2, out3, out4);
end;


function Get_Info(
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


end Atari.Aes.Application;
