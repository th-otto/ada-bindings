pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;

Package body Atari.Bios is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

-- function to_pointer is new Ada.Unchecked_Conversion(int32, System.Address);
function to_address is new Ada.Unchecked_Conversion(System.Address, int32);



function trap_13_w(n: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %1,-(%%sp)" & LF & HT &
        "trap #13" & LF & HT &
        "addq.w #2,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => int16'Asm_Input("g", n),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_13_ww(n: int16; a: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #13" & LF & HT &
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


function trap_13_www(n: int16; a: int16; b: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #13" & LF & HT &
        "addq.w #6,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int16'Asm_Input("r", b)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_13_wwl(n: int16; a: int16; b: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #13" & LF & HT &
        "addq.w #8,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int32'Asm_Input("r", b)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_13_wl(n: int16; a: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #13" & LF & HT &
        "addq.w #6,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_13_wwlwww(n: int16; a: int16; b: int32; c: int16; d: int16; e: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %6,-(%%sp)" & LF & HT &
        "move.w %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #13" & LF & HT &
        "lea 14(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int16'Asm_Input("r", d),
                   int16'Asm_Input("r", e)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_13_wwlwwwl(n: int16; a: int16; b: int32; c: int16; d: int16; e: int16; f: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %7,-(%%sp)" & LF & HT &
        "move.w %6,-(%%sp)" & LF & HT &
        "move.w %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #13" & LF & HT &
        "lea 18(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int16'Asm_Input("r", d),
                   int16'Asm_Input("r", e),
                   int32'Asm_Input("r", f)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


procedure Getmpb(ptr: out MPB) is
    dummy: int32;
begin
    dummy := trap_13_wl(0, to_address(ptr'Address));
end;


function Bconstat(dev: int16) return int16 is
begin
    return int16(trap_13_ww(1, dev));
end;


function Bconin(dev: int16) return int32 is
begin
    return trap_13_ww(2, dev);
end;


function Bconout(dev: int16; c: int16) return int32 is
begin
    return trap_13_www(3, dev, c);
end;


function Rwabs(
            rwflag: int16;
            buf   : System.Address;
            cnt   : int16;
            recnr : int16;
            dev   : int16)
           return int32 is
begin
    return trap_13_wwlwww(4, rwflag, to_address(buf), cnt, recnr, dev);
end;


function Rwabs(
            rwflag: int16;
            buf   : System.Address;
            cnt   : int16;
            dev   : int16;
            sector: int32)
           return int32 is
begin
    return trap_13_wwlwwwl(4, rwflag, to_address(buf), cnt, int16(-1), dev, sector);
end;


function Setexc(
            number : int16;
            exchdlr: void_ptr)
           return void_ptr is
    function to_address is new Ada.Unchecked_Conversion(void_ptr, int32);
    function to_pointer is new Ada.Unchecked_Conversion(int32, void_ptr);
begin
    return to_pointer(trap_13_wwl(5, number, to_address(exchdlr)));
end;


function Tickcal return int32 is
begin
    return trap_13_w(6);
end;


function Getbpb(dev: int16) return BPB_ptr is
    function to_pointer is new Ada.Unchecked_Conversion(int32, BPB_ptr);
begin
    return to_pointer(trap_13_ww(7, dev));
end;


function Bcostat(dev: int16) return int32 is
begin
    return trap_13_ww(8, dev);
end;


function Mediach(dev: int16) return int32 is
begin
    return trap_13_ww(9, dev);
end;


function Drvmap return int32 is
begin
    return trap_13_w(10);
end;


function Kbshift(mode: int16) return int32 is
begin
    return trap_13_ww(11, mode);
end;


function Getshift return int32 is
    mode: constant int16 := int16(-1);
begin
    return Kbshift(mode);
end;


end Atari.Bios;
