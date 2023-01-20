with Interfaces.C.Extensions;

package Atari.gemdos is

-- Cconis() return values
    DEV_READY           : constant  := -1;
    DEV_BUSY            : constant  := 0;

-- Super() constants
    SUP_SET             : constant  := 0;
    SUP_INQUIRE         : constant  := 1;
    SUP_USER            : constant  := 0;
    SUP_SUPER           : constant  := -1;

-- Fopen() modes
    S_READ              : constant  := 16#0#;
    S_WRITE             : constant  := 16#1#;
    S_READWRITE         : constant  := 16#2#;
    S_COMPAT            : constant  := 16#0#;
    S_DENYREADWRITE     : constant  := 16#10#;
    S_DENYWRITE         : constant  := 16#20#;
    S_DENYREAD          : constant  := 16#30#;
    S_DENYNONE          : constant  := 16#40#;
    S_INHERIT           : constant  := 16#70#;

    FO_READ             : constant  := S_READ;
    FO_WRITE            : constant  := S_WRITE;
    FO_RW               : constant  := S_READWRITE;

-- Fseek() modes
    SEEK_SET            : constant  := 0;
    SEEK_CUR            : constant  := 1;
    SEEK_END            : constant  := 2;

-- Fattrib() params
    FA_INQUIRE          : constant  := 0;
    FA_SET              : constant  := 1;

-- Modes for Mxalloc()
    MX_STRAM            : constant  := 16#0#;
    MX_TTRAM            : constant  := 16#1#;
    MX_PREFSTRAM        : constant  := 16#2#;
    MX_PREFTTRAM        : constant  := 16#3#;
    MX_MPROT            : constant  := 16#8#;
    MX_HEADER           : constant  := 16#0#;
    MX_PRIVATE          : constant  := 16#10#;
    MX_GLOBAL           : constant  := 16#20#;
    MX_SUPERVISOR       : constant  := 16#30#;
    MX_READABLE         : constant  := 16#40#;
    MX_KEEP             : constant  := 16#8000#;

-- Fforce() params
    GSH_CONIN           : constant  := 0;
    GSH_CONOUT          : constant  := 1;
    GSH_AUX             : constant  := 2;
    GSH_PRN             : constant  := 3;
    GSH_BIOSCON         : constant  := -1;
    GSH_BIOSAUX         : constant  := -2;
    GSH_BIOSPRN         : constant  := -3;
    GSH_MIDIIN          : constant  := -4;
    GSH_MIDIOUT         : constant  := -5;

-- Dgetpath() param
    DEFAULT_DRIVE       : constant  := 0;

-- Pterm() modes
    TERM_OK             : constant  := 0;
    TERM_ERROR          : constant  := 1;
    TERM_BADPARAMS      : constant  := 2;
    TERM_CRASH          : constant  := -1;
    TERM_CTRLC          : constant  := -32;

-- Return value for i.e. Crawcin() 
    MINT_EOF            : constant  := 16#ff1a#;

-- Codes used with Fcreate()/Fsfirst()
    FA_RDONLY           : constant  := 16#1#;
    FA_HIDDEN           : constant  := 16#2#;
    FA_SYSTEM           : constant  := 16#4#;
    FA_LABEL            : constant  := 16#8#;
    FA_DIR              : constant  := 16#10#;
    FA_CHANGED          : constant  := 16#20#;
    FA_SYMLINK          : constant  := 16#40#;                  -- MagiC 3.0 
-- alternative names:
	FA_READONLY         : constant  := FA_RDONLY;
	FA_VOLUME           : constant  := FA_LABEL;
	FA_SUBDIR           : constant  := FA_DIR;
	FA_ARCHIVE          : constant  := FA_CHANGED;

-- Codes used with Pexec
    PE_LOADGO           : constant  := 0;                       -- load & go 
    PE_LOAD             : constant  := 3;                       -- just load 
    PE_GO               : constant  := 4;                       -- just go 
    PE_CBASEPAGE        : constant  := 5;                       -- just create basepage 
    PE_GO_FREE          : constant  := 6;                       -- just go, then free 
    PE_CBASEPAGE_FLAGS  : constant  := 7;
    PE_ASYNC_LOADGO     : constant  := 100;                     -- load and asynchronously go 
    PE_INIT             : constant  := 101;
    PE_TERM             : constant  := 102;
    PE_ASYNC_GO         : constant  := 104;                     -- asynchronously go	     
    PE_ASYNC_GO_FREE    : constant  := 106;                     -- asynchronously go and free 
    PE_XBASE            : constant  := 107;
    PE_EXACC            : constant  := 108;
    PE_OVERLAY          : constant  := 200;                     -- load and overlay	     
    PE_OVERLAY_GO       : constant  := 204;
    PE_OVERLAY_GO_FREE  : constant  := 206;
	PE_TRACE            : constant  := 16#8000#;    


-- Sconfig - Modes
    SC_GETCONF          : constant  := 0;
    SC_SETCONF          : constant  := 1;
    SC_DOSVARS          : constant  := 2;
    SC_MOWNER           : constant  := 3;
    SC_WBACK            : constant  := 4;
    SC_INTMAVAIL        : constant  := 5;
    SC_INTGARBC         : constant  := 6;

     SCWB_GET	        : constant  := 0;
     SCWB_SET           : constant  := 1;
     SCWB_RESET         : constant  := 2;

-- Sconfig Bits

    SCB_PTHCK          : constant  := 16#001#;
    SCB_DSKCH          : constant  := 16#002#;
    SCB_BREAK          : constant  := 16#004#;
    SCB_NCTLC          : constant  := 16#008#;
    SCB_NFAST          : constant  := 16#010#;
    SCB_CMPTB          : constant  := 16#020#;
    SCB_NSMRT          : constant  := 16#040#;
    SCB_NGRSH          : constant  := 16#080#;
    SCB_NHALT          : constant  := 16#100#;
    SCB_RESVD          : constant  := 16#200#;
    SCB_PULLM          : constant  := 16#400#;
    SCB_FLPAR          : constant  := 16#800#;



    type DISKINFO is
        record
            b_free  : aliased uint32;
            b_total : aliased uint32;
            b_secsiz: aliased uint32;
            b_clsiz : aliased uint32;
        end record;


    type DOSTIME is
        record
            time: aliased uint16;
            date: aliased uint16;
        end record;


    type CCONLINE is
        record
            maxlen   : aliased uint8;
            actuallen: aliased uint8;
            buffer   : aliased char_array(0..254);
        end record;

    type DTA is
        record
            dta_buf      : aliased char_array(0..20);
            dta_attribute: aliased uint8;
            dta_time     : aliased uint16;
            dta_date     : aliased uint16;
            dta_size     : aliased int32;
            dta_name     : aliased char_array(0..13);
        end record;

    type DATETIME is
        record
            hour  : Interfaces.C.Extensions.Unsigned_5;
            minute: Interfaces.C.Extensions.Unsigned_6;
            second: Interfaces.C.Extensions.Unsigned_5;
            year  : Interfaces.C.Extensions.Unsigned_7;
            month : Interfaces.C.Extensions.Unsigned_4;
            day   : Interfaces.C.Extensions.Unsigned_5;
        end record;

    type BASEPAGE;
    type BASEPAGE_ptr is access all BASEPAGE;
    type BASEPAGE is
        record
            p_lowtpa  : aliased System.Address;
            p_hitpa   : aliased System.Address;
            p_tbase   : aliased System.Address;
            p_tlen    : aliased int32;
            p_dbase   : aliased System.Address;
            p_dlen    : aliased int32;
            p_bbase   : aliased System.Address;
            p_blen    : aliased int32;
            p_dta     : aliased System.Address;
            p_parent  : aliased BASEPAGE_ptr;
            p_reserved: aliased int32;
            p_env     : aliased System.Address;
            p_junk    : aliased char_array(0..7);
            p_undef   : aliased long_array(0..17);
            p_cmdlin  : aliased char_array(0..127);
        end record;

    type PRGHDR is
        record
            p_magic    : aliased uint16;
            p_tlen     : aliased uint32;
            p_dlen     : aliased uint32;
            p_blen     : aliased uint32;
            p_slen     : aliased uint32;
            p_reserved1: aliased uint32;
            p_reserved2: aliased uint32;
            p_reserved3: aliased uint16;
        end record;

    base: aliased BASEPAGE_ptr;

    procedure Pterm0
      with Inline;

private

    pragma Import(C, base, "_base");

end Atari.gemdos;
