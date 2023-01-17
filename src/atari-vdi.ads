with System;

package Atari.Vdi is
    --
    -- VDI
    --
    subtype VdiHdl is int16;


    MD_REPLACE           : constant  := 1;                      -- *< TODO 
    MD_TRANS             : constant  := 2;                      -- *< TODO 
    MD_XOR               : constant  := 3;                      -- *< TODO 
    MD_ERASE             : constant  := 4;                      -- *< TODO 

    ALL_WHITE            : constant  := 0;                      -- *< TODO 
    S_AND_D              : constant  := 1;                      -- *< TODO 
    S_AND_NOTD           : constant  := 2;                      -- *< TODO 
    S_ONLY               : constant  := 3;                      -- *< TODO 
    NOTS_AND_D           : constant  := 4;                      -- *< TODO 
    D_ONLY               : constant  := 5;                      -- *< TODO 
    S_XOR_D              : constant  := 6;                      -- *< TODO 
    S_OR_D               : constant  := 7;                      -- *< TODO 
    NOT_SORD             : constant  := 8;                      -- *< TODO 
    NOT_SXORD            : constant  := 9;                      -- *< TODO 
    D_INVERT             : constant  := 10;                     -- *< TODO 
    NOT_D                : constant  := 10;                     -- *< TODO 
    S_OR_NOTD            : constant  := 11;                     -- *< TODO 
    NOT_S                : constant  := 12;                     -- *< TODO 
    NOTS_OR_D            : constant  := 13;                     -- *< TODO 
    NOT_SANDD            : constant  := 14;                     -- *< TODO 
    ALL_BLACK            : constant  := 15;                     -- *< TODO 
    BEZ_BEZIER           : constant  := 16#1#;                  -- *< TODO 
    BEZ_POLYLINE         : constant  := 16#0#;                  -- *< TODO 
    BEZ_NODRAW           : constant  := 16#2#;                  -- *< TODO 
    IMAGE_LEFT           : constant  := 0;                      -- *< TODO 
    IMAGE_CENTER         : constant  := 1;                      -- *< TODO 
    IMAGE_RIGHT          : constant  := 2;                      -- *< TODO 
    IMAGE_TOP            : constant  := 0;                      -- *< TODO 
    IMAGE_BOTTOM         : constant  := 2;                      -- *< TODO 
    NOJUSTIFY            : constant  := 0;                      -- *< TODO 
    JUSTIFY              : constant  := 1;                      -- *< TODO 
    COLOR_REQUESTED      : constant  := 0;                      -- *< TODO 
    COLOR_ACTUAL         : constant  := 1;                      -- *< TODO 
    GDOS_NONE            : constant  := -2;                     -- no GDOS installed *< TODO 
    GDOS_FSM             : constant  := 16#5f46534d#;           -- '_FSM' *< TODO 
    GDOS_FNT             : constant  := 16#5f464e54#;           -- '_FNT' *< TODO 
    VINMODE_LOCATOR      : constant  := 1;                      -- *< TODO 
    VINMODE_VALUATOR     : constant  := 2;                      -- *< TODO 
    VINMODE_CHOICE       : constant  := 3;                      -- *< TODO 
    VINMODE_STRING       : constant  := 4;                      -- *< TODO 
    CACHE_CHAR           : constant  := 0;                      -- *< TODO 
    CACHE_MISC           : constant  := 1;                      -- *< TODO 
    DEV_MISSING          : constant  := 0;                      -- *< TODO 
    DEV_INSTALLED        : constant  := 1;                      -- *< TODO 
    BITMAP_FONT          : constant  := 0;                      -- *< TODO 
    FIS_HOLLOW           : constant  := 0;                      -- *< TODO 
    FIS_SOLID            : constant  := 1;                      -- *< TODO 
    FIS_PATTERN          : constant  := 2;                      -- *< TODO 
    FIS_HATCH            : constant  := 3;                      -- *< TODO 
    FIS_USER             : constant  := 4;                      -- *< TODO 
    PERIMETER_OFF        : constant  := 0;                      -- *< TODO 
    PERIMETER_ON         : constant  := 1;                      -- *< TODO 
    SQUARE               : constant  := 0;                      -- *< TODO 
    ARROWED              : constant  := 1;                      -- *< TODO 
    ROUND                : constant  := 2;                      -- *< TODO 
    LE_SQUARED           : constant  := 0;                      -- *< TODO 
    LE_ARROWED           : constant  := 1;                      -- *< TODO 
    LE_ROUNDED           : constant  := 2;                      -- *< TODO 
    SOLID                : constant  := 1;                      -- *< TODO 
    LDASHED              : constant  := 2;                      -- *< TODO 
    DOTTED               : constant  := 3;                      -- *< TODO 
    DASHDOT              : constant  := 4;                      -- *< TODO 
    DASH                 : constant  := 5;                      -- *< TODO 
    DASHDOTDOT           : constant  := 6;                      -- *< TODO 
    USERLINE             : constant  := 7;                      -- *< TODO 
    LT_SOLID             : constant  := 1;                      -- *< TODO 
    LT_LONGDASH          : constant  := 2;                      -- *< TODO 
    LT_DOTTED            : constant  := 3;                      -- *< TODO 
    LT_DASHDOT           : constant  := 4;                      -- *< TODO 
    LT_DASHED            : constant  := 5;                      -- *< TODO 
    LT_DASHDOTDOT        : constant  := 6;                      -- *< TODO 
    LT_USERDEF           : constant  := 7;                      -- *< TODO 
    LONGDASH             : constant  := 2;                      -- *< TODO 
    DOT                  : constant  := 3;                      -- *< TODO 
    DASH2DOT             : constant  := 6;                      -- *< TODO 
    MRKR_DOT             : constant  := 1;                      -- *< TODO 
    MRKR_PLUS            : constant  := 2;                      -- *< TODO 
    MRKR_ASTERISK        : constant  := 3;                      -- *< TODO 
    MRKR_BOX             : constant  := 4;                      -- *< TODO 
    MRKR_CROSS           : constant  := 5;                      -- *< TODO 
    MRKR_DIAMOND         : constant  := 6;                      -- *< TODO 
    MT_DOT               : constant  := 1;                      -- *< TODO 
    MT_PLUS              : constant  := 2;                      -- *< TODO 
    MT_ASTERISK          : constant  := 3;                      -- *< TODO 
    MT_SQUARE            : constant  := 4;                      -- *< TODO 
    MT_DCROSS            : constant  := 5;                      -- *< TODO 
    MT_DIAMOND           : constant  := 6;                      -- *< TODO 
    TA_LEFT              : constant  := 0;                      -- horizontal *< TODO 
    TA_CENTER            : constant  := 1;                      -- *< TODO 
    TA_RIGHT             : constant  := 2;                      -- *< TODO 
    TA_BASE              : constant  := 0;                      -- vertical *< TODO 
    TA_HALF              : constant  := 1;                      -- *< TODO 
    TA_ASCENT            : constant  := 2;                      -- *< TODO 
    TA_BOTTOM            : constant  := 3;                      -- *< TODO 
    TA_DESCENT           : constant  := 4;                      -- *< TODO 
    TA_TOP               : constant  := 5;                      -- *< TODO 
    MAP_BITSTREAM        : constant  := 0;                      -- *< TODO 
    MAP_ATARI            : constant  := 1;                      -- *< TODO 
    MAP_UNICODE          : constant  := 2;                      -- for vst_map_mode, NVDI 4 *< TODO 
    TXT_NORMAL           : constant  := 16#0#;                  -- *< TODO 
    TXT_THICKENED        : constant  := 16#1#;                  -- *< TODO 
    TXT_LIGHT            : constant  := 16#2#;                  -- *< TODO 
    TXT_SKEWED           : constant  := 16#4#;                  -- *< TODO 
    TXT_UNDERLINED       : constant  := 16#8#;                  -- *< TODO 
    TXT_OUTLINED         : constant  := 16#10#;                 -- *< TODO 
    TXT_SHADOWED         : constant  := 16#20#;                 -- *< TODO 
    TF_NORMAL            : constant  := 16#0#;                  -- *< TODO 
    TF_THICKENED         : constant  := 16#1#;                  -- *< TODO 
    TF_LIGHTENED         : constant  := 16#2#;                  -- *< TODO 
    TF_SLANTED           : constant  := 16#4#;                  -- *< TODO 
    TF_UNDERLINED        : constant  := 16#8#;                  -- *< TODO 
    TF_OUTLINED          : constant  := 16#10#;                 -- *< TODO 
    TF_SHADOWED          : constant  := 16#20#;                 -- *< TODO 
    APP_ERROR            : constant  := 0;                      -- *< TODO 
    SCREEN_ERROR         : constant  := 1;                      -- *< TODO 
    NO_ERROR             : constant  := 0;                      -- *< TODO 
    CHAR_NOT_FOUND       : constant  := 1;                      -- *< TODO 
    FILE_READERR         : constant  := 8;                      -- *< TODO 
    FILE_OPENERR         : constant  := 9;                      -- *< TODO 
    BAD_FORMAT           : constant  := 10;                     -- *< TODO 
    CACHE_FULL           : constant  := 11;                     -- *< TODO 
    MISC_ERROR           : constant  := -1;                     -- *< TODO 
    TRACK_NONE           : constant  := 0;                      -- *< TODO 
    TRACK_NORMAL         : constant  := 1;                      -- *< TODO 
    TRACK_TIGHT          : constant  := 2;                      -- *< TODO 
    TRACK_VERYTIGHT      : constant  := 3;                      -- *< TODO 
    PAIR_OFF             : constant  := 0;                      -- *< TODO 
    PAIR_ON              : constant  := 1;                      -- *< TODO 
    SCRATCH_BOTH         : constant  := 0;                      -- *< TODO 
    SCRATCH_BITMAP       : constant  := 1;                      -- *< TODO 
    SCRATCH_NONE         : constant  := 2;                      -- *< TODO 
    SLM_OK               : constant  := 0;                      -- no error 
    SLM_ERROR            : constant  := 2;                      -- general printer error 
    SLM_NOTONER          : constant  := 3;                      -- toner empty 
    SLM_NOPAPER          : constant  := 5;                      -- paper empty 


    type RGB1000 is
        record
            red  : aliased int16;
            green: aliased int16;
            blue : aliased int16;
        end record;

    type PXY is
        record
            p_x: aliased int16;
            p_y: aliased int16;
        end record;
    type PXY_array is array(Integer range <>) of PXY;

    type MFDB is
        record
            fd_addr   : aliased System.Address;
            fd_w      : aliased int16;
            fd_h      : aliased int16;
            fd_wdwidth: aliased int16;
            fd_stand  : aliased int16;
            fd_nplanes: aliased int16;
            fd_r1     : aliased int16;
            fd_r2     : aliased int16;
            fd_r3     : aliased int16;
        end record;

    type VDIContrl is record
        opcode: int16;          -- [0]
        num_ptsin: int16;       -- [1]
        num_ptsout: int16;      -- [2]
        num_intin: int16;       -- [3]
        num_intout: int16;      -- [4]
        subcode: int16;         -- [5]
        handle: int16;          -- [6]
        ptr1: System.Address;   -- [7/8]
        ptr2: System.Address;   -- [9/10]
    end record;

    subtype VDIIntIn is short_array(0..1023);
    subtype VDIPtsIn is short_array(0..1023);
    subtype VDIIntOut is short_array(0..511);
    subtype VDIPtsOut is short_array(0..255);
	type VDIIntIn_ptr is access all VDIIntIn;
	type VDIPtsIn_ptr is access all VDIPtsIn;
	type VDIIntOut_ptr is access all VDIIntOut;
	type VDIPtsOut_ptr is access all VDIPtsOut;

    type VDIPB is
        record
            control: access VDIContrl;
            intin  : access constant VDIIntIn;
            ptsin  : access constant VDIPtsIn;
            intout : access VDIIntOut;
            ptsout : access VDIPtsOut;
        end record;
    type VDIPB_ptr is access all VDIPB;

	subtype vdi_workin_array is short_array(0..10);
	type vdi_workin_array_ptr is not null access all vdi_workin_array;
	subtype vdi_workout_array is short_array(0..56);
	type vdi_workout_array_ptr is not null access all vdi_workout_array;
	
    procedure vdi(pb: VDIPB_ptr);

    procedure v_circle(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                radius: int16);

    procedure v_ellipse(
                handle: VdiHdl;
                x   : int16;
                y   : int16;
                xradius: int16;
                yradius: int16);

    function vsf_interior(
                handle : VdiHdl;
                style: int16)
               return int16;

    function vsf_style(
                handle : VdiHdl;
                style: int16)
               return int16;

	function vsf_color(
	            handle   : VdiHdl;
	            color_idx: int16)
	           return int16;

    function vswr_mode(
                handle: VdiHdl;
                mode: int16)
               return int16;

    procedure v_opnvwk(
                work_in : vdi_workin_array_ptr;
                handle  : short_ptr;
                work_out: vdi_workout_array_ptr);

    procedure v_clsvwk(handle: VdiHdl);

    function vsf_perimeter(
                handle: VdiHdl;
                vis: int16)
               return int16;

    function vsf_perimeter(
                handle : VdiHdl;
                vis  : int16;
                style: int16)
               return int16;

    procedure vr_recfl(
                handle : VdiHdl;
                pxy    : short_array);

    procedure vs_clip(
                handle   : VdiHdl;
                clip_flag: int16;
                pxy      : short_array);

    procedure vs_clip(
                handle   : VdiHdl;
                clip_flag: int16;
                pxy      : PXY_array);

end Atari.Vdi;
