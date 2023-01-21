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
        end record
       with Convention => C;

    type DOSTIME is
        record
            time: aliased uint16;
            date: aliased uint16;
        end record
       with Convention => C;

    type CCONLINE is
        record
            maxlen   : aliased uint8;
            actuallen: aliased uint8;
            buffer   : aliased char_array(0..254);
        end record
       with Convention => C;

    type DTA is
        record
            dta_buf      : aliased char_array(0..20);
            dta_attribute: aliased uint8;
            dta_time     : aliased uint16;
            dta_date     : aliased uint16;
            dta_size     : aliased int32;
            dta_name     : aliased char_array(0..13);
        end record
       with Convention => C;
    type DTA_ptr is access all DTA;

    type DATETIME is
        record
            hour  : Interfaces.C.Extensions.Unsigned_5;
            minute: Interfaces.C.Extensions.Unsigned_6;
            second: Interfaces.C.Extensions.Unsigned_5;
            year  : Interfaces.C.Extensions.Unsigned_7;
            month : Interfaces.C.Extensions.Unsigned_4;
            day   : Interfaces.C.Extensions.Unsigned_5;
        end record
       with Convention => C;

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
        end record
       with Convention => C;

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
        end record
       with Convention => C;

    base: aliased BASEPAGE_ptr;

    procedure Pterm0
      with Inline;

    function Cconin return int32
      with Inline;

    procedure Cconout(c: int16)
      with Inline;

    function Cauxin return int16
      with Inline;

    procedure Cauxout(c: int16)
      with Inline;

    function Cprnout(c: int16) return int16
      with Inline;

    function Crawio(c: int16) return int32
      with Inline;

    function Crawcin return int32
      with Inline;

    function Cnecin return int32
      with Inline;

    function Cconws(buf: const_chars_ptr) return int32
      with Inline;

    function Cconws(buf: String) return int32
      with Inline;

    procedure Cconws(buf: String)
      with Inline;

    function Cconrs(buf: out CCONLINE) return int32
      with Inline;

    function Cconis return boolean
      with Inline;

    function Dsetdrv(drv: int16) return int32
      with Inline;

    function Cconos return boolean
      with Inline;

    function Cprnos return boolean
      with Inline;

    function Cauxis return boolean
      with Inline;

    function Cauxos return boolean
      with Inline;

    function Maddalt(start: System.Address; size: int32) return int32
      with Inline;

    function Srealloc(len: int32) return int32
      with Inline;

    type SLB_EXEC is new System.Address;

    type struct_slb_handle is null record;
    type SLB_HANDLE is access all struct_slb_handle;
    type SHARED_LIB is access all struct_slb_handle;

    type SLB is
        record
            handle: aliased SLB_HANDLE;
            exec  : aliased SLB_EXEC;
        end record;

    function Slbopen(
                fname: const_chars_ptr;
                path : const_chars_ptr;
                ver  : int32;
                hnd  : out SLB_HANDLE;
                exec : out SLB_EXEC)
               return int32
      with Inline;

    function Slbopen(
                fname: const_chars_ptr;
                path : const_chars_ptr;
                ver  : int32;
                shlb : out SLB)
               return int32
      with Inline;

    function Slbclose(hnd: SLB_HANDLE) return int32
      with Inline;

    function Dgetdrv return int16
      with Inline;

    procedure Fsetdta(buf: DTA_ptr)
      with Inline;

	function Super(stack: System.Address) return System.Address
      with Inline;

	procedure SuperToUser(stack: System.Address)
      with Inline;

    function Tgetdate return uint16
      with Inline;

    procedure Tsetdate(date: uint16)
      with Inline;

    function Tgettime return uint16
      with Inline;

    procedure Tsettime(time: uint16)
      with Inline;

    function Fgetdta return DTA_ptr
      with Inline;

    function Sversion return uint16
      with Inline;

    procedure Ptermres(keepcnt: int32; retcode: int16)
      with Inline;

	function Sconfig(mode: int16; flags: int32) return int32
      with Inline;

    function Dfree(buf: out DISKINFO; driveno: int16) return int16
      with Inline;

    function Dcreate(path: const_chars_ptr) return int16
      with Inline;

    function Dcreate(path: String) return int16
      with Inline;

    function Ddelete(path: const_chars_ptr) return int16
      with Inline;

    function Ddelete(path: String) return int16
      with Inline;

    function Dsetpath(path: const_chars_ptr) return int16
      with Inline;

    function Dsetpath(path: String) return int16
      with Inline;

    function Fcreate(filename: const_chars_ptr; attr: uint16) return int32
      with Inline;

    function Fcreate(filename: String; attr: uint16) return int32
      with Inline;

    function Fopen(filename: const_chars_ptr; mode: int16) return int32
      with Inline;

    function Fopen(filename: String; mode: int16) return int32
      with Inline;

    function Fclose(handle: int16) return int16
      with Inline;

    function Fread(handle: int16; count: int32; buf: System.Address) return int32
      with Inline;

    function Fwrite(handle: int16; count: int32; buf: System.Address) return int32
      with Inline;

    function Fdelete(filename: const_chars_ptr) return int16
      with Inline;

    function Fdelete(filename: String) return int16
      with Inline;

    function Fseek(offset: int32; handle: int16; seekmode: int16) return int32
      with Inline;

    function Fattrib(filename: const_chars_ptr; wflag: boolean; attrib: uint16) return int16
      with Inline;

    function Fattrib(filename: String; wflag: boolean; attrib: uint16) return int16
      with Inline;

    function Mxalloc(number: int32; mode: int16) return System.Address
      with Inline;

	-- Mxalloc(-1, mode)
    function Mxalloc(mode: int16) return int32
      with Inline;

    function Fdup(handle: int16) return int32
      with Inline;

    function Fforce(stdh: int16; nonstdh: int16) return int32
      with Inline;

    function Dgetpath(path: chars_ptr; driveno: int16) return int16
      with Inline;

    function Dgetpath(path: out String; driveno: int16) return int16
      with Inline;

    function Malloc(number: int32) return System.Address
      with Inline;

	-- Malloc(-1)
    function Malloc return int32
      with Inline;

    function Mfree(block: System.Address) return int16
      with Inline;

    function Mshrink(ptr: System.Address; size: int32) return int16
      with Inline;

    function Pexec(
                mode: int16;
                ptr1: const_chars_ptr;
                ptr2: System.Address;
                ptr3: System.Address)
               return int32
      with Inline;

    function Pexec(
                mode: int16;
                ptr1: String;
                ptr2: System.Address;
                ptr3: System.Address)
               return int32
      with Inline;

    procedure Pterm(retcode: int16)
      with Inline;

    function Fsfirst(filename: const_chars_ptr; attr: uint16) return int16
      with Inline;

    function Fsfirst(filename: String; attr: uint16) return int16
      with Inline;

    function Fsnext return int16
      with Inline;

    function Frename(oldname: const_chars_ptr; newname: const_chars_ptr) return int16
      with Inline;

    function Frename(oldname: String; newname: String) return int16
      with Inline;

    function Fdatime(
                timeptr: in out DOSTIME;
                handle : int16;
                rwflag : boolean)
               return int16
      with Inline;

    function Flock(handle: int16; mode: int16; start: int32; length: int32) return int32
      with Inline;

    function Nversion return int32
      with Inline;

    function Frlock(handle: int16; start: int32; count: int32) return int32
      with Inline;

    function Frunlock(handle: int16; start: int32) return int32
      with Inline;

    function F_lock(handle: int16; count: int32) return int32
      with Inline;

    function Funlock(handle: int16) return int32
      with Inline;

    function Fflush(handle: int16) return int32
      with Inline;

    -- function Nenable return int16;

    -- procedure Ndisable;

    -- function Nremote(nn: int16) return int16;

    -- function Nmsg(rw: int16; buf: chars_ptr; id: chars_ptr; node: int16; leng: int16) return int16;

    -- function Nrecord( handle: int16; mm: int16; offset: int32; leng: int32) return int16;

    -- procedure Nreset;

    -- function Nprinter(nn: int16; kopf: int16; dd: int16) return int32;

    -- function Nlocked return int32;

    -- function Nunlock(path: const_chars_ptr) return int32;

    -- function Nlock(file: const_chars_ptr) return int32;

    -- function Nlogged(nn: int16) return int16;

    -- function Nnodeid return int16;

    -- function Nactive return int16;


private

    pragma Import(C, base, "_base");

end Atari.gemdos;
