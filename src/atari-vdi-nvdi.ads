with Atari.Aes.Pdlg;

package Atari.Vdi.Nvdi is

	subtype fix31 is int32;

    PX_1COMP                 : constant  := 16#1000000#;        -- *< Pixel besteht aus einer benutzten Komponente: Farbindex
    PX_3COMP                 : constant  := 16#3000000#;        -- *< Pixel besteht aus drei benutzten Komponenten, z.B. RGB
    PX_4COMP                 : constant  := 16#4000000#;        -- *< Pixel besteht aus vier benutzten Komponenten, z.B. CMYK
    PX_REVERSED              : constant  := 16#800000#;         -- *< Pixel wird in umgekehrter Bytreihenfolge ausgegeben
    PX_xFIRST                : constant  := 16#400000#;         -- *< unbenutzte Bits liegen vor den benutzen (im Motorola-Format betrachtet)
    PX_kFIRST                : constant  := 16#200000#;         -- *< K liegt vor CMY (im Motorola-Format betrachtet)
    PX_aFIRST                : constant  := 16#100000#;         -- *< Alphakanal liegen vor den Farbbits (im Motorola-Format betrachtet)
    PX_PACKED                : constant  := 16#20000#;          -- *< Bits sind aufeinanderfolgend abgelegt
    PX_PLANES                : constant  := 16#10000#;          -- *< Bits sind auf mehrere Ebenen verteilt (Reihenfolge: 0, 1, ..., n)
    PX_IPLANES               : constant  := 16#0#;              -- *< Bits sind auf mehrere Worte verteilt (Reihenfolge: 0, 1, ..., n)
    PX_USES1                 : constant  := 16#100#;            -- *< 1 Bit des Pixels wird benutzt
    PX_USES2                 : constant  := 16#200#;            -- *< 2 Bit des Pixels werden benutzt
    PX_USES3                 : constant  := 16#300#;            -- *< 3 Bit des Pixels werden benutzt
    PX_USES4                 : constant  := 16#400#;            -- *< 4 Bit des Pixels werden benutzt
    PX_USES8                 : constant  := 16#800#;            -- *< 8 Bit des Pixels werden benutzt
    PX_USES15                : constant  := 16#f00#;            -- *< 15 Bit des Pixels werden benutzt
    PX_USES16                : constant  := 16#1000#;           -- *< 16 Bit des Pixels werden benutzt
    PX_USES24                : constant  := 16#1800#;           -- *< 24 Bit des Pixels werden benutzt
    PX_USES32                : constant  := 16#2000#;           -- *< 32 Bit des Pixels werden benutzt
    PX_USES48                : constant  := 16#3000#;           -- *< 48 Bit des Pixels werden benutzt
    PX_1BIT                  : constant  := 16#1#;              -- *< Pixel besteht aus 1 Bit
    PX_2BIT                  : constant  := 16#2#;              -- *< Pixel besteht aus 2 Bit
    PX_3BIT                  : constant  := 16#3#;              -- *< Pixel besteht aus 3 Bit
    PX_4BIT                  : constant  := 16#4#;              -- *< Pixel besteht aus 4 Bit
    PX_8BIT                  : constant  := 16#8#;              -- *< Pixel besteht aus 8 Bit
    PX_16BIT                 : constant  := 16#10#;             -- *< Pixel besteht aus 16 Bit
    PX_24BIT                 : constant  := 16#18#;             -- *< Pixel besteht aus 24 Bit
    PX_32BIT                 : constant  := 16#20#;             -- *< Pixel besteht aus 32 Bit
    PX_48BIT                 : constant  := 16#30#;             -- *< Pixel besteht aus 48 Bit
    PX_CMPNTS                : constant  := 16#f000000#;        -- *< Maske fr Anzahl der Pixelkomponenten
    PX_FLAGS                 : constant  := 16#f00000#;         -- *< Maske fr diverse Flags
    PX_PACKING               : constant  := 16#30000#;          -- *< Maske fr Pixelformat
    PX_USED                  : constant  := 16#3f00#;           -- *< Maske fr Anzahl der benutzten Bits
    PX_BITS                  : constant  := 16#3f#;             -- *< Maske fr Anzahl der Bits pro Pixel

    PX_ATARI1                : constant  := PX_PACKED + PX_1COMP + PX_USES1 + PX_1BIT;
    PX_ATARI2                : constant  := PX_IPLANES + PX_1COMP + PX_USES2 + PX_2BIT;
    PX_ATARI4                : constant  := PX_IPLANES + PX_1COMP + PX_USES4 + PX_4BIT;
    PX_ATARI8                : constant  := PX_IPLANES + PX_1COMP + PX_USES8 + PX_8BIT;
    PX_FALCON15              : constant  := PX_PACKED + PX_3COMP + PX_USES16 + PX_16BIT;
    PX_MAC1                  : constant  := PX_PACKED + PX_1COMP + PX_USES1 + PX_1BIT;
    PX_MAC4                  : constant  := PX_PACKED + PX_1COMP + PX_USES4 + PX_4BIT;
    PX_MAC8                  : constant  := PX_PACKED + PX_1COMP + PX_USES8 + PX_8BIT;
    PX_MAC15                 : constant  := PX_xFIRST + PX_PACKED + PX_3COMP + PX_USES15 + PX_16BIT;
    PX_MAC32                 : constant  := PX_xFIRST + PX_PACKED + PX_3COMP + PX_USES24 + PX_32BIT;
    PX_VGA1                  : constant  := PX_PACKED + PX_1COMP + PX_USES1 + PX_1BIT;
    PX_VGA4                  : constant  := PX_PLANES + PX_1COMP + PX_USES4 + PX_4BIT;
    PX_VGA8                  : constant  := PX_PACKED + PX_1COMP + PX_USES8 + PX_8BIT;
    PX_VGA15                 : constant  := PX_REVERSED + PX_xFIRST + PX_PACKED + PX_3COMP + PX_USES15 + PX_16BIT;
    PX_VGA16                 : constant  := PX_REVERSED + PX_PACKED + PX_3COMP + PX_USES16 + PX_16BIT;
    PX_VGA24                 : constant  := PX_REVERSED + PX_PACKED + PX_3COMP + PX_USES24 + PX_24BIT;
    PX_VGA32                 : constant  := PX_REVERSED + PX_xFIRST + PX_PACKED + PX_3COMP + PX_USES24 + PX_32BIT;
    PX_MATRIX16              : constant  := PX_PACKED + PX_3COMP + PX_USES16 + PX_16BIT;
    PX_NOVA32                : constant  := PX_PACKED + PX_3COMP + PX_USES24 + PX_32BIT;
    PX_PRN1                  : constant  := PX_PACKED + PX_1COMP + PX_USES1 + PX_1BIT;
    PX_PRN8                  : constant  := PX_PACKED + PX_1COMP + PX_USES8 + PX_8BIT;
    PX_PRN32                 : constant  := PX_xFIRST + PX_PACKED + PX_3COMP + PX_USES24 + PX_32BIT;
    PX_PREF1                 : constant  := PX_PACKED + PX_1COMP + PX_USES1 + PX_1BIT;
    PX_PREF2                 : constant  := PX_PACKED + PX_1COMP + PX_USES2 + PX_2BIT;
    PX_PREF4                 : constant  := PX_PACKED + PX_1COMP + PX_USES4 + PX_4BIT;
    PX_PREF8                 : constant  := PX_PACKED + PX_1COMP + PX_USES8 + PX_8BIT;
    PX_PREF15                : constant  := PX_xFIRST + PX_PACKED + PX_3COMP + PX_USES15 + PX_16BIT;
    PX_PREF32                : constant  := PX_xFIRST + PX_PACKED + PX_3COMP + PX_USES24 + PX_32BIT;

    COLOR_TAB_MAGIC          : constant  := 16#63746162#;       -- 'ctab'
    CBITMAP_MAGIC            : constant  := 16#6362746d#;       -- 'cbtm'

    T_NOT                    : constant  := 4;                  -- *< Konstante fr Invertierung bei logischen Transfermodi
    T_COLORIZE               : constant  := 16;                 -- *< Konstante fr Einf„rbung
    T_LOGIC_MODE             : constant  := 0;
    T_DRAW_MODE              : constant  := 32;
    T_ARITH_MODE             : constant  := 64;                 -- *< Konstante fr Arithmetische Transfermodi
    T_DITHER_MODE            : constant  := 128;                -- *< Konstante frs Dithern

    T_LOGIC_COPY             : constant  := T_LOGIC_MODE+0;
    T_LOGIC_OR               : constant  := T_LOGIC_MODE+1;
    T_LOGIC_XOR              : constant  := T_LOGIC_MODE+2;
    T_LOGIC_AND              : constant  := T_LOGIC_MODE+3;
    T_LOGIC_NOT_COPY         : constant  := T_LOGIC_MODE+4;
    T_LOGIC_NOT_OR           : constant  := T_LOGIC_MODE+5;
    T_LOGIC_NOT_XOR          : constant  := T_LOGIC_MODE+6;
    T_LOGIC_NOT_AND          : constant  := T_LOGIC_MODE+7;

    T_REPLACE                : constant  := T_DRAW_MODE+0;
    T_TRANSPARENT            : constant  := T_DRAW_MODE+1;
    T_HILITE                 : constant  := T_DRAW_MODE+2;
    T_REVERS_TRANSPARENT     : constant  := T_DRAW_MODE+3;

    T_BLEND                  : constant  := T_ARITH_MODE+0;
    T_ADD                    : constant  := T_ARITH_MODE+1;
    T_ADD_OVER               : constant  := T_ARITH_MODE+2;
    T_SUB                    : constant  := T_ARITH_MODE+3;
    T_MAX                    : constant  := T_ARITH_MODE+5;
    T_SUB_OVER               : constant  := T_ARITH_MODE+6;
    T_MIN                    : constant  := T_ARITH_MODE+7;

    type vdi_colorspace_type is (
        CSPACE_RGB,
        CSPACE_ARGB,
        CSPACE_CMYK
    );
    for vdi_colorspace_type use (
        CSPACE_RGB => 1,
        CSPACE_ARGB => 2,
        CSPACE_CMYK => 4
    );
    for vdi_colorspace_type'Size use int16'Size;

    type vdi_components_type is (
        CSPACE_1COMPONENT,
        CSPACE_2COMPONENTS,
        CSPACE_3COMPONENTS,
        CSPACE_4COMPONENTS
    );
    for vdi_components_type use (
        CSPACE_1COMPONENT => 1,
        CSPACE_2COMPONENTS => 2,
        CSPACE_3COMPONENTS => 3,
        CSPACE_4COMPONENTS => 4
    );
    for vdi_components_type'Size use int16'Size;
    type INVERSE_CTAB is new System.Address;

    type ITAB_REF is new System.Address;

	type POINT32 is
		record
			x: int32;
			y: int32;
		end record;
	type POINT32_ptr is access all POINT32;
	
	type RECT16 is
		record
			x1: int16;
			y1: int16;
			x2: int16;
			y2: int16;
		end record;
	type RECT16_ptr is access all RECT16;
	
	type RECT32 is
		record
			x1: int32;
			y1: int32;
			x2: int32;
			y2: int32;
		end record;
	type RECT32_ptr is access all RECT32;
	
    type BIT_IMAGE is
        record
            nbplanes: aliased int16;
            width   : aliased int16;
            height  : aliased int16;
        end record;

    type FONT_HDR;
    type FONT_HDR_ptr is access all FONT_HDR;
    type FONT_HDR is record
        font_id         : int16;
        point           : int16;
        name            : char_array(0..31);
        first_ade       : uint16;
        last_ade        : uint16;
        top             : uint16;
        ascent          : uint16;
        half            : uint16;
        descent         : uint16;
        bottom          : uint16;
        max_char_width  : uint16;
        max_cell_width  : uint16;
        left_offset     : uint16;
        right_offset    : uint16;
        thicken         : uint16;
        ul_size         : uint16;
        lighten         : uint16;
        skew            : uint16;
        flags           : uint16;
        hor_table       : System.Address;
        off_table       : System.Address;
        dat_table       : System.Address;
        form_width      : uint16;
        form_height     : uint16;
        next_font       : FONT_HDR_ptr;
    end record;

    type COLOR_RGB is
        record
            reserved: aliased uint16;
            red     : aliased uint16;
            green   : aliased uint16;
            blue    : aliased uint16;
        end record;


    type COLOR_CMYK is
        record
            cyan   : aliased uint16;
            magenta: aliased uint16;
            yellow : aliased uint16;
            black  : aliased uint16;
        end record;


    type COLOR_ENTRY_kind is(
        rgb_kind,
        cmyk_kind
    );

    type COLOR_ENTRY (Which: COLOR_ENTRY_kind := rgb_kind) is
        record
            case Which is
                when rgb_kind =>
                    rgb : aliased COLOR_RGB;
                when cmyk_kind =>
                    cmyk: aliased COLOR_CMYK;
            end case;
        end record;
    pragma Unchecked_Union(COLOR_ENTRY);


    type COLOR_ENTRY_array is
        array(Integer range <>)
        of COLOR_ENTRY;

    type COLOR_TAB is
        record
            magic      : aliased int32;
            length     : aliased int32;
            format     : aliased int32;
            reserved   : aliased int32;
            map_id     : aliased int32;
            color_space: aliased int32;
            flags      : aliased int32;
            no_colors  : aliased int32;
            reserved1  : aliased int32;
            reserved2  : aliased int32;
            reserved3  : aliased int32;
            reserved4  : aliased int32;
            colors     : aliased COLOR_ENTRY_array(0..Integer'Last);
        end record;
    type COLOR_TAB_ptr is access all COLOR_TAB;


    type COLOR_TAB256 is
        record
            magic      : aliased int32;
            length     : aliased int32;
            format     : aliased int32;
            reserved   : aliased int32;
            map_id     : aliased int32;
            color_space: aliased int32;
            flags      : aliased int32;
            no_colors  : aliased int32;
            reserved1  : aliased int32;
            reserved2  : aliased int32;
            reserved3  : aliased int32;
            reserved4  : aliased int32;
            colors_c0  : aliased COLOR_ENTRY_array(0..255);
        end record;


    type GCBITMAP is
        record
            magic      : aliased int32;
            length     : aliased int32;
            format     : aliased int32;
            reserved   : aliased int32;
            addr       : aliased System.Address;
            width      : aliased int32;
            bits       : aliased int32;
            px_format  : aliased uint32;
            xmin       : aliased int32;
            ymin       : aliased int32;
            xmax       : aliased int32;
            ymax       : aliased int32;
            ctab       : aliased COLOR_TAB_ptr;
            itab       : aliased ITAB_REF;
            color_space: aliased int32;
            reserved1  : aliased int32;
        end record;
    type GCBITMAP_ptr is access all GCBITMAP;


    function vs_calibrate(
                handle: VdiHdl;
                flag: int16;
                rgb : in short_array)
               return int16;

    function vq_tray_names(handle: VdiHdl; input_name: chars_ptr; output_name: chars_ptr; input: out int16; output: out int16) return boolean;

    function vq_page_name(
                handle     : VdiHdl;
                page_id    : int16;
                page_name  : chars_ptr;
                page_width : out int32;
                page_height: out int32)
               return int16;

    function vq_calibrate(handle: VdiHdl; flag: out int16) return int16;

	procedure vst_width(handle: VdiHdl; width: int16; char_width, char_height, cell_width, cell_height: out int16);
	
	procedure vqt_fontheader(handle: VdiHdl; buffer: System.Address; pathname: out String);
	
    procedure vst_scratch(handle: VdiHdl; mode: int16);

	procedure vst_error(handle: VdiHdl; mode: int16; errorvar: short_ptr);

    function v_savecache(handle: VdiHdl; filename: in String) return int16;

    function v_loadcache(handle: VdiHdl; filename: in String; mode: int16) return int16;

    function v_flushcache(handle: VdiHdl) return int16;

	function vst_setsize(handle: VdiHdl; point: int16; chwd, chht, cellwd, cellht: out int16) return int16;

	function vst_setsize(handle: VdiHdl; point: fix31; chwd, chht, cellwd, cellht: out int16) return int16;

	function vst_skew(handle: VdiHdl; skew: int16) return int16;

    procedure vqt_get_table(handle: VdiHdl; map: out short_ptr);

    procedure vqt_cachesize(handle: VdiHdl; which_cache: int16; size: out int32);

	function vq_devinfo(handle: VdiHdl; device: int16; dev_exists: out boolean; filename: out String; device_name: out String) return int16;

    function v_open_bm(
                base_handle: VdiHdl;
                bitmap: GCBITMAP_ptr;
                color_flags: int16;
                unit_flags: int16;
                pixel_width, pixel_height: int16) return VdiHdl;

    function vqt_ext_name(
                handle     : VdiHdl;
                index      : int16;
                name       : out String;
                vector_font: out int16;
                font_format: out int16;
                flags      : out int16)
               return int16;

    procedure v_setrgb(
                handle: VdiHdl;
                c_type: int16;
                r     : int16;
                g     : int16;
                b     : int16);

    procedure vr_transfer_bits(
                handle  : VdiHdl;
                src_bm  : in GCBITMAP;
                dst_bm  : in GCBITMAP;
                src_rect: in RECT16;
                dst_rect: in RECT16;
                mode    : int16);

    function v_create_driver_info(
                handle   : VdiHdl;
                driver_id: int16)
               return Aes.Pdlg.DRV_INFO_ptr;

-- utilities

	function fix31_to_point(fix: fix31) return int16;
	function point_to_fix31(point: int16) return fix31;

end Atari.Vdi.Nvdi;
