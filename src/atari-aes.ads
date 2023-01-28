--
-- NOT YET IMPLEMENTED:

-- Geneva functions



package Atari.Aes is
    --
    -- AES
    --

    -- AES standard object colors
    G_WHITE              : constant int16 := 0;
    G_BLACK              : constant int16 := 1;
    G_RED                : constant int16 := 2;
    G_GREEN              : constant int16 := 3;
    G_BLUE               : constant int16 := 4;
    G_CYAN               : constant int16 := 5;
    G_YELLOW             : constant int16 := 6;
    G_MAGENTA            : constant int16 := 7;
    G_LWHITE             : constant int16 := 8;
    G_LBLACK             : constant int16 := 9;
    G_LRED               : constant int16 := 10;
    G_LGREEN             : constant int16 := 11;
    G_LBLUE              : constant int16 := 12;
    G_LCYAN              : constant int16 := 13;
    G_LYELLOW            : constant int16 := 14;
    G_LMAGENTA           : constant int16 := 15;

    --  AES mouse cursor number
    type Mouse_Type is (
        ARROW,
        TEXT_CRSR,
        BUSYBEE,
        POINT_HAND,
        FLAT_HAND,
        THIN_CROSS,
        THICK_CROSS,
        OUTLN_CROSS,
        X_LFTRT,
        X_UPDOWN,
        USER_DEF,
        M_OFF,
        M_ON,
        M_SAVE,
        M_RESTORE,
        M_LAST,
        XACRS_BUBBLE_DISC,
        XACRS_RESIZER,
        XACRS_NE_SIZER,
        XACRS_MOVER,
        XACRS_VERTSIZER,
        XACRS_HORSIZER,
        XACRS_POINTSLIDE,
        X_MRESET,
        X_MGET,
        X_MSET_SHAPE,
        M_FORCE
    );
    for Mouse_Type use (
        ARROW                => 0,                      -- *< see mt_graf_mouse()
        TEXT_CRSR            => 1,                      -- *< see mt_graf_mouse()
        BUSYBEE              => 2,                      -- *< see mt_graf_mouse()
        POINT_HAND           => 3,                      -- *< see mt_graf_mouse()
        FLAT_HAND            => 4,                      -- *< see mt_graf_mouse()
        THIN_CROSS           => 5,                      -- *< see mt_graf_mouse()
        THICK_CROSS          => 6,                      -- *< see mt_graf_mouse()
        OUTLN_CROSS          => 7,                      -- *< see mt_graf_mouse()
        X_LFTRT              => 8,                      -- Geneva, N.AES
        X_UPDOWN             => 9,                      -- Geneva, N.AES
        USER_DEF             => 255,                    -- *< see mt_graf_mouse()
        M_OFF                => 256,                    -- *< see mt_graf_mouse()
        M_ON                 => 257,                    -- *< see mt_graf_mouse()
        M_SAVE               => 258,                    -- *< see mt_graf_mouse()
        M_RESTORE            => 259,                    -- *< see mt_graf_mouse()
        M_LAST               => 260,                    -- *< see mt_graf_mouse()
        XACRS_BUBBLE_DISC    => 270,                    -- XaAES
        XACRS_RESIZER        => 271,                    -- XaAES
        XACRS_NE_SIZER       => 272,                    -- XaAES
        XACRS_MOVER          => 273,                    -- XaAES
        XACRS_VERTSIZER      => 274,                    -- XaAES
        XACRS_HORSIZER       => 275,                    -- XaAES
        XACRS_POINTSLIDE     => 276,                    -- XaAES
        X_MRESET             => 1000,                   -- geneva
        X_MGET               => 1001,                   -- geneva
        X_MSET_SHAPE         => 1100,                   -- geneva
        M_FORCE              => 16#8000#                -- *< see mt_graf_mouse()
    );
    for Mouse_Type'Size use int16'Size;
    BEE: constant Mouse_Type := BUSYBEE;
    BUSY_BEE: constant Mouse_Type := BUSYBEE;
    HOURGLASS: constant Mouse_Type := BUSYBEE;
    M_PREVIOUS: constant Mouse_Type := M_LAST;

    --  inside patterns
    IP_HOLLOW            : constant  := 0;
    IP_1PATT             : constant  := 1;
    IP_2PATT             : constant  := 2;
    IP_3PATT             : constant  := 3;
    IP_4PATT             : constant  := 4;
    IP_5PATT             : constant  := 5;
    IP_6PATT             : constant  := 6;
    IP_SOLID             : constant  := 7;

    -- AP_DRAGDROP return codes
    DD_OK        : constant  := 0;
    DD_NAK       : constant  := 1;
    DD_EXT       : constant  := 2;
    DD_LEN       : constant  := 3;
    DD_TRASH     : constant  := 4;
    DD_PRINTER   : constant  := 5;
    DD_CLIPBOARD : constant  := 6;

    DD_TIMEOUT  : constant  := 4000;     -- Timeout in ms

    DD_NUMEXTS  : constant  := 8;        -- Number of formats
    DD_EXTLEN   : constant  := 4;
    DD_EXTSIZE  : constant  := DD_NUMEXTS * DD_EXTLEN;

    DD_FNAME    : constant String := "U:\PIPE\DRAGDROP.AA";
    DD_NAMEMAX  : constant  := 128;      -- Maximum length of a format name
    DD_HDRMIN   : constant  := 9;            -- Minimum length of Drag&Drop headers
    DD_HDRMAX   : constant  := 8 + DD_NAMEMAX;   -- Maximum length

    type AESContrl is record
        opcode: int16;
        num_intin: int16;
        num_intout: int16;
        num_addrin: int16;
        num_addrout: int16;
    end record;

    subtype AESGlobal is short_array(0..14);
    subtype AESIntIn is short_array(0..15);
    subtype AESIntOut is short_array(0..15);
    type AESAddrIn is array(0..7) of void_ptr;
    type AESAddrOut is array(0..1) of void_ptr;

    type AESContrl_ptr is access AESContrl;
    type AESGlobal_ptr is access AESGlobal;

    type AESPB is record
        control: access AESContrl;
        global: access AESGlobal;
        intin: access AESIntIn;
        intout: access AESIntOut;
        addrin: access AESAddrIn;
        addrout: access AESAddrOut;
    end record;
    type AESPB_ptr is access all AESPB;

    --  AES/VDI mouse form structure

    type MFORM is record
       mf_xhot: int16;          -- X-position hot-spot
       mf_yhot: int16;          -- Y-position hot-spot
       mf_nplanes: int16;       -- Number of planes
       mf_fg: int16;            -- Mask colour
       mf_bg: int16;            -- Pointer colour
       mf_mask: aliased short_array(0..15);       -- Mask form
       mf_data: aliased short_array(0..15);       -- Pointer form
    end record;
    pragma Convention (C, MFORM);
    type MFORM_ptr is access all MFORM;
    type MFORM_const_ptr is access constant MFORM;

    type Rectangle is
        record
            g_x: aliased int16;
            g_y: aliased int16;
            g_w: aliased int16;
            g_h: aliased int16;
        end record;
    type Rectangle_ptr is access all Rectangle;


    aes_global: aliased AESglobal;

    -- FIXME: how to make private to sub-packages?
    aes_control: aliased AESContrl;
    aes_intin: aliased AESIntIn;
    aes_intout: aliased AESIntOut;
    aes_addrin: aliased AESAddrIn;
    aes_addrout: aliased AESAddrOut;

    procedure crystal(pb: AESPB_ptr) with Inline;
    procedure aes_trap with Inline;

    function vq_aes return int16;
    function vq_aes return boolean;


    --  old C-style names
	subtype GRECT is Rectangle;



    procedure rc_copy(src: in Rectangle; dst: out Rectangle) with Inline;

    function rc_equal(r1: in Rectangle; r2: in Rectangle) return boolean;

    function rc_intersect(src: in Rectangle; dst: in out Rectangle) return boolean;

    procedure array_to_grect(c_array: short_array; area: out Rectangle);

    procedure grect_to_array(area: in Rectangle; c_array: out short_array);

end Atari.Aes;
