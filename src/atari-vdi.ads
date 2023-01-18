with System;

package Atari.Vdi is
    --
    -- VDI
    --
    subtype VdiHdl is int16;


-- gsx modes
    MD_REPLACE           : constant  := 1;                      -- *< TODO 
    MD_TRANS             : constant  := 2;                      -- *< TODO 
    MD_XOR               : constant  := 3;                      -- *< TODO 
    MD_ERASE             : constant  := 4;                      -- *< TODO 

-- bit blt rules
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

-- v_bez modes
    BEZ_BEZIER           : constant  := 16#1#;                  -- *< TODO 
    BEZ_POLYLINE         : constant  := 16#0#;                  -- *< TODO 
    BEZ_NODRAW           : constant  := 16#2#;                  -- *< TODO 

-- v_bit_image modes
    IMAGE_LEFT           : constant  := 0;                      -- *< TODO 
    IMAGE_CENTER         : constant  := 1;                      -- *< TODO 
    IMAGE_RIGHT          : constant  := 2;                      -- *< TODO 
    IMAGE_TOP            : constant  := 0;                      -- *< TODO 
    IMAGE_BOTTOM         : constant  := 2;                      -- *< TODO 

    NOJUSTIFY            : constant  := 0;                      -- *< TODO 
    JUSTIFY              : constant  := 1;                      -- *< TODO 

-- vq_color modes
    COLOR_REQUESTED      : constant  := 0;                      -- *< TODO 
    COLOR_ACTUAL         : constant  := 1;                      -- *< TODO 

-- return values for vq_vgdos() inquiry
    GDOS_NONE            : constant  := -2;                     -- no GDOS installed
    GDOS_FSM             : constant  := 16#5f46534d#;           -- '_FSM'
    GDOS_FNT             : constant  := 16#5f464e54#;           -- '_FNT'
    GDOS_ATARI           : constant  := 16#0007E88A#;           -- GDOS 1.1 von Atari Corp.
    GDOS_AMC             : constant  := 16#0007E864#;           -- AMCGDos von Arnd Beissner
    GDOS_AMCLIGHT        : constant  := 16#0007E8BA#;           -- GEMINI-Spezial-GDos von Arnd Beissner
    GDOS_NVDI            : constant  := 16#00000000#;           -- NVDI von Bela GmbH
    GDOS_TTF             : constant  := 16#3e5d0957#;           -- TTF-GDOS

-- input mode
    MODE_REQUEST         : constant  := 1;
    MODE_SAMPLE          : constant  := 2;

-- vqin_mode & vsin_mode modes
    VINMODE_LOCATOR      : constant  := 1;                      -- *< TODO 
    VINMODE_VALUATOR     : constant  := 2;                      -- *< TODO 
    VINMODE_CHOICE       : constant  := 3;                      -- *< TODO 
    VINMODE_STRING       : constant  := 4;                      -- *< TODO 

    CACHE_CHAR           : constant  := 0;                      -- *< TODO 
    CACHE_MISC           : constant  := 1;                      -- *< TODO 
    DEV_MISSING          : constant  := 0;                      -- *< TODO 
    DEV_INSTALLED        : constant  := 1;                      -- *< TODO 
    BITMAP_FONT          : constant  := 0;                      -- *< TODO 

-- gsx styles
    FIS_HOLLOW           : constant  := 0;                      -- *< TODO 
    FIS_SOLID            : constant  := 1;                      -- *< TODO 
    FIS_PATTERN          : constant  := 2;                      -- *< TODO 
    FIS_HATCH            : constant  := 3;                      -- *< TODO 
    FIS_USER             : constant  := 4;                      -- *< TODO 

    PERIMETER_OFF        : constant  := 0;                      -- *< TODO 
    PERIMETER_ON         : constant  := 1;                      -- *< TODO 

-- line ends
    SQUARE               : constant  := 0;                      -- *< TODO 
    ARROWED              : constant  := 1;                      -- *< TODO 
    ROUND                : constant  := 2;                      -- *< TODO 
    LE_SQUARED           : constant  := 0;                      -- *< TODO 
    LE_ARROWED           : constant  := 1;                      -- *< TODO 
    LE_ROUNDED           : constant  := 2;                      -- *< TODO 

-- linetypes
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

-- polymarker types
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

-- text alignment
    TA_LEFT              : constant  := 0;                      -- horizontal *< TODO 
    TA_CENTER            : constant  := 1;                      -- *< TODO 
    TA_RIGHT             : constant  := 2;                      -- *< TODO 
    TA_BASE              : constant  := 0;                      -- vertical *< TODO 
    TA_HALF              : constant  := 1;                      -- *< TODO 
    TA_ASCENT            : constant  := 2;                      -- *< TODO 
    TA_BOTTOM            : constant  := 3;                      -- *< TODO 
    TA_DESCENT           : constant  := 4;                      -- *< TODO 
    TA_TOP               : constant  := 5;                      -- *< TODO 

-- vst_charmap modes
    MAP_BITSTREAM        : constant  := 0;                      -- *< TODO 
    MAP_ATARI            : constant  := 1;                      -- *< TODO 
    MAP_UNICODE          : constant  := 2;                      -- for vst_map_mode, NVDI 4 *< TODO 

-- text effects
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

-- vst_kern tmodes
    TRACK_NONE           : constant  := 0;                      -- *< TODO 
    TRACK_NORMAL         : constant  := 1;                      -- *< TODO 
    TRACK_TIGHT          : constant  := 2;                      -- *< TODO 
    TRACK_VERYTIGHT      : constant  := 3;                      -- *< TODO 

-- vst_kern pmodes
    PAIR_OFF             : constant  := 0;                      -- *< TODO 
    PAIR_ON              : constant  := 1;                      -- *< TODO 

-- vst_scratch modes
    SCRATCH_BOTH         : constant  := 0;                      -- *< TODO 
    SCRATCH_BITMAP       : constant  := 1;                      -- *< TODO 
    SCRATCH_NONE         : constant  := 2;                      -- *< TODO 

-- definitions for vs_mute
    MUTE_RETURN          : constant  := -1;
    MUTE_ENABLE          : constant  := 0;
    MUTE_DISABLE         : constant  := 1;

-- definitions for v_orient
    OR_PORTRAIT          : constant  := 0;
    OR_LANDSCAPE         : constant  := 1;

-- definitions for v_tray
    TRAY_MANUAL          : constant  := -1;
    TRAY_DEFAULT         : constant  := 0;
    TRAY_FIRSTOPT        : constant  := 1;

-- definitions for v_xbit_image
    XBIT_FRACT           : constant  := 0;
    XBIT_INTEGER         : constant  := 1;

    XBIT_LEFT            : constant  := 0;
    XBIT_CENTER          : constant  := 1;
    XBIT_RIGHT           : constant  := 2;

    XBIT_TOP             : constant  := 0;
    XBIT_MIDDLE          : constant  := 1;
    XBIT_BOTTOM          : constant  := 2;

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

    procedure v_opnwk(
                work_in : short_array;
                handle  : in out VdiHdl;
                work_out: out vdi_workout_array);

    procedure v_clswk(handle: VdiHdl);

    procedure v_clrwk(handle: VdiHdl);

    procedure v_updwk(handle: VdiHdl);

    procedure vq_chcells(
                handle: VdiHdl;
                n_rows: out int16;
                n_cols: out int16);

    procedure v_exit_cur(handle: VdiHdl);

    procedure v_enter_cur(handle: VdiHdl);

	procedure v_curup(handle: VdiHdl);
	
    procedure v_curdown(handle: VdiHdl);

    procedure v_curright(handle: VdiHdl);

    procedure v_curleft(handle: VdiHdl);

    procedure v_curhome(handle: VdiHdl);

    procedure v_eeos(handle: VdiHdl);

    procedure v_eeol(handle: VdiHdl);

    procedure v_curaddress(
                handle: VdiHdl;
                row: int16;
                column: int16);
    procedure vs_curaddress(
                handle: VdiHdl;
                row: int16;
                column: int16)
               renames v_curaddress;

    procedure v_curtext(handle: VdiHdl; str: String);

    procedure v_curtext(handle: VdiHdl; str: String; maxlen: int16);

    procedure v_curtext(handle: VdiHdl; str: Wide_String);

    procedure v_curtext(handle: VdiHdl; str: Wide_String; maxlen: int16);

    procedure v_rvon(handle: VdiHdl);

    procedure v_rvoff(handle: VdiHdl);

    procedure vq_curaddress(handle : VdiHdl;
                cur_row: out int16;
                cur_column: out int16);

    function vq_tabstatus(handle: VdiHdl) return int16;

    procedure v_hardcopy(handle: VdiHdl);

    procedure v_dspcur(handle: VdiHdl; x : int16; y : int16);

    procedure v_rmcur(handle: VdiHdl);

    procedure v_form_adv(handle: VdiHdl);

    procedure v_output_window(handle: VdiHdl; pxy: short_array);

    procedure v_clear_disp_list(handle: VdiHdl);

    procedure v_bit_image(
                handle  : VdiHdl;
                filename: string;
                aspect  : int16;
                x_scale : int16;
                y_scale : int16;
                h_align : int16;
                v_align : int16;
                pxy     : short_array);

    procedure vq_scan(
                handle : VdiHdl;
                g_slice: out int16;
                g_page : out int16;
                a_slice: out int16;
                a_page : out int16;
                div_fac: out int16);

    procedure v_alpha_text(handle: VdiHdl; str: string);

    function v_orient(
                handle     : VdiHdl;
                orientation: int16)
               return int16;

    function v_copies(
                handle : VdiHdl;
                count: int16)
               return int16;

    function v_tray(
                handle    : VdiHdl;
                input     : int16)
               return boolean;

    function v_trays(
                handle    : VdiHdl;
                input     : int16;
                output    : int16;
                set_input : out int16;
                set_output: out int16)
               return boolean;

    function v_page_size(
                handle : VdiHdl;
                page_id: int16)
               return int16;

    function vs_palette(
                handle : VdiHdl;
                palette: int16)
               return int16;

    procedure v_sound(
                handle  : VdiHdl;
                freq    : int16;
                duration: int16);

    function vs_mute(
                handle: VdiHdl;
                action: int16)
               return int16;

    procedure vt_resolution(
                handle: VdiHdl;
                xres: int16;
                yres: int16;
                xset: out int16;
                yset: out int16);

	procedure vt_axis(
	            handle: VdiHdl;
	            xres: int16;
	            yres: int16;
	            xset: out int16;
	            yset: out int16);

    procedure vt_origin(
                handle : VdiHdl;
                xorigin: int16;
                yorigin: int16);

    procedure vq_tdimensions(
                handle    : VdiHdl;
                xdimension: out int16;
                ydimension: out int16);

    procedure vt_alignment(
                handle: VdiHdl;
                dx: int16;
                dy: int16);

	procedure vsp_film(
	            handle   : VdiHdl;
	            color_idx: int16;
	            lightness: int16);

    function vqp_filmname(
                handle : VdiHdl;
                index: int16;
                name : out String)
               return int16;

    procedure vsc_expose(
                handle : VdiHdl;
                state: int16);

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
                work_in : vdi_workin_array;
                handle  : in out int16;
                work_out: out vdi_workout_array);

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

    function vq_vgdos return uint32;

    function vq_gdos return boolean;

end Atari.Vdi;
