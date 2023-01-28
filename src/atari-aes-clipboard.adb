pragma No_Strict_Aliasing;

package body Atari.Aes.Clipboard is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Read(Scrappath: chars_ptr) return int16 is
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


function Write(Scrappath: const_chars_ptr) return int16 is
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


function Clear return boolean is
begin
    aes_control.opcode := 82;
    aes_control.num_intin := 0;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_trap;
    return aes_intout(0) /= 0;
end;


end Atari.Aes.Clipboard;
