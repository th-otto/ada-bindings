pragma No_Strict_Aliasing;

package body Atari.Aes.Shell is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Read(Command: chars_ptr; Tail: chars_ptr) return int16 is
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


function Write(
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


function Get(
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


function Put(
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


function Find(
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


function Environ(
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


procedure Read_Default(
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


procedure Write_Default(
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


function Help(
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


end Atari.Aes.Shell;
