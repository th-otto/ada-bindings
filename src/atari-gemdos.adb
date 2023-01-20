with System.Machine_Code;
use System.Machine_Code;

package body Atari.gemdos is

function trap_1_w(n: int16) return int32 is
    use ASCII;
	retvalue: int32;
begin
    asm("move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "addq.w #2,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => int16'Asm_Input("g", n),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_1_ww(n: int16; a: int16) return int32 is
    use ASCII;
	retvalue: int32;
begin
    asm("move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "addq.w #4,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


procedure Pterm0 is
	dummy: int32;
begin
	dummy := trap_1_w(0);
end;


end Atari.gemdos;
