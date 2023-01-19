package Atari.Aes.Extensions is

pragma Elaborate_Body;


    FNTS_BTMP                : constant  := 1;                  -- *< Display bitmap fonts
    FNTS_OUTL                : constant  := 2;                  -- *< Display vector fonts
    FNTS_MONO                : constant  := 4;                  -- *< Display mono-spaced fonts
    FNTS_PROP                : constant  := 8;                  -- *< Display proportional fonts

    FNTS_3D                  : constant  := 1;                  -- *< Display selector in 3D-look
    FNTS_DISPLAY             : constant  := 2;

    FNTS_SNAME               : constant  := 16#1#;              -- *< Select checkbox for names
    FNTS_SSTYLE              : constant  := 16#2#;              -- *< Select checkbox for style
    FNTS_SSIZE               : constant  := 16#4#;              -- *< Select checkbox for height
    FNTS_SRATIO              : constant  := 16#8#;              -- *< Select checkbox for width/height ratio
    FNTS_CHNAME              : constant  := 16#100#;            -- *< Display checkbox for names
    FNTS_CHSTYLE             : constant  := 16#200#;            -- *< Display checkbox for style
    FNTS_CHSIZE              : constant  := 16#400#;            -- *< Display checkbox for height
    FNTS_CHRATIO             : constant  := 16#800#;            -- *< Display checkbox for width/height ratio
    FNTS_RATIO               : constant  := 16#1000#;           -- *< Width/height ratio adjustable
    FNTS_BSET                : constant  := 16#2000#;           -- *< Button "Set" selectable
    FNTS_BMARK               : constant  := 16#4000#;           -- *< Button "Mark" selectable

    FNTS_CANCEL              : constant  := 1;
    FNTS_OK                  : constant  := 2;
    FNTS_SET                 : constant  := 3;
    FNTS_MARK                : constant  := 4;
    FNTS_OPT                 : constant  := 5;
    FNTS_OPTION              : constant  := FNTS_OPT;

    SORTBYNAME               : constant  := 0;
    SORTBYDATE               : constant  := 1;
    SORTBYSIZE               : constant  := 2;
    SORTBYTYPE               : constant  := 3;
    SORTBYNONE               : constant  := 4;
    SORTDEFAULT              : constant  := -1;

    DOSMODE                  : constant  := 1;
    NFOLLOWSLKS              : constant  := 2;
    GETMULTI                 : constant  := 8;

    SHOW8P3                  : constant  := 1;

    PRN_STD_SUBS             : constant  := 16#1#;              -- *< standard sub-dialogs for NVDI printer
    PRN_FSM_SUBS             : constant  := 16#2#;              -- *< standard sub-dialogs for FSM printer
    PRN_QD_SUBS              : constant  := 16#4#;              -- *< standard sub-dialogs for QuickDraw printer

    PDLG_CHG_SUB             : constant  := 16#80000000#;
    PDLG_IS_BUTTON           : constant  := 16#40000000#;
    PDLG_PREBUTTON           : constant  := 16#20000000#;

    PDLG_PB_OK               : constant  := 1;
    PDLG_PB_CANCEL           : constant  := 2;
    PDLG_PB_DEVICE           : constant  := 3;
    PDLG_BUT_OK              : constant  := PDLG_PREBUTTON + PDLG_PB_OK;
    PDLG_BUT_CNCL            : constant  := PDLG_PREBUTTON + PDLG_PB_CANCEL;
    PDLG_BUT_DEV             : constant  := PDLG_PREBUTTON + PDLG_PB_DEVICE;

    CC_MONO                  : constant  := 16#1#;              -- *< 2 Graut”ne
    CC_4_GREY                : constant  := 16#2#;              -- *< 4 Graut”ne
    CC_8_GREY                : constant  := 16#4#;              -- *< 8 Graut”ne
    CC_16_GREY               : constant  := 16#8#;              -- *< 16 Graut”ne
    CC_256_GREY              : constant  := 16#10#;             -- *< 256 Graut”ne
    CC_32K_GREY              : constant  := 16#20#;             -- *< 32768 Farben in Graut”ne wandeln
    CC_65K_GREY              : constant  := 16#40#;             -- *< 65536 Farben in Graut”ne wandeln
    CC_16M_GREY              : constant  := 16#80#;             -- *< 16777216 Farben in Graut”ne wandeln
    CC_2_COLOR               : constant  := 16#100#;            -- *< 2 Farben
    CC_4_COLOR               : constant  := 16#200#;            -- *< 4 Farben
    CC_8_COLOR               : constant  := 16#400#;            -- *< 8 Farben
    CC_16_COLOR              : constant  := 16#800#;            -- *< 16 Farben
    CC_256_COLOR             : constant  := 16#1000#;           -- *< 256 Farben
    CC_32K_COLOR             : constant  := 16#2000#;           -- *< 32768 Farben
    CC_65K_COLOR             : constant  := 16#4000#;           -- *< 65536 Farben
    CC_16M_COLOR             : constant  := 16#8000#;           -- *< 16777216 Farben

    NO_CC_BITS               : constant  := 16;

    DC_NONE                  : constant  := 0;                  -- *< keine Rasterverfahren
    DC_FLOYD                 : constant  := 1;                  -- *< einfacher Floyd-Steinberg
    NO_DC_BITS               : constant  := 1;

    PDLG_OUTFILES            : constant  := 5;

    PC_FILE                  : constant  := 16#1#;              -- *< printer can be accessed with GEMDOS calls
    PC_SERIAL                : constant  := 16#2#;              -- *< printer can be attached to serial interface
    PC_PARALLEL              : constant  := 16#4#;              -- *< printer can be attached to parallel interface
    PC_ACSI                  : constant  := 16#8#;              -- *< printer can be attached to ACSI interface
    PC_SCSI                  : constant  := 16#10#;             -- *< printer can be attached to SCSI interface
    PC_BACKGROUND            : constant  := 16#80#;             -- *< driver can do background jobs
    PC_SCALING               : constant  := 16#100#;            -- *< driver can scale pages
    PC_COPIES                : constant  := 16#200#;            -- *< driver can copy pages

    MC_PORTRAIT              : constant  := 16#1#;              -- *< Seite kann im Hochformat ausgegeben werden
    MC_LANDSCAPE             : constant  := 16#2#;              -- *< Seite kann im Querformat ausgegeben werden
    MC_REV_PTRT              : constant  := 16#4#;              -- *< Seite kann um 180 Grad gedreht im Hochformat ausgegeben werden
    MC_REV_LNDSCP            : constant  := 16#8#;              -- *< Seite kann um 180 Grad gedreht im Querformat ausgegeben werden
    MC_ORIENTATION           : constant  := 16#f#;
    MC_SLCT_CMYK             : constant  := 16#400#;            -- *< Treiber kann bestimmte Farbebenen ausgeben
    MC_CTRST_BRGHT           : constant  := 16#800#;            -- *< Treiber kann Kontrast und Helligkeit ver„ndern

    PLANE_BLACK              : constant  := 16#1#;
    PLANE_YELLOW             : constant  := 16#2#;
    PLANE_MAGENTA            : constant  := 16#4#;
    PLANE_CYAN               : constant  := 16#8#;
    PLANE_MASK               : constant  := 16#f#;

    DM_BG_PRINTING           : constant  := 16#1#;              -- *< Flag fr Hintergrunddruck

    PG_EVEN_PAGES            : constant  := 16#1#;              -- *< Only output pages with even page numbers
    PG_ODD_PAGES             : constant  := 16#2#;              -- *< Only output pages with odd page numbers

    PG_MIN_PAGE              : constant  := 1;
    PG_MAX_PAGE              : constant  := 9999;

    PG_UNKNOWN               : constant  := 16#0#;              -- *< Orientation unknown and not adjustable
    PG_PORTRAIT              : constant  := 16#1#;              -- *< Output page in portrait format
    PG_LANDSCAPE             : constant  := 16#2#;              -- *< Output page in landscape format

    PDLG_3D                  : constant  := 16#1#;              -- *< Use 3D-look

    PDLG_PREFS               : constant  := 16#0#;              -- *< Display settings dialog
    PDLG_PRINT               : constant  := 16#1#;              -- *< Display print dialog
    PDLG_ALWAYS_COPIES       : constant  := 16#10#;             -- *< Always offer No. of copies
    PDLG_ALWAYS_ORIENT       : constant  := 16#20#;             -- *< Always offer landscape format
    PDLG_ALWAYS_SCALE        : constant  := 16#40#;             -- *< Always offer scaling
    PDLG_EVENODD             : constant  := 16#100#;            -- *< Offer option for even and odd pages

    PDLG_CANCEL              : constant  := 1;                  -- *< "Abbruch" wurde angew„hlt
    PDLG_OK                  : constant  := 2;                  -- *< "OK" wurde gedrckt

    LBOX_VERT                : constant  := 1;                  -- *< Listbox with vertical slider
    LBOX_AUTO                : constant  := 2;                  -- *< Auto-scrolling
    LBOX_AUTOSLCT            : constant  := 4;                  -- *< Automatic display during auto-scrolling
    LBOX_REAL                : constant  := 8;                  -- *< Real-time slider
    LBOX_SNGL                : constant  := 16;                 -- *< Only a selectable entry
    LBOX_SHFT                : constant  := 32;                 -- *< Multi-selection with Shift
    LBOX_TOGGLE              : constant  := 64;                 -- *< Toggle status of an entry at selection
    LBOX_2SLDRS              : constant  := 128;                -- *< Listbox has a horiz. and a vertical slider

    WDLG_BKGD                : constant  := 1;                  -- *< Permit background operation

    HNDL_INIT                : constant  := -1;                 -- *< Initialise dialog
    HNDL_MESG                : constant  := -2;                 -- *< Handle message
    HNDL_CLSD                : constant  := -3;                 -- *< Dialog window was closed
    HNDL_OPEN                : constant  := -5;                 -- *< End of dialog initialisation (second  call at end of wdlg_init)
    HNDL_EDIT                : constant  := -6;                 -- *< Test characters for an edit-field
    HNDL_EDDN                : constant  := -7;                 -- *< Character was entered in edit-field
    HNDL_EDCH                : constant  := -8;                 -- *< Edit-field was changed
    HNDL_MOVE                : constant  := -9;                 -- *< Dialog was moved
    HNDL_TOPW                : constant  := -10;                -- *< Dialog-window has been topped
    HNDL_UNTP                : constant  := -11;                -- *< Dialog-window is not active

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

    type XEDITINFO is private;
    type XEDITINFO_ptr is access all XEDITINFO;
    
    type ITAB_REF is new System.Address;

    type long_array is array(Integer range <>) of aliased int32;

    type DIALOG is tagged record null; end record;
    type DIALOG_ptr is access all DIALOG;

    type PRN_DIALOG is new DIALOG with record null; end record;
    type PRN_DIALOG_ptr is access all PRN_DIALOG;

	type XFSL_DIALOG is new DIALOG with record null; end record;
    type XFSL_DIALOG_ptr is access all XFSL_DIALOG;

    type EVNT is
        record
            mwhich  : aliased int16;
            mx      : aliased int16;
            my      : aliased int16;
            mbutton : aliased int16;
            kstate  : aliased int16;
            key     : aliased int16;
            mclicks : aliased int16;
            reserved: aliased short_array(0..8);
            msg     : aliased short_array(0..15);
        end record;
    type EVNT_ptr is access all EVNT;


    type SCANX is
        record
            scancode: aliased uint8;
            nclicks : aliased uint8;
            objnr   : aliased int16;
        end record;
    type SCANX_ptr is access all SCANX;


    type UTXT_FN_args is
        record
            x        : aliased int16;
            y        : aliased int16;
            clip_rect: aliased short_ptr;
            id       : aliased int32;
            pt       : aliased int32;
            ratio    : aliased int32;
            string   : aliased chars_ptr;
        end record;

    type UTXT_FN is access procedure(
                p1: UTXT_FN_args)
    with Convention => C;

    type XFSL_FILTER is access function(
                path : chars_ptr;
                name : chars_ptr;
                xattr: System.Address)
               return int16
    with Convention => C;

    type PRN_TRAY;
    type PRN_TRAY_ptr is access all PRN_TRAY;
    type PRN_TRAY is
        record
            next   : aliased PRN_TRAY_ptr;
            tray_id: aliased int32;
            name   : aliased char_array(0..31);
        end record;

    type MEDIA_SIZE;
    type MEDIA_SIZE_ptr is access all MEDIA_SIZE;
    type MEDIA_SIZE is
        record
            next   : aliased MEDIA_SIZE_ptr;
            size_id: aliased int32;
            name_c0: aliased char_array(0..31);
        end record;

    type MEDIA_TYPE;
    type MEDIA_TYPE_ptr is access all MEDIA_TYPE;
    type MEDIA_TYPE is
        record
            next   : aliased MEDIA_TYPE_ptr;
            type_id: aliased int32;
            name_c1: aliased char_array(0..31);
        end record;

    type PRN_MODE;
    type PRN_MODE_ptr is access all PRN_MODE;
    type PRN_MODE is
        record
            next              : aliased PRN_MODE_ptr;
            mode_id           : aliased int32;
            hdpi              : aliased int16;
            vdpi              : aliased int16;
            mode_capabilities : aliased int32;
            color_capabilities: aliased int32;
            dither_flags      : aliased int32;
            paper_types       : aliased MEDIA_TYPE_ptr;
            reserved          : aliased int32;
            name_c2           : aliased char_array(0..31);
        end record;

    type DITHER_MODE;
    type DITHER_MODE_ptr is access all DITHER_MODE;
    type DITHER_MODE is
        record
            next       : aliased DITHER_MODE_ptr;
            length     : aliased int32;
            format     : aliased int32;
            reserved   : aliased int32;
            dither_id  : aliased int32;
            color_modes: aliased int32;
            reserved1  : aliased int32;
            reserved2  : aliased int32;
            name_c4    : aliased char_array(0..31);
        end record;

    type DRV_ENTRY;
    type DRV_ENTRY_ptr is access all DRV_ENTRY;
    type DRV_ENTRY is
        record
            next: aliased DRV_ENTRY_ptr;
        end record;


    type PRN_SETTINGS;
    type PRN_SETTINGS_ptr is access all PRN_SETTINGS;
    type PRN_ENTRY;
    type PRN_ENTRY_ptr is access all PRN_ENTRY;

    type PRN_SWITCH is access function(
                drivers    : access DRV_ENTRY;
                settings   : access PRN_SETTINGS;
                old_printer: PRN_ENTRY_ptr;
                new_printer: PRN_ENTRY_ptr)
               return int32
    with Convention => C;



    type DRV_INFO is
        record
            magic       : aliased int32;
            length      : aliased int32;
            format      : aliased int32;
            reserved    : aliased int32;
            driver_id   : aliased int16;
            driver_type : aliased int16;
            reserved1   : aliased int32;
            reserved2   : aliased int32;
            reserved3   : aliased int32;
            printers    : aliased PRN_ENTRY_ptr;
            dither_modes: aliased DITHER_MODE_ptr;
            reserved4   : aliased int32;
            reserved5   : aliased int32;
            reserved6   : aliased int32;
            reserved7   : aliased int32;
            reserved8   : aliased int32;
            reserved9   : aliased int32;
            device      : aliased char_array(0..127);
        end record;
    type DRV_INFO_ptr is access all DRV_INFO;


    type PDLG_SUB;
    type PDLG_SUB_ptr is access all PDLG_SUB;

    type PDLG_INIT is access function(
                settings: PRN_SETTINGS_ptr;
                sub     : PDLG_SUB_ptr)
               return int32
    with Convention => C;

    type PDLG_HNDL_args is
        record
            settings: aliased PRN_SETTINGS_ptr;
            sub     : aliased PDLG_SUB_ptr;
            exit_obj: aliased int16;
        end record;

    type PDLG_HNDL is access function(p1: PDLG_HNDL_args) return int32
    with Convention => C;

    type PDLG_RESET is access function(settings: PRN_SETTINGS_ptr; sub: PDLG_SUB_ptr) return int32
    with Convention => C;


    type LIST_BOX is
        record
            inside: aliased char_array(0..119);
        end record;
    type LIST_BOX_ptr is access all LIST_BOX;

    type XFNT_INFO is
        record
            size       : aliased int32;
            format     : aliased int16;
            id         : aliased int16;
            index      : aliased int16;
            font_name  : aliased char_array(0..49);
            family_name: aliased char_array(0..49);
            style_name : aliased char_array(0..49);
            file_name1 : aliased char_array(0..199);
            file_name2 : aliased char_array(0..199);
            file_name3 : aliased char_array(0..199);
            pt_cnt     : aliased int16;
            pt_sizes   : aliased short_array(0..63);
        end record;
    type XFNT_INFO_ptr is access all XFNT_INFO;


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


    type RECT16 is
        record
            x1: aliased int16;
            y1: aliased int16;
            x2: aliased int16;
            y2: aliased int16;
        end record;


    type RECT32 is
        record
            x1: aliased int32;
            y1: aliased int32;
            x2: aliased int32;
            y2: aliased int32;
        end record;


    type BIT_IMAGE is
        record
            nbplanes: aliased int16;
            width   : aliased int16;
            height  : aliased int16;
        end record;


    type PRN_ENTRY is
        record
            next                : aliased PRN_ENTRY_ptr;
            length              : aliased int32;
            format              : aliased int32;
            reserved            : aliased int32;
            driver_id           : aliased int16;
            driver_type         : aliased int16;
            printer_id          : aliased int32;
            printer_capabilities: aliased int32;
            reserved1           : aliased int32;
            sub_flags           : aliased int32;
            sub_dialogs         : aliased PDLG_SUB_ptr;
            setup_panel         : aliased PRN_SWITCH;
            close_panel         : aliased PRN_SWITCH;
            modes               : aliased PRN_MODE_ptr;
            papers              : aliased MEDIA_SIZE_ptr;
            input_trays         : aliased PRN_TRAY_ptr;
            output_trays        : aliased PRN_TRAY_ptr;
            name_c3             : aliased char_array(0..31);
        end record;

    type PRN_SETTINGS is
        record
            magic       : aliased int32;
            length      : aliased int32;
            format      : aliased int32;
            reserved    : aliased int32;
            page_flags  : aliased int32;
            first_page  : aliased int16;
            last_page   : aliased int16;
            no_copies   : aliased int16;
            orientation : aliased int16;
            scale       : aliased int32;
            driver_id   : aliased int16;
            driver_type : aliased int16;
            driver_mode : aliased int32;
            reserved1   : aliased int32;
            reserved2   : aliased int32;
            printer_id  : aliased int32;
            mode_id     : aliased int32;
            mode_hdpi   : aliased int16;
            mode_vdpi   : aliased int16;
            quality_id  : aliased int32;
            color_mode  : aliased int32;
            plane_flags : aliased int32;
            dither_mode : aliased int32;
            dither_value: aliased int32;
            size_id     : aliased int32;
            type_id     : aliased int32;
            input_id    : aliased int32;
            output_id   : aliased int32;
            contrast    : aliased int32;
            brightness  : aliased int32;
            reserved3   : aliased int32;
            reserved4   : aliased int32;
            reserved5   : aliased int32;
            reserved6   : aliased int32;
            reserved7   : aliased int32;
            reserved8   : aliased int32;
            device_c0   : aliased char_array(0..127);
            -- mac_settings: aliased struct_anonymous9_t;
        end record;

    type XDO_INF is
        record
            unsh : aliased SCANX_ptr;
            shift: aliased SCANX_ptr;
            ctrl : aliased SCANX_ptr;
            alt  : aliased SCANX_ptr;
            resvd: aliased System.Address;
        end record;
    type XDO_INF_ptr is access all XDO_INF;


    type FNTS_ITEM;
    type FNTS_ITEM_ptr is access all FNTS_ITEM;
    type FNTS_ITEM is
        record
            next       : aliased FNTS_ITEM_ptr;
            display    : aliased UTXT_FN;
            id         : aliased int32;
            index      : aliased int16;
            mono       : aliased int8;
            outline    : aliased int8;
            npts       : aliased int16;
            full_name  : aliased chars_ptr;
            family_name: aliased chars_ptr;
            style_name : aliased chars_ptr;
            pts        : aliased chars_ptr;
            reserved_c0: aliased long_array(0..3);
        end record;

    type PDLG_SUB is
        record
            next        : aliased PDLG_SUB_ptr;
            length      : aliased int32;
            format      : aliased int32;
            reserved    : aliased int32;
            drivers     : aliased System.Address;
            option_flags: aliased int16;
            sub_id      : aliased int16;
            dialog      : aliased DIALOG_ptr;
            tree        : aliased OBJECT_ptr;
            index_offset: aliased int16;
            reserved1   : aliased int16;
            reserved2   : aliased int32;
            reserved3   : aliased int32;
            reserved4   : aliased int32;
            init_dlg    : aliased PDLG_INIT;
            do_dlg      : aliased PDLG_HNDL;
            reset_dlg   : aliased PDLG_RESET;
            reserved5   : aliased int32;
            sub_icon    : aliased OBJECT_ptr;
            sub_tree    : aliased OBJECT_ptr;
            reserved6   : aliased int32;
            reserved7   : aliased int32;
            private1    : aliased int32;
            private2    : aliased int32;
            private3    : aliased int32;
            private4    : aliased int32;
        end record;

    type LBOX_ITEM;
    type LBOX_ITEM_ptr is access all LBOX_ITEM;
    type LBOX_ITEM is
        record
            next    : aliased LBOX_ITEM_ptr;
            selected: aliased int16;
            data1   : aliased int16;
            data2   : aliased System.Address;
            data3   : aliased System.Address;
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


	procedure objc_wdraw(
	            tree   : OBJECT_ptr;
	            start  : int16;
	            depth  : int16;
	            clip   : in GRECT;
	            whandle: int16);

    procedure objc_wchange(
                tree     : OBJECT_ptr;
                obj      : int16;
                new_state: int16;
                clip     : access GRECT;
                whandle  : int16);

    function graf_wwatchbox(
                tree      : OBJECT_ptr;
                Obj       : int16;
                InState   : int16;
                OutState  : int16;
                whandle   : int16)
               return int16;

    function form_wbutton(
                tree      : OBJECT_ptr;
                fo_bobject: int16;
                fo_bclicks: int16;
                fo_bnxtobj: out int16;
                whandle   : int16)
               return int16;

    function form_wkeybd(
                tree         : OBJECT_ptr;
                fo_kobject   : int16;
                fo_kobnext   : int16;
                fo_kchar     : int16;
                fo_knxtobject: out int16;
                fo_knxtchar  : out int16;
                whandle      : int16)
               return int16;

	function objc_wedit(
	            tree   : OBJECT_ptr;
	            obj    : int16;
	            key    : int16;
	            idx    : in out int16;
	            kind   : int16;
	            whandle: int16)
	           return int16;

    function objc_xedit(
                tree  : OBJECT_ptr;
                obj   : int16;
                key   : int16;
                xpos  : in out int16;
                subfn : int16;
                r     : in GRECT)
               return int16;

    function form_popup(
                tree  : OBJECT_ptr;
                x     : int16;
                y     : int16)
               return int16;

    type POPUP_INIT_args is
        record
            tree     : aliased OBJECT_ptr;
            scrollpos: aliased int16;
            nlines   : aliased int16;
            param    : aliased System.Address;
        end record;

    type init_proc_ptr is access procedure(p1: POPUP_INIT_args);
    pragma Convention(C, init_proc_ptr);

    function xfrm_popup(
                tree       : OBJECT_ptr;
                x          : int16;
                y          : int16;
                firstscrlob: int16;
                lastscrlob : int16;
                nlines     : int16;
                init       : init_proc_ptr;
                param      : System.Address;
                lastscrlpos: in out int16)
               return int16;

    function form_xdo(
                tree    : OBJECT_ptr;
                startob : int16;
                lastcrsr: out int16;
                tabs    : XDO_INF_ptr;
                flydial : void_ptr_ptr)
               return int16;

    function form_xdial(
                fo_diflag  : int16;
                fo_dilittlx: int16;
                fo_dilittly: int16;
                fo_dilittlw: int16;
                fo_dilittlh: int16;
                fo_dibigx  : int16;
                fo_dibigy  : int16;
                fo_dibigw  : int16;
                fo_dibigh  : int16;
                flydial    : void_ptr_ptr)
               return int16;

    function form_xdial(
                fo_diflag : int16;
                fo_dilittl: in GRECT;
                fo_dibig  : in GRECT;
                flydial   : void_ptr_ptr)
               return int16;

    function appl_options(
                mode: int16;
                aopts0: int16;
                aopts1: int16;
                aopts2: int16;
                aopts3: int16;
                out0: out int16;
                out1: out int16;
                out2: out int16;
                out3: out int16)
               return int16;







private
	type XEDITINFO is record null; end record;

end Atari.Aes.Extensions;
