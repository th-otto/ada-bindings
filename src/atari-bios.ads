with Atari.Gemdos;

Package Atari.Bios is

-- Device codes for Bconin(), Bconout(), Bcostat(), Bconstat()
    PRT                 : constant  := 0;
    AUX                 : constant  := 1;
    CON                 : constant  := 2;
    MIDI                : constant  := 3;
    IKBD                : constant  := 4;
    RAWCON              : constant  := 5;
    DEV_PRINTER         : constant  := PRT;
    DEV_AUX             : constant  := AUX;
    DEV_CONSOLE         : constant  := CON;
    DEV_MIDI            : constant  := MIDI;
    DEV_IKBD            : constant  := IKBD;
    DEV_RAW             : constant  := RAWCON;

-- Mode bitmask used in Rwabs() 
    RW_READ             : constant  := 0;
    RW_WRITE            : constant  := 0;
    RW_NOMEDIACH        : constant  := 1;
    RW_NORETRIES        : constant  := 2;
    RW_NOTRANSLATE      : constant  := 3;

-- Vector numbers used in Setexc()
    VEC_BUSERROR          : constant  := 16#2#;
    VEC_ADDRESSERROR      : constant  := 16#3#;
    VEC_ILLEGALINSTRUCTION: constant  := 16#4#;
    VEC_GEMDOS            : constant  := 16#21#;
    VEC_GEM               : constant  := 16#22#;
    VEC_BIOS              : constant  := 16#2d#;
    VEC_XBIOS             : constant  := 16#2e#;
    VEC_TIMER             : constant  := 16#100#;
    VEC_CRITICALERROR     : constant  := 16#101#;
    VEC_CRITICALERR       : constant  := VEC_CRITICALERROR;
    VEC_TERMINATE         : constant  := 16#102#;
    VEC_PROCTERM          : constant  := VEC_TERMINATE;
    -- VEC_INQUIRE           : constant System.Address := -1;

-- Values returned by Mediach()
    MED_NOCHANGE          : constant  := 0;
    MED_UNKNOWN           : constant  := 1;
    MED_CHANGED           : constant  := 2;

-- Mode bitmask for Kbshift() (same as in AES)
    K_RSHIFT              : constant  := 16#1#;
    K_LSHIFT              : constant  := 16#2#;
    K_SHIFT               : constant  := K_LSHIFT + K_RSHIFT;
    K_CTRL                : constant  := 16#4#;
    K_ALT                 : constant  := 16#8#;
    K_CAPSLOCK            : constant  := 16#10#;
    K_CLRHOME             : constant  := 16#20#;
    K_INSERT              : constant  := 16#40#;

    type BPB is
        record
            recsiz: aliased uint16;
            clsiz : aliased uint16;
            clsizb: aliased uint16;
            rdlen : aliased uint16;
            fsiz  : aliased uint16;
            fatrec: aliased uint16;
            datrec: aliased uint16;
            numcl : aliased uint16;
            bflags: aliased uint16;
        end record;
    type BPB_ptr is access all BPB;

    subtype BASEPAGE_ptr is Atari.Gemdos.BASEPAGE_ptr;

    type MD;
    type MD_ptr is access all MD;
    type MD is
        record
            md_next  : aliased MD_ptr;
            md_start : aliased int32;
            md_length: aliased int32;
            md_owner : aliased BASEPAGE_ptr;
        end record;

    type MPB is
        record
            mp_free : aliased MD_ptr;
            mp_used : aliased MD_ptr;
            mp_rover: aliased MD_ptr;
        end record;




    procedure Getmpb(ptr: out MPB)
      with Inline;

    function Bconstat(dev: int16) return int16
      with Inline;

    function Bconin(dev: int16) return int32
      with Inline;

    function Bconout(dev: int16; c: int16) return int32
      with Inline;

    function Rwabs(
                rwflag: int16;
                buf   : System.Address;
                cnt   : int16;
                recnr : int16;
                dev   : int16)
               return int32
      with Inline;

    --  since AHDI 3.1 there is a new call to Rwabs with one more parameter

    function Rwabs(
                rwflag: int16;
                buf   : System.Address;
                cnt   : int16;
                dev   : int16;
                sector: int32)
               return int32
      with Inline;

    function Setexc(
                number : int16;
                exchdlr: void_ptr)
               return void_ptr
      with Inline;

    function Tickcal return int32
      with Inline;

    function Getbpb(dev: int16) return BPB_ptr
      with Inline;

    function Bcostat(dev: int16) return int32
      with Inline;

    function Mediach(dev: int16) return int32
      with Inline;

    function Drvmap return int32
      with Inline;

    function Kbshift(mode: int16) return int32
      with Inline;

    function Getshift return int32
      with Inline;

end Atari.Bios;
