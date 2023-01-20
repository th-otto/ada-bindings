with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;

package body Atari.Xbios is

function to_pointer is new Ada.Unchecked_Conversion(int32, System.Address);
function to_address is new Ada.Unchecked_Conversion(System.Address, int32);


function trap_14_w(n: int16) return int32 is
    use ASCII;
	retvalue: int32;
begin
    asm("move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "addq.w #2,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => int16'Asm_Input("g", n),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;



function Physbase return System.Address is
begin
	return to_pointer(trap_14_w(2));
end;

end Atari.Xbios;
