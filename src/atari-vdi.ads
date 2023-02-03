with System;
with Atari.Aes;

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
        ptr3: System.Address;   -- [11/12]
        unused: short_array(13..15);
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
    

	vdi_control: aliased VDIContrl;
	vdi_intin: aliased VDIIntIn;
	vdi_ptsin: aliased VDIPtsIn;
	vdi_intout: aliased VDIIntOut;
	vdi_ptsout: aliased VDIPtsOut;


    procedure vdicall(pb: VDIPB_ptr) with Inline;
	procedure vdi_trap with Inline;


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

    procedure v_curtext(handle: VdiHdl; str: in String);

    procedure v_curtext(handle: VdiHdl; str: in String; maxlen: int16);

    procedure v_curtext(handle: VdiHdl; str: in Wide_String);

    procedure v_curtext(handle: VdiHdl; str: in Wide_String; maxlen: int16);

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
                filename: String;
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

    procedure v_alpha_text(handle: VdiHdl; str: in String);

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

    procedure v_meta_extents(
                handle : VdiHdl;
                min_x: int16;
                min_y: int16;
                max_x: int16;
                max_y: int16);

    procedure v_write_meta(
                handle      : VdiHdl;
                num_intin   : int16;
                a_intin     : in short_array;
                num_ptsin   : int16;
                a_ptsin     : in short_array);

    procedure vm_pagesize(
                handle  : VdiHdl;
                pgwidth : int16;
                pgheight: int16);

    procedure vm_coords(
                handle: VdiHdl;
                llx: int16;
                lly: int16;
                urx: int16;
                ury: int16);

    function v_bez_qual(
                handle: VdiHdl;
                prcnt: int16) return int16;

    procedure vm_filename(
                handle  : VdiHdl;
                filename: in String);

    procedure v_offset(
                handle: VdiHdl;
                offset: int16);

    procedure v_fontinit(
                handle     : VdiHdl;
                font_header: System.Address);

    procedure v_escape2000(
                handle : VdiHdl;
                times: int16);

    procedure v_pline(
                handle: VdiHdl;
                count : int16;
                pxy:    short_array);

    procedure v_bez(
                handle: VdiHdl;
                count : int16;
                pxy:    short_array;
                bezarr: System.Address;
                extent: out short_array;
                totpts: out int16;
                totmoves: out int16);

    procedure v_pmarker(
                handle: VdiHdl;
                count : int16;
                pxy: short_array);

    procedure v_gtext(
                handle: VdiHdl;
                x  : int16;
                y  : int16;
                str: in String);

    procedure v_gtext(
                handle: VdiHdl;
                x  : int16;
                y  : int16;
                str: const_chars_ptr);

    procedure v_gtext(
                handle: VdiHdl;
                x  : int16;
                y  : int16;
                str: in Wide_String);

    procedure v_fillarea(
                handle: VdiHdl;
                count : int16;
                pxy:    short_array);

    procedure v_bez_fill(
                handle: VdiHdl;
                count : int16;
                pxy:    short_array;
                bezarr: System.Address;
                extent: out short_array;
                totpts: out int16;
                totmoves: out int16);

    procedure v_bar(
                handle: VdiHdl;
                pxy:    short_array);

    procedure v_arc(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                radius: int16;
                begang: int16;
                endang: int16);

    procedure v_pieslice(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                radius: int16;
                begang: int16;
                endang: int16);

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

    procedure v_ellarc(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                xradius  : int16;
                yradius  : int16;
                begang: int16;
                endang: int16);

    procedure v_ellpie(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                xradius  : int16;
                yradius  : int16;
                begang: int16;
                endang: int16);

    procedure v_rbox(
                handle: VdiHdl;
                pxy:    short_array);

    procedure v_rfbox(
                handle: VdiHdl;
                pxy:    short_array);

    procedure v_justified(
                handle    : VdiHdl;
                x         : int16;
                y         : int16;
                str       : in String;
                width     : int16;
                word_space: int16;
                char_space: int16);

    procedure v_justified(
                handle    : VdiHdl;
                x         : int16;
                y         : int16;
                str       : in Wide_String;
                width     : int16;
                word_space: int16;
                char_space: int16);

    function v_bez_on(handle: VdiHdl) return int16;
    procedure v_bez_off(handle: VdiHdl);

    procedure vst_height(
                handle: VdiHdl;
                height: int16;
                charw : out int16;
                charh : out int16;
                cellw : out int16;
                cellh : out int16);

    function vst_rotation(
                handle: VdiHdl;
                angle: int16)
               return int16;

    procedure vs_color(
                handle   : VdiHdl;
                color_idx: int16;
                rgb      : in short_array);

    function vsl_type(
                handle : VdiHdl;
                style: int16)
               return int16;

    function vsl_width(
                handle : VdiHdl;
                width: int16)
               return int16;

    function vsl_color(
                handle   : VdiHdl;
                color_idx: int16)
               return int16;

    function vsm_type(
                handle: VdiHdl;
                symbol: int16)
               return int16;

    function vsm_height(
                handle: VdiHdl;
                height: int16)
               return int16;

    function vsm_color(
                handle   : VdiHdl;
                color_idx: int16)
               return int16;

    function vst_font(
                handle: VdiHdl;
                font: int16)
               return int16;

    function vst_color(
                handle   : VdiHdl;
                color_idx: int16)
               return int16;

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

    function vq_color(
                handle   : VdiHdl;
                color_idx: int16;
                flag     : int16;
                rgb      : out short_array)
               return int16;

    procedure vrq_locator(
                handle: VdiHdl;
                x   : int16;
                y   : int16;
                xout: out int16;
                yout: out int16;
                term: out int16);

    function vsm_locator(
                handle: VdiHdl;
                x   : int16;
                y   : int16;
                xout: out int16;
                yout: out int16;
                term: out int16)
               return int16;

    procedure vrq_valuator(
                handle : VdiHdl;
                c_in : int16;
                c_out: out int16;
                term : out int16);

    procedure vsm_valuator(
                handle: VdiHdl;
                c_in  : int16;
                c_out : out int16;
                term  : out int16;
                status: out int16);

    procedure vrq_choice(
                handle: VdiHdl;
                ch_in : int16;
                ch_out: out int16);

    function vsm_choice(
                handle: VdiHdl;
                choice: out int16)
               return int16;

    procedure vrq_string(
                handle: VdiHdl;
                len   : int16;
                echo  : int16;
                echoxy: in short_array;
                str   : out String);

    function vsm_string(
                handle   : VdiHdl;
                len      : int16;
                echo     : int16;
                echoxy   : in short_array;
                str      : out String)
               return int16;

    function vswr_mode(
                handle: VdiHdl;
                mode: int16)
               return int16;

    function vsin_mode(
                handle: VdiHdl;
                dev_type: int16;
                mode: int16)
               return int16;

    procedure vql_attributes(
                handle  : VdiHdl;
                attrib  :  out short_array);

    procedure vqm_attributes(
                handle  : VdiHdl;
                attrib  : out short_array);

    procedure vqf_attributes(
                handle : VdiHdl;
                attrib : out short_array);

    procedure vqt_attributes(
                handle  : VdiHdl;
                attrib  : out short_array);

    procedure vst_alignment(
                handle: VdiHdl;
                hin : int16;
                vin : int16;
                hout: out int16;
                vout: out int16);

    procedure v_opnvwk(
                work_in : vdi_workin_array;
                handle  : in out VdiHdl;
                work_out: out vdi_workout_array);

    procedure v_opnbm(
                work_in : in short_array;
                bitmap  : in out MFDB;
                handle  : in out VdiHdl;
                work_out: out vdi_workout_array);

    function v_resize_bm(
                handle : VdiHdl;
                width  : int16;
                height : int16;
                byte_width: int32;
                addr   : void_ptr)
               return boolean;

    procedure v_clsvwk(handle: VdiHdl);

    procedure v_clsbm(handle: VdiHdl);

    procedure vq_extnd(
                handle     : VdiHdl;
                flag       : int16;
                work_out:  out vdi_workout_array);

    procedure vq_scrninfo(
                handle  : int16;
                work_out: out short_array);

    procedure v_contourfill(
                handle   : VdiHdl;
                x        : int16;
                y        : int16;
                color_idx: int16);

    function vsf_perimeter(
                handle: VdiHdl;
                vis: int16)
               return int16;

    function vsf_perimeter(
                handle : VdiHdl;
                vis  : int16;
                style: int16)
               return int16;

    procedure v_get_pixel(
                handle   : VdiHdl;
                x        : int16;
                y        : int16;
                pel      : out int16;
                color_idx: out int16);

    function vst_effects(
                handle : VdiHdl;
                effects: int16)
               return int16;

    function vst_point(
                handle : VdiHdl;
                point: int16;
                charw: out int16;
                charh: out int16;
                cellw: out int16;
                cellh: out int16)
               return int16;

    procedure vsl_ends(
                handle  : VdiHdl;
                begstyle: int16;
                endstyle: int16);

    procedure vro_cpyfm(
                handle : VdiHdl;
                mode   : int16;
                pxy    : short_array;
                src    : in MFDB;
                dst    : in MFDB);

    procedure vr_trnfm(
                handle: VdiHdl;
                src: in MFDB;
                dst: in MFDB);

    subtype MFORM_const_ptr is Atari.Aes.MFORM_const_ptr;
    procedure vsc_form(
                handle: VdiHdl;
                form: MFORM_const_ptr);

    procedure vsf_udpat(
                handle: VdiHdl;
                pat   : in short_array;
                planes: int16);

    procedure vsl_udsty(
                handle: VdiHdl;
                pattern: int16);

    procedure vr_recfl(
                handle : VdiHdl;
                pxy    : short_array);

    procedure vqin_mode(
                handle: VdiHdl;
                dev_type : int16;
                input_mode: out int16);

    procedure vqt_extent(
                handle: VdiHdl;
                str   : in String;
                extent: out short_array);

    procedure vqt_extent(
                handle: VdiHdl;
                str   : in Wide_String;
                extent: out short_array);

    function vqt_width(
                handle: VdiHdl;
                chr   : int16;
                cell_width    : out int16;
                left_delta: out int16;
                right_delta: out int16)
               return int16;

    procedure vex_timv(
                handle    : VdiHdl;
                time_addr : System.Address;
                otime_addr: out System.Address;
                time_conv : out int16);

    function vst_load_fonts(
                handle: VdiHdl;
                reserved_select: int16)
               return int16;

    procedure vst_unload_fonts(
                handle: VdiHdl;
                reserved_select: int16);

    procedure vrt_cpyfm(
                handle  : VdiHdl;
                mode    : int16;
                pxy     : short_array;
                src     : in MFDB;
                dst     : in MFDB;
                color   : in short_array);

    procedure v_show_c(handle : VdiHdl; reset: int16 := 0);

    procedure v_hide_c(handle: VdiHdl);

    procedure vq_mouse(
                handle : VdiHdl;
                pstatus: out int16;
                x      : out int16;
                y      : out int16);

    procedure vex_butv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address);

    procedure vex_motv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address);

    procedure vex_curv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address);

    procedure vq_key_s(
                handle : VdiHdl;
                state: out int16);

    procedure vs_clip(
                handle   : VdiHdl;
                clip_flag: int16;
                pxy      : short_array);

    procedure vs_clip(
                handle   : VdiHdl;
                clip_flag: int16;
                pxy      : PXY_array);

    function vqt_name(
                handle : VdiHdl;
                element: int16;
                name   : out String)
               return int16;

    procedure vqt_fontinfo(
                handle   : VdiHdl;
                minade   : out int16;
                maxade   : out int16;
                distances: out short_array;
                maxwidth : out int16;
                effects  : out short_array);

    procedure vex_wheelv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address);




    procedure vdi_array2str(
                src: in short_array;
                dst: chars_ptr;
                maxlen: int16);

    function vdi_str2array(
                src: chars_ptr;
                dst: out short_array)
               return int16;

    function vdi_wstrlen(wstr: in Wide_String) return int16;





    function vq_vgdos return uint32;

    function vq_gdos return boolean;


--
-- UDEF version of functions above.
-- Since the implementation uses static arrays,
-- all of these are identical to their normal version
---

    procedure udef_v_opnwk(
                work_in : short_array;
                handle  : in out VdiHdl;
                work_out: out vdi_workout_array)
               renames v_opnwk;

    procedure udef_v_clswk(handle: VdiHdl)
               renames v_clswk;

    procedure udef_v_clrwk(handle: VdiHdl)
               renames v_clrwk;

    procedure udef_v_updwk(handle: VdiHdl)
               renames v_updwk;

    procedure udef_vq_chcells(
                handle: VdiHdl;
                n_rows: out int16;
                n_cols: out int16)
               renames vq_chcells;

    procedure udef_v_exit_cur(handle: VdiHdl)
               renames v_exit_cur;

    procedure udef_v_enter_cur(handle: VdiHdl)
               renames v_enter_cur;

    procedure udef_v_curup(handle: VdiHdl)
               renames v_curup;

    procedure udef_v_curdown(handle: VdiHdl)
               renames v_curdown;

    procedure udef_v_curright(handle: VdiHdl)
               renames v_curright;

    procedure udef_v_curleft(handle: VdiHdl)
               renames v_curleft;

    procedure udef_v_curhome(handle: VdiHdl)
               renames v_curhome;

    procedure udef_v_eeos(handle: VdiHdl)
               renames v_eeos;

    procedure udef_v_eeol(handle: VdiHdl)
               renames v_eeol;

    procedure udef_v_curaddress(
                handle: VdiHdl;
                row: int16;
                col: int16)
               renames v_curaddress;

    procedure udef_vs_curaddress(
                handle: VdiHdl;
                row: int16;
                col: int16)
               renames v_curaddress;

    procedure udef_v_curtext(handle: VdiHdl; str: in String)
        renames v_curtext;

    procedure udef_v_curtext(handle: VdiHdl; str: in String; maxlen: int16) renames v_curtext;

    procedure udef_v_curtext(handle: VdiHdl; str: in Wide_String) renames v_curtext;

    procedure udef_v_curtext(handle: VdiHdl; str: in Wide_String; maxlen: int16) renames v_curtext;

    procedure udef_v_rvon(handle: VdiHdl)
               renames v_rvon;

    procedure udef_v_rvoff(handle: VdiHdl)
               renames v_rvoff;

    procedure udef_vq_curaddress(
                handle : VdiHdl;
                cur_row: out int16;
                cur_col: out int16)
               renames vq_curaddress;

    function udef_vq_tabstatus(handle: VdiHdl) return int16
               renames vq_tabstatus;

    procedure udef_v_hardcopy(handle: VdiHdl)
               renames v_hardcopy;

    procedure udef_v_dspcur(handle: VdiHdl; x : int16; y : int16)
               renames v_dspcur;

    procedure udef_v_rmcur(handle: VdiHdl)
               renames v_rmcur;

    procedure udef_v_form_adv(handle: VdiHdl)
               renames v_form_adv;

    procedure udef_v_output_window(handle: VdiHdl; pxy: short_array)
               renames v_output_window;

    procedure udef_v_clear_disp_list(handle: VdiHdl)
               renames v_clear_disp_list;

    procedure udef_v_bit_image(
                handle  : VdiHdl;
                filename: String;
                aspect  : int16;
                x_scale : int16;
                y_scale : int16;
                h_align : int16;
                v_align : int16;
                pxy     : short_array)
               renames v_bit_image;

    procedure udef_vq_scan(
                handle : VdiHdl;
                g_slice: out int16;
                g_page : out int16;
                a_slice: out int16;
                a_page : out int16;
                div_fac: out int16)
               renames vq_scan;

    procedure udef_v_alpha_text(handle: VdiHdl; str: in String)
               renames v_alpha_text;

    function udef_v_orient(
                handle     : VdiHdl;
                orientation: int16)
               return int16
               renames v_orient;

    function udef_v_copies(
                handle: VdiHdl;
                count: int16)
               return int16
               renames v_copies;

    function udef_v_tray(
                handle    : VdiHdl;
                input     : int16)
               return boolean
              renames v_tray;

    function udef_v_trays(
                handle    : VdiHdl;
                input     : int16;
                output    : int16;
                set_input : out int16;
                set_output: out int16)
               return boolean
               renames v_trays;

    function udef_v_page_size(
                handle : VdiHdl;
                page_id: int16)
               return int16
               renames v_page_size;

    function udef_vs_palette(
                handle : VdiHdl;
                palette: int16)
               return int16
               renames vs_palette;

    procedure udef_v_sound(
                handle  : VdiHdl;
                freq    : int16;
                duration: int16)
               renames v_sound;

    function udef_vs_mute(
                handle: VdiHdl;
                action: int16)
               return int16
               renames vs_mute;

    procedure udef_vt_resolution(
                handle: VdiHdl;
                xres: int16;
                yres: int16;
                xset: out int16;
                yset: out int16)
               renames vt_resolution;

    procedure udef_vt_axis(
                handle: VdiHdl;
                xres: int16;
                yres: int16;
                xset: out int16;
                yset: out int16)
               renames vt_axis;

    procedure udef_vt_alignment(
                handle: VdiHdl;
                dx: int16;
                dy: int16)
               renames vt_alignment;

    procedure udef_vsp_film(
                handle   : VdiHdl;
                color_idx: int16;
                lightness: int16)
               renames vsp_film;

    function udef_vqp_filmname(
                handle: VdiHdl;
                index: int16;
                name : out String)
               return int16
               renames vqp_filmname;

    procedure udef_vsc_expose(
                handle: VdiHdl;
                state: int16)
               renames vsc_expose;

    procedure udef_v_meta_extents(
                handle: VdiHdl;
                min_x: int16;
                min_y: int16;
                max_x: int16;
                max_y: int16)
               renames v_meta_extents;

    procedure udef_v_write_meta(
                handle      : VdiHdl;
                numvdi_intin: int16;
                a_intin     : in short_array;
                num_ptsin   : int16;
                a_ptsin     : in short_array)
               renames v_write_meta;

    procedure udef_vm_pagesize(
                handle  : VdiHdl;
                pgwidth : int16;
                pgheight: int16)
               renames vm_pagesize;

    procedure udef_vm_coords(
                handle: VdiHdl;
                llx: int16;
                lly: int16;
                urx: int16;
                ury: int16)
               renames vm_coords;

    function udef_v_bez_qual(
                handle: VdiHdl;
                prcnt: int16) return int16
               renames v_bez_qual;

    procedure udef_vm_filename(
                handle  : VdiHdl;
                filename: in String)
               renames vm_filename;

    procedure udef_v_offset(
                handle: VdiHdl;
                offset: int16)
               renames v_offset;

    procedure udef_v_fontinit(
                handle     : VdiHdl;
                font_header: System.Address)
               renames v_fontinit;

    procedure udef_v_escape2000(
                handle: VdiHdl;
                times: int16)
               renames v_escape2000;

    procedure udef_v_pline(
                handle: VdiHdl;
                count : int16;
                pxy: short_array)
               renames v_pline;

    procedure udef_v_bez(
                handle: VdiHdl;
                count : int16;
                pxy:    short_array;
                bezarr: System.Address;
                extent: out short_array;
                totpts: out int16;
                totmoves: out int16)
               renames v_bez;

    procedure udef_v_pmarker(
                handle: VdiHdl;
                count : int16;
                pxy: short_array)
               renames v_pmarker;

    procedure udef_v_gtext(
                handle: VdiHdl;
                x  : int16;
                y  : int16;
                str: in String)
               renames v_gtext;

    procedure udef_v_gtext(
                handle: VdiHdl;
                x  : int16;
                y  : int16;
                str: in Wide_String)
               renames v_gtext;

    procedure udef_v_fillarea(
                handle: VdiHdl;
                count : int16;
                pxy: short_array)
               renames v_fillarea;

    procedure udef_v_bez_fill(
                handle: VdiHdl;
                count : int16;
                pxy:    short_array;
                bezarr: System.Address;
                extent: out short_array;
                totpts: out int16;
                totmoves: out int16)
               renames v_bez_fill;

    procedure udef_v_bar(
                handle: VdiHdl;
                pxy: short_array)
               renames v_bar;

    procedure udef_v_arc(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                radius: int16;
                begang: int16;
                endang: int16)
               renames v_arc;

    procedure udef_v_pieslice(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                radius: int16;
                begang: int16;
                endang: int16)
               renames v_pieslice;

    procedure udef_v_circle(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                radius: int16)
               renames v_circle;

    procedure udef_v_ellipse(
                handle: VdiHdl;
                x   : int16;
                y   : int16;
                xrad: int16;
                yrad: int16)
               renames v_ellipse;

    procedure udef_v_ellarc(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                xrad  : int16;
                yrad  : int16;
                begang: int16;
                endang: int16)
               renames v_ellarc;

    procedure udef_v_ellpie(
                handle: VdiHdl;
                x     : int16;
                y     : int16;
                xrad  : int16;
                yrad  : int16;
                begang: int16;
                endang: int16)
               renames v_ellpie;

    procedure udef_v_rbox(
                handle: VdiHdl;
                pxy: short_array)
               renames v_rbox;

    procedure udef_v_rfbox(
                handle: VdiHdl;
                pxy: short_array)
               renames v_rfbox;

    procedure udef_v_justified(
                handle    : VdiHdl;
                x         : int16;
                y         : int16;
                str       : in String;
                len       : int16;
                word_space: int16;
                char_space: int16)
               renames v_justified;

    procedure udef_v_justified(
                handle    : VdiHdl;
                x         : int16;
                y         : int16;
                wstr      : in Wide_String;
                width     : int16;
                word_space: int16;
                char_space: int16)
               renames v_justified;

    function udef_v_bez_on(handle: VdiHdl) return int16 renames v_bez_on;
    procedure udef_v_bez_off(handle: VdiHdl) renames v_bez_off;

    procedure udef_vst_height(
                handle: VdiHdl;
                height: int16;
                charw : out int16;
                charh : out int16;
                cellw : out int16;
                cellh : out int16)
               renames vst_height;

    function udef_vst_rotation(
                handle: VdiHdl;
                ang: int16)
               return int16
               renames vst_rotation;

    procedure udef_vs_color(
                handle   : VdiHdl;
                color_idx: int16;
                rgb      : in short_array)
               renames vs_color;

    function udef_vsl_type(
                handle : VdiHdl;
                style: int16)
               return int16
               renames vsl_type;

    function udef_vsl_width(
                handle : VdiHdl;
                width: int16)
               return int16
               renames vsl_width;

    function udef_vsl_color(
                handle   : VdiHdl;
                color_idx: int16)
               return int16
               renames vsl_color;

    function udef_vsm_type(
                handle: VdiHdl;
                symbol: int16)
               return int16
               renames vsm_type;

    function udef_vsm_height(
                handle: VdiHdl;
                height: int16)
               return int16
               renames vsm_height;

    function udef_vsm_color(
                handle   : VdiHdl;
                color_idx: int16)
               return int16
               renames vsm_color;

    function udef_vst_font(
                handle: VdiHdl;
                font: int16)
               return int16
               renames vst_font;

    function udef_vst_color(
                handle   : VdiHdl;
                color_idx: int16)
               return int16
               renames vst_color;

    function udef_vsf_interior(
                handle : VdiHdl;
                style: int16)
               return int16
               renames vsf_interior;

    function udef_vsf_style(
                handle : VdiHdl;
                style: int16)
               return int16
               renames vsf_style;

    function udef_vsf_color(
                handle   : VdiHdl;
                color_idx: int16)
               return int16
               renames vsf_color;

    function udef_vq_color(
                handle   : VdiHdl;
                color_idx: int16;
                flag     : int16;
                rgb      : out short_array)
               return int16
               renames vq_color;

    procedure udef_vrq_locator(
                handle: VdiHdl;
                x   : int16;
                y   : int16;
                xout: out int16;
                yout: out int16;
                term: out int16)
               renames vrq_locator;

    function udef_vsm_locator(
                handle: VdiHdl;
                x   : int16;
                y   : int16;
                xout: out int16;
                yout: out int16;
                term: out int16)
               return int16
               renames vsm_locator;

    procedure udef_vrq_valuator(
                handle: VdiHdl;
                c_in : int16;
                c_out: out int16;
                term : out int16)
               renames vrq_valuator;

    procedure udef_vsm_valuator(
                handle: VdiHdl;
                c_in  : int16;
                c_out : out int16;
                term  : out int16;
                status: out int16)
               renames vsm_valuator;

    procedure udef_vrq_choice(
                handle: VdiHdl;
                cin : int16;
                cout: out int16)
               renames vrq_choice;

    function udef_vsm_choice(
                handle: VdiHdl;
                choice: out int16)
               return int16
               renames vsm_choice;

    procedure udef_vrq_string(
                handle   : VdiHdl;
                len      : int16;
                echo     : int16;
                echoxy   : in short_array;
                str      : out String)
               renames vrq_string;

    function udef_vsm_string(
                handle   : VdiHdl;
                len      : int16;
                echo     : int16;
                echoxy   : in short_array;
                str      : out String)
               return int16
               renames vsm_string;

    function udef_vswr_mode(
                handle: VdiHdl;
                mode: int16)
               return int16
               renames vswr_mode;

    function udef_vsin_mode(
                handle: VdiHdl;
                dev : int16;
                mode: int16)
               return int16
               renames vsin_mode;

    procedure udef_vql_attributes(
                handle  : VdiHdl;
                attrib  : out short_array)
               renames vql_attributes;

    procedure udef_vqm_attributes(
                handle  : VdiHdl;
                attrib  : out short_array)
               renames vqm_attributes;

    procedure udef_vqf_attributes(
                handle: VdiHdl;
                attrib: out short_array)
               renames vqf_attributes;

    procedure udef_vqt_attributes(
                handle  : VdiHdl;
                attrib  : out short_array)
               renames vqt_attributes;

    procedure udef_vst_alignment(
                handle: VdiHdl;
                hin : int16;
                vin : int16;
                hout: out int16;
                vout: out int16)
               renames vst_alignment;

    procedure udef_v_opnvwk(
                work_in : vdi_workin_array;
                handle  : in out VdiHdl;
                work_out: out vdi_workout_array)
               renames v_opnvwk;

    procedure udef_v_clsvwk(handle: VdiHdl)
               renames v_clsvwk;

    procedure udef_vq_extnd(
                handle     : VdiHdl;
                flag       : int16;
                work_out   : out vdi_workout_array)
               renames vq_extnd;

    procedure udef_vq_scrninfo(
                handle  : int16;
                work_out: out short_array)
               renames vq_scrninfo;

    procedure udef_v_contourfill(
                handle   : VdiHdl;
                x        : int16;
                y        : int16;
                color_idx: int16)
               renames v_contourfill;

    function udef_vsf_perimeter(
                handle: VdiHdl;
                vis: int16)
               return int16
               renames vsf_perimeter;

    function udef_vsf_perimeter(
                handle : VdiHdl;
                vis  : int16;
                style: int16)
               return int16
               renames vsf_perimeter;

    procedure udef_v_get_pixel(
                handle   : VdiHdl;
                x        : int16;
                y        : int16;
                pel      : out int16;
                color_idx: out int16)
               renames v_get_pixel;

    function udef_vst_effects(
                handle : VdiHdl;
                effects: int16)
               return int16
               renames vst_effects;

    function udef_vst_point(
                handle : VdiHdl;
                point: int16;
                charw: out int16;
                charh: out int16;
                cellw: out int16;
                cellh: out int16)
               return int16
               renames vst_point;

    procedure udef_vsl_ends(
                handle  : VdiHdl;
                begstyle: int16;
                endstyle: int16)
               renames vsl_ends;

    procedure udef_vro_cpyfm(
                handle : VdiHdl;
                mode   : int16;
                pxy: short_array;
                src    : in MFDB;
                dst    : in MFDB)
               renames vro_cpyfm;

    procedure udef_vr_trnfm(
                handle: VdiHdl;
                src: in MFDB;
                dst: in MFDB)
               renames vr_trnfm;

    procedure udef_vsc_form(
                handle: VdiHdl;
                form: MFORM_const_ptr)
               renames vsc_form;

    procedure udef_vsf_udpat(
                handle: VdiHdl;
                pat   : in short_array;
                planes: int16)
               renames vsf_udpat;

    procedure udef_vsl_udsty(
                handle: VdiHdl;
                pat: int16)
               renames vsl_udsty;

    procedure udef_vr_recfl(
                handle : VdiHdl;
                pxy: short_array)
               renames vr_recfl;

    procedure udef_vqin_mode(
                handle: VdiHdl;
                dev : int16;
                mode: out int16)
               renames vqin_mode;

    procedure udef_vqt_extent(
                handle   : VdiHdl;
                str      : in String;
                extent   : out short_array)
               renames vqt_extent;

    procedure udef_vqt_extent(
                handle   : VdiHdl;
                wstr     : in Wide_String;
                extent   : out short_array)
               renames vqt_extent;

    function udef_vqt_width(
                handle: VdiHdl;
                chr   : int16;
                cw    : out int16;
                ldelta: out int16;
                rdelta: out int16)
               return int16
               renames vqt_width;

    procedure udef_vex_timv(
                handle    : VdiHdl;
                time_addr : System.Address;
                otime_addr: out System.Address;
                time_conv : out int16)
               renames vex_timv;

    function udef_vst_load_fonts(
                handle: VdiHdl;
                reserved_select: int16)
               return int16
               renames vst_load_fonts;

    procedure udef_vst_unload_fonts(
                handle: VdiHdl;
                reserved_select: int16)
               renames vst_unload_fonts;

    procedure udef_vrt_cpyfm(
                handle  : VdiHdl;
                mode    : int16;
                pxy     : short_array;
                src     : in MFDB;
                dst     : in MFDB;
                color   : short_array)
               renames vrt_cpyfm;

    procedure udef_v_show_c(
                handle: VdiHdl;
                reset: int16)
               renames v_show_c;

    procedure udef_v_hide_c(
                handle: VdiHdl)
               renames v_hide_c;

    procedure udef_vq_mouse(
                handle : VdiHdl;
                pstatus: out int16;
                x      : out int16;
                y      : out int16)
               renames vq_mouse;

    procedure udef_vex_butv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address)
               renames vex_butv;

    procedure udef_vex_motv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address)
               renames vex_motv;

    procedure udef_vex_curv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address)
               renames vex_curv;

    procedure udef_vq_key_s(
                handle: VdiHdl;
                state: out int16)
               renames vq_key_s;

    procedure udef_vs_clip(
                handle   : VdiHdl;
                clip_flag: int16;
                pxy   : short_array)
               renames vs_clip;

    function udef_vqt_name(
                handle : VdiHdl;
                element: int16;
                name   : out String)
               return int16
               renames vqt_name;

    procedure udef_vqt_fontinfo(
                handle   : VdiHdl;
                minade   : out int16;
                maxade   : out int16;
                distances: out short_array;
                maxwidth : out int16;
                effects  : out short_array)
               renames vqt_fontinfo;

    procedure udef_vex_wheelv(
                handle  : VdiHdl;
                pusrcode: System.Address;
                psavcode: out System.Address)
               renames vex_wheelv;

    function udef_vq_gdos return boolean
               renames vq_gdos;

    function udef_vq_vgdos return uint32
               renames vq_vgdos;

	procedure vdi_to_string(dst: out String; maxlen: int16; offset: int16 := 0);
	function string_to_vdi(src: in String; offset: int16) return int16;

end Atari.Vdi;
