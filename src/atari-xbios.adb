pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;

package body Atari.Xbios is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function to_pointer is new Ada.Unchecked_Conversion(int32, System.Address);
function to_address is new Ada.Unchecked_Conversion(System.Address, int32);


function trap_14_w(n: int16) return int32 with Inline is
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


function trap_14_ww(n: int16; a: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
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


function trap_14_www(n: int16; a: int16; b: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
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


function trap_14_wwwwwww(n: int16; a: int16; b: int16; c: int16; d: int16; e: int16; f: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %7,-(%%sp)" & LF & HT &
        "move.w %6,-(%%sp)" & LF & HT &
        "move.w %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.w %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 14(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int16'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int16'Asm_Input("r", d),
                   int16'Asm_Input("r", e),
                   int16'Asm_Input("r", f)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wwl(n: int16; a: int16; b: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
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


function trap_14_wlll(n: int16; a: int32; b: int32; c: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 14(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int32'Asm_Input("r", c)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wwwl(n: int16; a: int16; b: int16; c: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %4,-(%%sp)" & LF & HT &
        "move.w %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 10(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int16'Asm_Input("r", b),
                   int32'Asm_Input("r", c)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wwwwl(n: int16; a: int16; b: int16; c: int16; d: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.w %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 12(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int16'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int32'Asm_Input("r", d)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wlwlw(n: int16; a: int32; b: int16; c: int32; d: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %5,-(%%sp)" & LF & HT &
        "move.l %4,-(%%sp)" & LF & HT &
        "move.w %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 14(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int16'Asm_Input("r", b),
                   int32'Asm_Input("r", c),
                   int16'Asm_Input("r", d)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wl(n: int16; a: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
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


function trap_14_wwll(n: int16; a: int16; b: int32; c: int32) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.l %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 12(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int32'Asm_Input("r", c)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wllw(n: int16; a: int32; b: int32; c: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 12(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int16'Asm_Input("r", c)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wllww(n: int16; a: int32; b: int32; c: int16; d: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 14(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int16'Asm_Input("r", d)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wllwwwww(n: int16; a: int32; b: int32; c: int16; d: int16; e: int16; f: int16; g: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %8,-(%%sp)" & LF & HT &
        "move.w %7,-(%%sp)" & LF & HT &
        "move.w %6,-(%%sp)" & LF & HT &
        "move.w %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 20(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int16'Asm_Input("r", d),
                   int16'Asm_Input("r", e),
                   int16'Asm_Input("r", f),
                   int16'Asm_Input("r", g)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_14_wllwwwwwlw(n: int16; a: int32; b: int32; c: int16; d: int16; e: int16; f: int16; g: int16; h: int32; i: int16) return int32 with Inline is
    use ASCII;
    retvalue: int32;
begin
    asm("move.w %10,-(%%sp)" & LF & HT &
        "move.l %9,-(%%sp)" & LF & HT &
        "move.w %8,-(%%sp)" & LF & HT &
        "move.w %7,-(%%sp)" & LF & HT &
        "move.w %6,-(%%sp)" & LF & HT &
        "move.w %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #14" & LF & HT &
        "lea 26(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int16'Asm_Input("r", d),
                   int16'Asm_Input("r", e),
                   int16'Asm_Input("r", f),
                   int16'Asm_Input("r", g),
                   int32'Asm_Input("r", h),
                   int16'Asm_Input("r", i)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


procedure Initmouse(
            c_type  : int16;
            par     : in PARAM;
            mousevec: System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wwll(0, c_type, to_address(par'Address), to_address(mousevec));
end;


function Ssbrk(count: int16) return System.Address is
begin
    return to_pointer(trap_14_ww(1, count));
end;


function Physbase return System.Address is
begin
    return to_pointer(trap_14_w(2));
end;


function Logbase return System.Address is
begin
    return to_pointer(trap_14_w(3));
end;


function Getrez return int16 is
begin
    return int16(trap_14_w(4));
end;


function Setscreen(
            laddr: System.Address;
            paddr: System.Address;
            rez  : int16)
           return int16 is
begin
    return int16(trap_14_wllw(5, to_address(laddr), to_address(paddr), rez));
end;


procedure Setpalette(pallptr: System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wl(6, to_address(pallptr));
end;


function Setcolor(colornum: int16; color: int16) return int16 is
begin
    return int16(trap_14_www(7, colornum, color));
end;


function Floprd(
            buf    : System.Address;
            devno  : int16;
            sectno : int16;
            trackno: int16;
            sideno : int16;
            count  : int16)
           return int16 is
begin
    return int16(trap_14_wllwwwww(8, to_address(buf), int32(0), devno, sectno, trackno, sideno, count));
end;


function Flopwr(
            buf    : System.Address;
            devno  : int16;
            sectno : int16;
            trackno: int16;
            sideno : int16;
            count  : int16)
           return int16 is
begin
    return int16(trap_14_wllwwwww(9, to_address(buf), int32(0), devno, sectno, trackno, sideno, count));
end;


function Flopfmt(
            buf      : System.Address;
            devno    : int16;
            spt      : int16;
            trackno  : int16;
            sideno   : int16;
            shorterlv: int16;
            magic    : int32;
            virgin   : int16)
           return int16 is
begin
    return int16(trap_14_wllwwwwwlw(10, to_address(buf), int32(0), devno, spt, trackno, sideno, shorterlv, magic, virgin));
end;


procedure Dbmsg(
            rsrvd  : int16;
            msg_num: int16;
            msg_arg: int32) is
    dummy: int32;
begin
    dummy := trap_14_wwwl(11, rsrvd, msg_num, msg_arg);
end;


procedure Midiws(cnt: int16; ptr: System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wwl(12, cnt, to_address(ptr));
end;


procedure Mfpint(erno: int16; vector: System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wwl(13, erno, to_address(vector));
end;


function Iorec(dev: int16) return IO_REC_ptr is
    function to_pointer is new Ada.Unchecked_Conversion(int32, IO_REC_ptr);
begin
    return to_pointer(trap_14_ww(14, dev));
end;


function Rsconf(
            baud: int16;
            ctr : int16;
            ucr : int16;
            rsr : int16;
            tsr : int16;
            scr : int16)
           return int32 is
begin
    return trap_14_wwwwwww(15, baud, ctr, ucr, rsr, tsr, scr);
end;


function Keytbl(
            unshift: System.Address;
            shift  : System.Address;
            caps   : System.Address)
           return KEYTAB_ptr is
    function to_pointer is new Ada.Unchecked_Conversion(int32, KEYTAB_ptr);
begin
    return to_pointer(trap_14_wlll(16, to_address(unshift), to_address(shift), to_address(caps)));
end;


function Random return int32 is
begin
    return trap_14_w(17);
end;


procedure Protobt(
            buf     : System.Address;
            serialno: int32;
            disktype: int16;
            execflag: int16) is
    dummy: int32;
begin
    dummy := trap_14_wllww(18, to_address(buf), serialno, disktype, execflag);
end;


function Flopver(
            buf    : System.Address;
            devno  : int16;
            sectno : int16;
            trackno: int16;
            sideno : int16;
            count  : int16)
           return int16 is
begin
    return int16(trap_14_wllwwwww(19, to_address(buf), int32(0), devno, sectno, trackno, sideno, count));
end;


procedure Scrdmp is
    dummy: int32;
begin
    dummy := trap_14_w(20);
end;


function Cursconf(func: int16; rate: int16) return int16 is
begin
    return int16(trap_14_www(21, func, rate));
end;


procedure Settime(time: uint32) is
    dummy: int32;
begin
    dummy := trap_14_wl(22, int32(time));
end;


function Gettime return uint32 is
begin
    return uint32(trap_14_w(23));
end;


procedure Bioskeys is
    dummy: int32;
begin
    dummy := trap_14_w(24);
end;


procedure Ikbdws(count: int16; ptr: System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wwl(25, count, to_address(ptr));
end;


procedure Jdisint(number: int16) is
    dummy: int32;
begin
    dummy := trap_14_ww(26, number);
end;


procedure Jenabint(number: int16) is
    dummy: int32;
begin
    dummy := trap_14_ww(27, number);
end;


function Giaccess(data: uint8; regno: int16) return uint8 is
begin
    return uint8(trap_14_www(28, int16(data), regno));
end;


procedure Offgibit(bitno: int16) is
    dummy: int32;
begin
    dummy := trap_14_ww(29, bitno);
end;


procedure Ongibit(bitno: int16) is
    dummy: int32;
begin
    dummy := trap_14_ww(30, bitno);
end;


procedure Xbtimer(
            timer  : int16;
            control: int16;
            data   : int16;
            vector : System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wwwwl(31, timer, control, data, to_address(vector));
end;


function Dosound(buf: System.Address) return System.Address is
begin
    return to_pointer(trap_14_wl(32, to_address(buf)));
end;


function Setprt(config: int16) return int16 is
begin
    return int16(trap_14_ww(33, config));
end;


function Kbdvbase return KBDVECS_ptr is
    function to_pointer is new Ada.Unchecked_Conversion(int32, KBDVECS_ptr);
begin
    return to_pointer(trap_14_w(34));
end;


function Kbrate(initial: int16; speed: int16) return int16 is
begin
    return int16(trap_14_www(35, initial, speed));
end;


procedure Prtblk(par: in PBDEF) is
    dummy: int32;
begin
    dummy := trap_14_wl(36, to_address(par'Address));
end;


procedure Vsync is
    dummy: int32;
begin
    dummy := trap_14_w(37);
end;


function Supexec(func: supexec_func) return int32 is
    function to_address is new Ada.Unchecked_Conversion(supexec_func, int32);
begin
    return trap_14_wl(38, to_address(func));
end;


procedure Puntaes is
    dummy: int32;
begin
    dummy := trap_14_w(39);
end;


function Floprate(devno: int16; newrate: int16) return int16 is
begin
    return int16(trap_14_www(39, devno, newrate));
end;


function Blitmode(mode: int16) return int16 is
begin
    return int16(trap_14_ww(64, mode));
end;


function DMAread(
            sector: int32;
            count : int16;
            buffer: System.Address;
            devno : int16)
           return int16 is
begin
    return int16(trap_14_wlwlw(42, sector, count, to_address(buffer), devno));
end;


function DMAwrite(
            sector: int32;
            count : int16;
            buffer: System.Address;
            devno : int16)
           return int16 is
begin
    return int16(trap_14_wlwlw(43, sector, count, to_address(buffer), devno));
end;


function Bconmap(devno: int16) return int32 is
begin
    return trap_14_ww(44, devno);
end;


function NVMaccess(
            opcode: int16;
            start : int16;
            count : int16;
            buffer: System.Address)
           return int16 is
begin
    return int16(trap_14_wwwwl(46, opcode, start, count, to_address(buffer)));
end;



procedure Waketime(date: uint16; time: uint16) is
    dummy: int32;
begin
    dummy := trap_14_www(47, int16(date), int16(time));
end;



function EsetShift(shftMode: int16) return int16 is
begin
    return int16(trap_14_ww(80, shftMode));
end;


function EgetShift return int16 is
begin
    return int16(trap_14_w(81));
end;


function EsetBank(bankNum: int16) return int16 is
begin
    return int16(trap_14_ww(82, bankNum));
end;


function EsetColor(colorNum: int16; color: int16) return int16 is
begin
    return int16(trap_14_www(83, colorNum, color));
end;


procedure EsetPalette(colorNum: int16; count: int16; palettePtr: System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wwwl(84, colorNum, count, to_address(palettePtr));
end;


procedure EgetPalette(colorNum: int16; count: int16; palettePtr: System.Address) is
    dummy: int32;
begin
    dummy := trap_14_wwwl(85, colorNum, count, to_address(palettePtr));
end;


function EsetGray(swtch: int16) return int16 is
begin
    return int16(trap_14_ww(86, swtch));
end;


function EsetSmear(swtch: int16) return int16 is
begin
    return int16(trap_14_ww(87, swtch));
end;


function CacheCtrl(opcode: int16; param: int16) return int32 is
begin
    return trap_14_www(160, opcode, param);
end;


function WdgCtrl(opcode: int16) return int32 is
begin
    return trap_14_ww(161, opcode);
end;


function ExtRsConf(command: int16; device: int16; param: int32) return int32 is
begin
    return trap_14_wwwl(162, command, device, param);
end;


end Atari.Xbios;
