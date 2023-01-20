with Interfaces.C;
with Interfaces.C.Extensions;

Package Atari.Xbios is

-- Codes used with Cursconf()
    CURS_HIDE             : constant  := 0;
    CURS_SHOW             : constant  := 1;
    CURS_BLINK            : constant  := 2;
    CURS_NOBLINK          : constant  := 3;
    CURS_SETRATE          : constant  := 4;
    CURS_GETRATE          : constant  := 5;

-- Modes for Initmous()
    IM_DISABLE            : constant  := 0;
    IM_RELATIVE           : constant  := 1;
    IM_ABSOLUTE           : constant  := 2;
    IM_KEYCODE            : constant  := 4;
    IM_YBOT               : constant  := 0;
    IM_YTOP               : constant  := 1;
    IM_PACKETS            : constant  := 2;
    IM_KEYS               : constant  := 3;

-- VsetScreen() modes
    SCR_NOCHANGE          : constant  := -1;
    SCR_MODECODE          : constant  := 3;
    COL_INQUIRE           : constant  := -1;

-- Floprd() devices
    FLOP_DRIVEA           : constant  := 0;
    FLOP_DRIVEB           : constant  := 1;

-- Flopfmt() params
    FLOP_NOSKEW           : constant  := 1;
    FLOP_SKEW             : constant  := -1;
    FLOP_MAGIC            : constant  := 16#8754321#;
    FLOP_VIRGIN           : constant  := 16#e5e5#;
    FLOPPY_DSDD           : constant  := 0;
    FLOPPY_DSHD           : constant  := 1;
    FLOPPY_DSED           : constant  := 2;

-- Dbmsg() messages 
    DB_NULLSTRING         : constant  := 16#f000#;
    DB_COMMAND            : constant  := 16#f100#;

-- Mfpint() vector indices
    MFP_PARALLEL          : constant  := 0;
    MFP_DCD               : constant  := 1;
    MFP_CTS               : constant  := 2;
    MFP_BITBLT            : constant  := 3;
    MFP_TIMERD            : constant  := 4;
    MFP_BAUDRATE          : constant  := MFP_TIMERD;
    MFP_200HZ             : constant  := 5;
    MFP_ACIA              : constant  := 6;
    MFP_DISK              : constant  := 7;
    MFP_TIMERB            : constant  := 8;
    MFP_HBLANK            : constant  := MFP_TIMERB;
    MFP_TERR              : constant  := 9;
    MFP_TBE               : constant  := 10;
    MFP_RERR              : constant  := 11;
    MFP_RBF               : constant  := 12;
    MFP_TIMERA            : constant  := 13;
    MFP_DMASOUND          : constant  := MFP_TIMERA;
    MFP_RING              : constant  := 14;
    MFP_MONODETECT        : constant  := 15;

-- Iorec() devices
    IO_SERIAL             : constant  := 0;
    IO_KEYBOARD           : constant  := 1;
    IO_MIDI               : constant  := 2;

-- Rsconf() speeds
    BAUD_19200            : constant  := 0;
    BAUD_9600             : constant  := 1;
    BAUD_4800             : constant  := 2;
    BAUD_3600             : constant  := 3;
    BAUD_2400             : constant  := 4;
    BAUD_2000             : constant  := 5;
    BAUD_1800             : constant  := 6;
    BAUD_1200             : constant  := 7;
    BAUD_600              : constant  := 8;
    BAUD_300              : constant  := 9;
    BAUD_200              : constant  := 10;
    BAUD_150              : constant  := 11;
    BAUD_134              : constant  := 12;
    BAUD_110              : constant  := 13;
    BAUD_75               : constant  := 14;
    BAUD_50               : constant  := 15;
    BAUD_INQUIRE          : constant  := -2;

-- Rsconf() params
    FLOW_NONE             : constant  := 0;
    FLOW_SOFT             : constant  := 1;
    FLOW_HARD             : constant  := 2;
    FLOW_BOTH             : constant  := 3;

    RS_RECVENABLE         : constant  := 16#1#;
    RS_SYNCSTRIP          : constant  := 16#2#;
    RS_MATCHBUSY          : constant  := 16#4#;
    RS_BRKDETECT          : constant  := 16#8#;
    RS_FRAMEERR           : constant  := 16#10#;
    RS_PARITYERR          : constant  := 16#20#;
    RS_OVERRUNERR         : constant  := 16#40#;
    RS_BUFFUL             : constant  := 16#80#;

    RS_ODDPARITY          : constant  := 16#2#;
    RS_EVENPARITY         : constant  := 16#0#;
    RS_PARITYENABLE       : constant  := 16#4#;

    RS_NOSTOP             : constant  := 16#0#;
    RS_1STOP              : constant  := 16#8#;
    RS_15STOP             : constant  := 16#10#;
    RS_2STOP              : constant  := 16#18#;

    RS_8BITS              : constant  := 16#0#;
    RS_7BITS              : constant  := 16#20#;
    RS_6BITS              : constant  := 16#40#;
    RS_5BITS              : constant  := 16#60#;

    RS_CLK16              : constant  := 16#80#;

    RS_INQUIRE            : constant  := -1;
    RS_LASTBAUD           : constant  := 2;

-- Keytbl() param
    -- KT_NOCHANGE           : constant const_chars_ptr := -1;

-- Protobt() params 
    SERIAL_NOCHANGE       : constant  := -1;
    SERIAL_RANDOM         : constant  := 16#1000001#;

    DISK_NOCHANGE         : constant  := -1;
    DISK_SSSD             : constant  := 0;
    DISK_DSSD             : constant  := 1;
    DISK_SSDD             : constant  := 2;
    DISK_DSDD             : constant  := 3;
    DISK_DSHD             : constant  := 4;
    DISK_DSED             : constant  := 5;

    EXEC_NOCHANGE         : constant  := -1;
    EXEC_NO               : constant  := 0;
    EXEC_YES              : constant  := 1;

-- Giaccess() registers
    PSG_APITCHLOW         : constant  := 0;
    PSG_APITCHHIGH        : constant  := 1;
    PSG_BPITCHLOW         : constant  := 2;
    PSG_BPTICHHIGH        : constant  := 3;
    PSG_CPITCHLOW         : constant  := 4;
    PSG_CPITCHHIGH        : constant  := 5;
    PSG_NOISEPITCH        : constant  := 6;
    PSG_MODE              : constant  := 7;
    PSG_AVOLUME           : constant  := 8;
    PSG_BVOLUME           : constant  := 9;
    PSG_CVOLUME           : constant  := 10;
    PSG_FREQLOW           : constant  := 11;
    PSG_FREQHIGH          : constant  := 12;
    PSG_ENVELOPE          : constant  := 13;
    PSG_PORTA             : constant  := 14;
    PSG_PORTB             : constant  := 15;

    PSG_ENABLEA           : constant  := 16#1#;
    PSG_ENABLEB           : constant  := 16#2#;
    PSG_ENABLEC           : constant  := 16#4#;
    PSG_NOISEA            : constant  := 16#8#;
    PSG_NOISEB            : constant  := 16#10#;
    PSG_NOISEC            : constant  := 16#20#;
    PSG_PRTAOUT           : constant  := 16#40#;
    PSG_PRTBOUT           : constant  := 16#80#;

-- Bitmasks for Offgibit()
    GI_FLOPPYSIDE         : constant  := 16#1#;
    GI_FLOPPYA            : constant  := 16#2#;
    GI_FLOPPYB            : constant  := 16#4#;
    GI_RTS                : constant  := 16#8#;
    GI_DTR                : constant  := 16#10#;
    GI_STROBE             : constant  := 16#20#;
    GI_GPO                : constant  := 16#40#;
    GI_SCCPORT            : constant  := 16#80#;

-- Xbtimer() values
    XB_TIMERA             : constant  := 0;
    XB_TIMERB             : constant  := 1;
    XB_TIMERC             : constant  := 2;
    XB_TIMERD             : constant  := 3;

-- Dosound() param
    DS_INQUIRE            : constant  := -1;

-- Setprt() modes
    PRT_DOTMATRIX         : constant  := 16#1#;
    PRT_MONO              : constant  := 16#2#;
    PRT_ATARI             : constant  := 16#4#;
    PRT_DRAFT             : constant  := 16#8#;
    PRT_PARALLEL          : constant  := 16#10#;
    PRT_CONTINUOUS        : constant  := 16#20#;

    PRT_DAISY             : constant  := 16#1#;
    PRT_COLOR             : constant  := 16#2#;
    PRT_EPSON             : constant  := 16#4#;
    PRT_FINAL             : constant  := 16#8#;
    PRT_SERIAL            : constant  := 16#10#;
    PRT_SINGLE            : constant  := 16#20#;
    PRT_INQUIRE           : constant  := -1;

-- Kbrate() param
    KB_INQUIRE            : constant  := -1;

-- Floprate() seek rates
    FRATE_6               : constant  := 0;
    FRATE_12              : constant  := 1;
    FRATE_2               : constant  := 2;
    FRATE_3               : constant  := 3;
    FRATE_INQUIRE         : constant  := -1;

-- Bconmap() params
    BMAP_CHECK            : constant  := 0;
    BMAP_INQUIRE          : constant  := -1;
    BMAP_MAPTAB           : constant  := -2;

-- NVMaccess params
    NVM_READ              : constant  := 0;
    NVM_WRITE             : constant  := 1;
    NVM_RESET             : constant  := 2;

-- Blitmode() modes
    BLIT_SOFT             : constant  := 0;
    BLIT_HARD             : constant  := 1;

-- EsetShift() modes
    ST_LOW                : constant  := 16#0#;
    ST_MED                : constant  := 16#100#;
    ST_HIGH               : constant  := 16#200#;
    TT_MED                : constant  := 16#400#;
    TT_HIGH               : constant  := 16#600#;
    TT_LOW                : constant  := 16#700#;

    ES_GRAY               : constant  := 12;
    ES_SMEAR              : constant  := 15;

-- Esetbank() params
    ESB_INQUIRE           : constant  := -1;
    EC_INQUIRE            : constant  := -1;

-- EsetGray() modes
    ESG_INQUIRE           : constant  := -1;
    ESG_COLOR             : constant  := 0;
    ESG_GRAY              : constant  := 1;

-- EsetSmear() modes
    ESM_INQUIRE           : constant  := -1;
    ESM_NORMAL            : constant  := 0;
    ESM_SMEAR             : constant  := 1;



-- Structure used by Initmouse()
    type PARAM is
        record
            topmode: aliased uint8;
            buttons: aliased uint8;
            xparam : aliased uint8;
            yparam : aliased uint8;
            xmax   : aliased int16;
            ymax   : aliased int16;
            xstart : aliased int16;
            ystart : aliased int16;
        end record;


-- Structure used by VgetRGB
    type RGB is
        record
            reserved: aliased uint8;
            red     : aliased uint8;
            green   : aliased uint8;
            blue    : aliased uint8;
        end record;


-- Structure returned by Iorec()
    type IOREC is
        record
            ibuf   : aliased chars_ptr;
            ibufsiz: aliased int16;
            ibufhd : aliased int16;
            ibuftl : aliased int16;
            ibuflow: aliased int16;
            ibufhi : aliased int16;
        end record;
    type IOREC_ptr is access all IOREC;


    type Bconstat_func is access function(p1: int16) return int16;
    pragma Convention(C, Bconstat_func);

    type Bconin_func is access function(p1: int16) return int32;
    pragma Convention(C, Bconin_func);

    type Bcostat_func is access function(p1: int16) return int32;
    pragma Convention(C, Bcostat_func);

    type Bconout_proc is access procedure(p1: int16; p2: int16);
    pragma Convention(C, Bconout_proc);

    type Rsconf_func is access function(
                p1: int16;
                p2: int16;
                p3: int16;
                p4: int16;
                p5: int16;
                p6: int16)
               return uint32;
    pragma Convention(C, Rsconf_func);

-- Structure used by Bconmap()
    type MAPTAB is
        record
            Bconstat: aliased Bconstat_func;
            Bconin  : aliased Bconin_func;
            Bcostat : aliased Bcostat_func;
            Bconout : aliased Bconout_proc;
            Rsconf  : aliased Rsconf_func;
            iorec   : aliased IOREC_ptr;
        end record;
    type MAPTAB_ptr is access all MAPTAB;


-- Structure used by Bconmap()
    type BCONMAP is
        record
            maptab    : aliased MAPTAB_ptr;
            maptabsize: aliased int16;
        end record;


-- Structure used by Settime
    type BIOSTIME is
        record
            year  : Interfaces.C.Extensions.Unsigned_7;
            month : Interfaces.C.Extensions.Unsigned_4;
            day   : Interfaces.C.Extensions.Unsigned_5;
            hour  : Interfaces.C.Extensions.Unsigned_5;
            minute: Interfaces.C.Extensions.Unsigned_6;
            second: Interfaces.C.Extensions.Unsigned_5;
        end record;


-- Structure returned by Kbdvbase()
    type midivec_proc is access procedure;
    pragma Convention(C, midivec_proc);

    type vkbderr_proc is access procedure;
    pragma Convention(C, vkbderr_proc);

    type vmiderr_proc is access procedure;
    pragma Convention(C, vmiderr_proc);

    type statvec_proc is access procedure(p1: System.Address);
    pragma Convention(C, statvec_proc);

    type mousevec_proc is access procedure(p1: System.Address);
    pragma Convention(C, mousevec_proc);

    type clockvec_proc is access procedure(p1: System.Address);
    pragma Convention(C, clockvec_proc);

    type joyvec_proc is access procedure(p1: System.Address);
    pragma Convention(C, joyvec_proc);

    type midisys_func is access function return int32;
    pragma Convention(C, midisys_func);

    type ikbdsys_func is access function return int32;
    pragma Convention(C, ikbdsys_func);

    type KBDVECS is
        record
            midivec : aliased midivec_proc;
            vkbderr : aliased vkbderr_proc;
            vmiderr : aliased vmiderr_proc;
            statvec : aliased statvec_proc;
            mousevec: aliased mousevec_proc;
            clockvec: aliased clockvec_proc;
            joyvec  : aliased joyvec_proc;
            midisys : aliased midisys_func;
            ikbdsys : aliased ikbdsys_func;
            kbstate : aliased uint8;
        end record;


-- Structure returned by Keytbl()
    type KEYTAB is
        record
            unshift : aliased uint8_ptr;
            shift   : aliased uint8_ptr;
            caps    : aliased uint8_ptr;
            alt     : aliased uint8_ptr;
            altshift: aliased uint8_ptr;
            altcaps : aliased uint8_ptr;
            altgr   : aliased uint8_ptr;
        end record;


-- Structure used by Prtblk()
    type PBDEF is
        record
            pb_scrptr: aliased System.Address;
            pb_offset: aliased int16;
            pb_width : aliased int16;
            pb_height: aliased int16;
            pb_left  : aliased int16;
            pb_right : aliased int16;
            pb_screz : aliased int16;
            pb_prrez : aliased int16;
            pb_colptr: aliased System.Address;
            pb_prtype: aliased int16;
            pb_prport: aliased int16;
            pb_mask  : aliased System.Address;
        end record;

-- Available from MetaDOS version 2.30
    type META_INFO_2 is
        record
            mi_version : aliased uint16;
            mi_magic   : aliased int32;
            mi_log2phys: aliased const_chars_ptr;
        end record;
    type META_INFO_2_ptr is access all META_INFO_2;

-- Structure used by Metainit()
    type META_INFO_1 is
        record
            drivemap: aliased uint32;
            version : aliased const_chars_ptr;
            reserved: aliased int32;
            info    : aliased META_INFO_2_ptr;
        end record;
    type META_INFO_1_ptr is access all META_INFO_1;
    subtype METAINFO is META_INFO_1;


	function Physbase return System.Address;

end Atari.Xbios;
