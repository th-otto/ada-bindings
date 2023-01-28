pragma No_Strict_Aliasing;

with Interfaces; use Interfaces;

package body Atari.Aes.Filesel is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);


function Input(
            path       : chars_ptr;
            file       : chars_ptr;
            exit_button: out int16)
           return boolean is
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
	return aes_intout(0) /= 0;
end;


--  fsel_exinput
function Input(
            path       : chars_ptr;
            file       : chars_ptr;
            exit_button: out int16;
            title      : const_chars_ptr)
           return boolean is
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
	return aes_intout(0) /= 0;
end;


--  fsel_boxinput
function Input(
            path       : chars_ptr;
            file       : chars_ptr;
            exit_button: out int16;
            title      : const_chars_ptr;
            callback   : FSEL_CALLBACK)
           return boolean is
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
	return aes_intout(0) /= 0;
end;


end Atari.Aes.Filesel;
