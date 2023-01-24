pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;
with Interfaces;
use Interfaces;

package body Atari.gemdos is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function to_pointer is new Ada.Unchecked_Conversion(int32, System.Address);
function to_address is new Ada.Unchecked_Conversion(System.Address, int32);


function trap_1_w(n: int16) return int32 with Inline is
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


function trap_1_ww(n: int16; a: int16) return int32 with Inline is
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


function trap_1_www(n: int16; a: int16; b: int16) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.w %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
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


function trap_1_wl(n: int16; a: int32) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
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


function trap_1_wlw(n: int16; a: int32; b:int16) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.w %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "addq.w #8,%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int16'Asm_Input("r", b)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_1_wwl(n: int16; a: int16; b:int32) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
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


function trap_1_wwll(n: int16; a: int16; b:int32; c:int32) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.l %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
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


function trap_1_wwlll(n: int16; a: int16; b: int32; c: int32; d: int32) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.l %5,-(%%sp)" & LF & HT &
        "move.l %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "lea 16(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int32'Asm_Input("r", c),
                   int32'Asm_Input("r", d)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_1_wll(n: int16; a: int32; b: int32) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.l %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "lea 10(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int32'Asm_Input("r", b)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_1_wlww(n: int16; a: int32; b: int16; c: int16) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.w %4,-(%%sp)" & LF & HT &
        "move.w %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "lea 10(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int16'Asm_Input("r", b),
                   int16'Asm_Input("r", c)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_1_wlwww(n: int16; a: int32; b: int16; c: int16; d: int16) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.w %5,-(%%sp)" & LF & HT &
        "move.w %4,-(%%sp)" & LF & HT &
        "move.w %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "lea 12(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int16'Asm_Input("r", b),
                   int16'Asm_Input("r", c),
                   int16'Asm_Input("r", d)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;
Pragma Unreferenced(trap_1_wlwww);


function trap_1_wlllll(n: int16; a: int32; b: int32; c: int32; d: int32; e: int32) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.l %6,-(%%sp)" & LF & HT &
        "move.l %5,-(%%sp)" & LF & HT &
        "move.l %4,-(%%sp)" & LF & HT &
        "move.l %3,-(%%sp)" & LF & HT &
        "move.l %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "lea 22(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int32'Asm_Input("r", a),
                   int32'Asm_Input("r", b),
                   int32'Asm_Input("r", c),
                   int32'Asm_Input("r", d),
                   int32'Asm_Input("r", e)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


function trap_1_wwwll(n: int16; a: int16; b: int16; c: int32; d: int32) return int32 with Inline is
    use ASCII;
	retvalue: int32;
begin
    asm("move.l %5,-(%%sp)" & LF & HT &
        "move.l %4,-(%%sp)" & LF & HT &
        "move.w %3,-(%%sp)" & LF & HT &
        "move.w %2,-(%%sp)" & LF & HT &
        "move.w %1,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "lea 14(%%sp),%%sp" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        outputs => int32'Asm_Output("=r", retvalue),
        inputs => (int16'Asm_Input("g", n),
                   int16'Asm_Input("r", a),
                   int16'Asm_Input("r", b),
                   int32'Asm_Input("r", c),
                   int32'Asm_Input("r", d)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
    return retvalue;
end;


procedure stripnull(str: in out String) is
begin
	if str'Last > 0 and then str(str'Last) = Character'First then
		str := str(str'First .. str'Last - 1);
	end if;
end;


procedure Pterm0 is
	dummy: int32;
begin
	dummy := trap_1_w(0);
end;


function Cconin return int32 is
begin
	return trap_1_w(1);
end;


procedure Cconout(c: int16) is
	dummy: int32;
begin
	dummy := trap_1_ww(2, c);
end;


function Cauxin return int16 is
begin
	return int16(trap_1_w(3));
end;


procedure Cauxout(c: int16) is
	dummy: int32;
begin
	dummy := trap_1_ww(4, c);
end;


function Cprnout(c: int16) return int16 is
begin
	return int16(trap_1_ww(5, c));
end;


function Crawio(c: int16) return int32 is
begin
	return trap_1_ww(6, c);
end;


function Crawcin return int32 is
begin
	return trap_1_w(7);
end;


function Cnecin return int32 is
begin
	return trap_1_w(8);
end;


function Cconws(buf: const_chars_ptr) return int32 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return trap_1_wl(9, to_address(buf));
end;


function Cconws(buf: String) return int32 is
    c_str: String := buf & ASCII.NUL;
begin
	return trap_1_wl(9, to_address(c_str'Address));
end;


procedure Cconws(buf: String) is
    dummy: int32;
begin
	dummy := Cconws(buf);
end;


function Cconrs(buf: out CCONLINE) return int32 is
begin
	return trap_1_wl(10, to_address(buf'Address));
end;


function Cconis return boolean is
begin
	return int16(trap_1_w(11)) /= 0;
end;


function Dsetdrv(drv: int16) return int32 is
begin
	return trap_1_ww(14, drv);
end;


function Cconos return boolean is
begin
	return int16(trap_1_w(16)) /= 0;
end;


function Cprnos return boolean is
begin
	return int16(trap_1_w(17)) /= 0;
end;


function Cauxis return boolean is
begin
	return int16(trap_1_w(18)) /= 0;
end;


function Cauxos return boolean is
begin
	return int16(trap_1_w(19)) /= 0;
end;


function Maddalt(start: System.Address; size: int32) return int32 is
begin
	return trap_1_wll(20, to_address(start), size);
end;


function Srealloc(len: int32) return int32 is
begin
	return trap_1_wl(21, len);
end;


function Slbopen(
            fname: const_chars_ptr;
            path : const_chars_ptr;
            ver  : int32;
            hnd  : out SLB_HANDLE;
            exec : out SLB_EXEC)
           return int32 is
	function to_address2 is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return trap_1_wlllll(22, to_address2(fname), to_address2(path), ver, to_address(hnd'Address), to_address(exec'Address));
end;


function Slbopen(
            fname: const_chars_ptr;
            path : const_chars_ptr;
            ver  : int32;
            shlb : out SLB)
           return int32 is
begin
	return Slbopen(fname, path, ver, shlb.handle, shlb.exec);
end;


function Slbclose(hnd: SLB_HANDLE) return int32 is
	function to_address is new Ada.Unchecked_Conversion(SLB_HANDLE, int32);
begin
	return trap_1_wl(23, to_address(hnd));
end;


function Dgetdrv return int16 is
begin
	return int16(trap_1_w(25));
end;


procedure Fsetdta(buf: DTA_ptr) is
	function to_address is new Ada.Unchecked_Conversion(DTA_PTR, int32);
	dummy: int32;
begin
	dummy := trap_1_wl(26, to_address(buf));
end;


function Super(stack: System.Address) return System.Address is
begin
	return to_pointer(trap_1_wl(32, to_address(stack)));
end;


procedure SuperToUser(stack: System.Address) is
    use ASCII;
	sp_backup: int32;
begin
    asm("move.l %%sp,%0" & LF & HT &
        "move.l %1,-(%%sp)" & LF & HT &
        "move.w #32,-(%%sp)" & LF & HT &
        "trap #1" & LF & HT &
        "move.l %0,%%sp" & LF & HT,
        outputs => int32'Asm_Output("=&r", sp_backup),
        inputs => (int32'Asm_Input("g", to_address(stack))),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory",
        volatile => true
    );
end;


function Tgetdate return uint16 is
begin
	return uint16(trap_1_w(42));
end;


procedure Tsetdate(date: uint16) is
	dummy: int32;
begin
	dummy := trap_1_ww(43, int16(date));
end;


function Tgettime return uint16 is
begin
	return uint16(trap_1_w(44));
end;


procedure Tsettime(time: uint16) is
	dummy: int32;
begin
	dummy := trap_1_ww(45, int16(time));
end;


function Fgetdta return DTA_ptr is
	function to_pointer is new Ada.Unchecked_Conversion(int32, DTA_ptr);
begin
	return to_pointer(trap_1_w(47));
end;


function Sversion return uint16 is
begin
	return uint16(trap_1_w(48));
end;


procedure Ptermres(keepcnt: int32; retcode: int16) is
	dummy: int32;
begin
	dummy := trap_1_wlw(49, keepcnt, retcode);
end;


function Sconfig(mode: int16; flags: int32) return int32 is
begin
	return trap_1_wwl(51, mode, flags);
end;


function Dfree(buf: out DISKINFO; driveno: int16) return int16 is
begin
	return int16(trap_1_wlw(54, to_address(buf'Address), driveno));
end;


function Dcreate(path: const_chars_ptr) return int16 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return int16(trap_1_wl(57, to_address(path)));
end;


function Dcreate(path: String) return int16 is
    c_str: String := path & ASCII.NUL;
begin
	return int16(trap_1_wl(57, to_address(c_str'Address)));
end;


function Ddelete(path: const_chars_ptr) return int16 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return int16(trap_1_wl(58, to_address(path)));
end;


function Ddelete(path: String) return int16 is
    c_str: String := path & ASCII.NUL;
begin
	return int16(trap_1_wl(58, to_address(c_str'Address)));
end;


function Dsetpath(path: const_chars_ptr) return int16 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return int16(trap_1_wl(59, to_address(path)));
end;


function Dsetpath(path: String) return int16 is
    c_str: String := path & ASCII.NUL;
begin
	return int16(trap_1_wl(59, to_address(c_str'Address)));
end;


function Fcreate(filename: const_chars_ptr; attr: uint16) return int32 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return trap_1_wlw(60, to_address(filename), int16(attr));
end;


function Fcreate(filename: String; attr: uint16) return int32 is
    c_str: String := filename & ASCII.NUL;
begin
	return trap_1_wlw(60, to_address(c_str'Address), int16(attr));
end;


function Fopen(filename: const_chars_ptr; mode: int16) return int32 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return trap_1_wlw(61, to_address(filename), mode);
end;


function Fopen(filename: String; mode: int16) return int32 is
    c_str: String := filename & ASCII.NUL;
begin
	return trap_1_wlw(61, to_address(c_str'Address), mode);
end;


function Fclose(handle: int16) return int16 is
begin
	return int16(trap_1_ww(62, handle));
end;


function Fread(handle: int16; count: int32; buf: System.Address) return int32 is
begin
	return trap_1_wwll(63, handle, count, to_address(buf));
end;


function Fwrite(handle: int16; count: int32; buf: System.Address) return int32 is
begin
	return trap_1_wwll(64, handle, count, to_address(buf));
end;


function Fdelete(filename: const_chars_ptr) return int16 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return int16(trap_1_wl(65, to_address(filename)));
end;


function Fdelete(filename: String) return int16 is
    c_str: String := filename & ASCII.NUL;
begin
	return int16(trap_1_wl(65, to_address(c_str'Address)));
end;


function Fseek(offset: int32; handle: int16; seekmode: int16) return int32 is
begin
	return trap_1_wlww(66, offset, handle, seekmode);
end;


function Fattrib(filename: const_chars_ptr; wflag: boolean; attrib: uint16) return int16 is
	function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return int16(trap_1_wlww(67, to_address(filename), boolean'Pos(wflag), int16(attrib)));
end;


function Fattrib(filename: String; wflag: boolean; attrib: uint16) return int16 is
    c_str: String := filename & ASCII.NUL;
begin
	return int16(trap_1_wlww(67, to_address(c_str'Address), boolean'Pos(wflag), int16(attrib)));
end;


function Mxalloc(number: int32; mode: int16) return System.Address is
begin
	return to_pointer(trap_1_wlw(68, number, mode));
end;


function Mxalloc(mode: int16) return int32 is
begin
	return trap_1_wlw(68, int32(-1), mode);
end;


function Fdup(handle: int16) return int32 is
begin
	return trap_1_ww(69, handle);
end;


function Fforce(stdh: int16; nonstdh: int16) return int32 is
begin
	return trap_1_www(70, stdh, nonstdh);
end;


function Dgetpath(path: chars_ptr; driveno: int16) return int16 is
	function to_address is new Ada.Unchecked_Conversion(chars_ptr, int32);
begin
	return int16(trap_1_wlw(71, to_address(path), driveno));
end;


function Dgetpath(path: out String; driveno: int16) return int16 is
	ret: int16;
begin
	ret := int16(trap_1_wlw(71, to_address(path'Address), driveno));
	stripnull(path);
	return ret;
end;


function Malloc(number: int32) return System.Address is
begin
	return to_pointer(trap_1_wl(72, number));
end;


function Malloc return int32 is
begin
	return trap_1_wl(72, int32(-1));
end;


function Mfree(block: System.Address) return int16 is
begin
	return int16(trap_1_wl(73, to_address(block)));
end;


function Mshrink(ptr: System.Address; size: int32) return int16 is
begin
	return int16(trap_1_wwll(74, int16(0), to_address(ptr), size));
end;


function Pexec(
            mode: int16;
            ptr1: const_chars_ptr;
            ptr2: System.Address;
            ptr3: System.Address)
           return int32 is
	function to_address2 is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return trap_1_wwlll(75, mode, to_address2(ptr1), to_address(ptr2), to_address(ptr3));
end;


function Pexec(
            mode: int16;
            ptr1: String;
            ptr2: System.Address;
            ptr3: System.Address)
           return int32 is
    c_str: String := ptr1 & ASCII.NUL;
begin
	return trap_1_wwlll(75, mode, to_address(c_str'Address), to_address(ptr2), to_address(ptr3));
end;


procedure Pterm(retcode: int16) is
	dummy: int32;
begin
	dummy := trap_1_ww(76, retcode);
end;


function Fsfirst(filename: const_chars_ptr; attr: uint16) return int16 is
	function to_address2 is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return int16(trap_1_wlw(78, to_address2(filename), int16(attr)));
end;


function Fsfirst(filename: String; attr: uint16) return int16 is
    c_str: String := filename & ASCII.NUL;
begin
	return int16(trap_1_wlw(78, to_address(c_str'Address), int16(attr)));
end;


function Fsnext return int16 is
begin
	return int16(trap_1_w(79));
end;


function Frename(oldname: const_chars_ptr; newname: const_chars_ptr) return int16 is
	function to_address2 is new Ada.Unchecked_Conversion(const_chars_ptr, int32);
begin
	return int16(trap_1_wwll(86, int16(0), to_address2(oldname), to_address2(newname)));
end;


function Frename(oldname: String; newname: String) return int16 is
    c_str: String := oldname & ASCII.NUL;
    c_str2: String := newname & ASCII.NUL;
begin
	return int16(trap_1_wwll(86, int16(0), to_address(c_str'Address), to_address(c_str2'Address)));
end;


function Fdatime(
            timeptr: in out DOSTIME;
            handle : int16;
            rwflag : boolean)
           return int16 is
begin
	return int16(trap_1_wlww(87, to_address(timeptr'Address), handle, boolean'pos(rwflag)));
end;


function Flock(handle: int16; mode: int16; start: int32; length: int32) return int32 is
begin 
	return trap_1_wwwll(92, handle, mode, start, length);
end;


function Nversion return int32 is
begin 
	return trap_1_w(96);
end;



function Frlock(handle: int16; start: int32; count: int32) return int32 is
begin 
	return trap_1_wwll(98, handle, start, count);
end;


function Frunlock(handle: int16; start: int32) return int32 is
begin 
	return trap_1_wwl(99, handle, start);
end;


function F_lock(handle: int16; count: int32) return int32 is
begin 
	return trap_1_wwl(100, handle, count);
end;


function Funlock(handle: int16) return int32 is
begin 
	return trap_1_ww(101, handle);
end;


function Fflush(handle: int16) return int32 is
begin 
	return trap_1_ww(102, handle);
end;
















end Atari.gemdos;
