with Atari.Aes.Wdialog;
with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Pdlg is

    type PRN_DIALOG is record null; end record;
    type PRN_DIALOG_ptr is access all PRN_DIALOG;

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

    CC_MONO                  : constant  := 16#1#;              -- *< 2 Graut馬e
    CC_4_GREY                : constant  := 16#2#;              -- *< 4 Graut馬e
    CC_8_GREY                : constant  := 16#4#;              -- *< 8 Graut馬e
    CC_16_GREY               : constant  := 16#8#;              -- *< 16 Graut馬e
    CC_256_GREY              : constant  := 16#10#;             -- *< 256 Graut馬e
    CC_32K_GREY              : constant  := 16#20#;             -- *< 32768 Farben in Graut馬e wandeln
    CC_65K_GREY              : constant  := 16#40#;             -- *< 65536 Farben in Graut馬e wandeln
    CC_16M_GREY              : constant  := 16#80#;             -- *< 16777216 Farben in Graut馬e wandeln
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
    MC_CTRST_BRGHT           : constant  := 16#800#;            -- *< Treiber kann Kontrast und Helligkeit ver�ndern

    PLANE_BLACK              : constant  := 16#1#;
    PLANE_YELLOW             : constant  := 16#2#;
    PLANE_MAGENTA            : constant  := 16#4#;
    PLANE_CYAN               : constant  := 16#8#;
    PLANE_MASK               : constant  := 16#f#;

    DM_BG_PRINTING           : constant  := 16#1#;              -- *< Flag f〉 Hintergrunddruck

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

    PDLG_CANCEL              : constant  := 1;                  -- *< "Abbruch" wurde angew�hlt
    PDLG_OK                  : constant  := 2;                  -- *< "OK" wurde gedr…kt

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
            name   : aliased char_array(0..31);
        end record;

    type MEDIA_TYPE;
    type MEDIA_TYPE_ptr is access all MEDIA_TYPE;
    type MEDIA_TYPE is
        record
            next   : aliased MEDIA_TYPE_ptr;
            type_id: aliased int32;
            name   : aliased char_array(0..31);
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
            name              : aliased char_array(0..31);
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
            name       : aliased char_array(0..31);
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
            name                : aliased char_array(0..31);
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
            device      : aliased char_array(0..127);
            -- mac_settings: aliased struct_anonymous9_t;
        end record;

    type PDLG_SUB is
        record
            next        : aliased PDLG_SUB_ptr;
            length      : aliased int32;
            format      : aliased int32;
            reserved    : aliased int32;
            drivers     : aliased void_ptr;
            option_flags: aliased int16;
            sub_id      : aliased int16;
            dialog      : aliased Wdialog.DIALOG_ptr;
            tree        : aliased Objects.Object_Ptr;
            index_offset: aliased int16;
            reserved1   : aliased int16;
            reserved2   : aliased int32;
            reserved3   : aliased int32;
            reserved4   : aliased int32;
            init_dlg    : aliased PDLG_INIT;
            do_dlg      : aliased PDLG_HNDL;
            reset_dlg   : aliased PDLG_RESET;
            reserved5   : aliased int32;
            sub_icon    : aliased Objects.Object_Ptr;
            sub_tree    : aliased Objects.Object_Ptr;
            reserved6   : aliased int32;
            reserved7   : aliased int32;
            private1    : aliased int32;
            private2    : aliased int32;
            private3    : aliased int32;
            private4    : aliased int32;
        end record;

    function pdlg_create(dialog_flags: int16) return PRN_DIALOG_ptr;
    function Create(dialog_flags: int16) return PRN_DIALOG_ptr renames pdlg_create;

    procedure pdlg_delete(prn_dialog: PRN_DIALOG_ptr);
    procedure Delete(prn_dialog: PRN_DIALOG_ptr) renames pdlg_delete;

    function pdlg_open(
                prn_dialog   : PRN_DIALOG_ptr;
                settings     : PRN_SETTINGS_ptr;
                document_name: in String;
                option_flags : int16;
                x            : int16;
                y            : int16)
               return int16;
    function Open(
                prn_dialog   : PRN_DIALOG_ptr;
                settings     : PRN_SETTINGS_ptr;
                document_name: in String;
                option_flags : int16;
                x            : int16;
                y            : int16)
               return int16 renames pdlg_open;

    procedure pdlg_close(
                prn_dialog: PRN_DIALOG_ptr;
                x         : out int16;
                y         : out int16);
    procedure Close(
                prn_dialog: PRN_DIALOG_ptr;
                x         : out int16;
                y         : out int16) renames pdlg_close;

    function pdlg_get_setsize return int32;
    function Get_Setsize return int32 renames pdlg_get_setsize;

    function pdlg_add_printers(
                prn_dialog: PRN_DIALOG_ptr;
                drv_info  : DRV_INFO_ptr)
               return boolean;
    function Add_printers(
                prn_dialog: PRN_DIALOG_ptr;
                drv_info  : DRV_INFO_ptr)
               return boolean renames pdlg_add_printers;

    procedure pdlg_remove_printers(prn_dialog: PRN_DIALOG_ptr);
    procedure Remove_Printers(prn_dialog: PRN_DIALOG_ptr) renames pdlg_remove_printers;

    function pdlg_update(
                prn_dialog   : PRN_DIALOG_ptr;
                document_name: in String)
               return boolean;
    function Update(
                prn_dialog   : PRN_DIALOG_ptr;
                document_name: in String)
               return boolean renames pdlg_update;

    function pdlg_add_sub_dialogs(
                prn_dialog : PRN_DIALOG_ptr;
                sub_dialogs: PDLG_SUB_ptr)
               return boolean;
    function Add_Sub_Dialogs(
                prn_dialog : PRN_DIALOG_ptr;
                sub_dialogs: PDLG_SUB_ptr)
               return boolean renames pdlg_add_sub_dialogs;

    procedure pdlg_remove_sub_dialogs(prn_dialog: PRN_DIALOG_ptr);
    procedure Remove_Sub_Dialogs(prn_dialog: PRN_DIALOG_ptr) renames pdlg_remove_sub_dialogs;

    function pdlg_new_settings(prn_dialog: PRN_DIALOG_ptr) return PRN_SETTINGS_ptr;
    function New_Settings(prn_dialog: PRN_DIALOG_ptr) return PRN_SETTINGS_ptr renames pdlg_new_settings;

    function pdlg_free_settings(settings: PRN_SETTINGS_ptr) return boolean;
    function Free_Settings(settings: PRN_SETTINGS_ptr) return boolean renames pdlg_free_settings;

    procedure pdlg_dflt_settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr);
    procedure Default_Settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr) renames pdlg_dflt_settings;

    function pdlg_validate_settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr)
               return boolean;
    function Validate_Settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr)
               return boolean renames pdlg_validate_settings;

    function pdlg_use_settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr)
               return boolean;
    function Use_Settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr)
               return boolean renames pdlg_use_settings;

    function pdlg_save_default_settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr)
               return boolean;
    function Save_Default_Settings(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr)
               return boolean renames pdlg_save_default_settings;

    function pdlg_evnt(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr;
                events    : Wdialog.EVNT_ptr;
                button    : out int16)
               return boolean;
    function Event(
                prn_dialog: PRN_DIALOG_ptr;
                settings  : PRN_SETTINGS_ptr;
                events    : Wdialog.EVNT_ptr;
                button    : out int16)
               return boolean renames pdlg_evnt;

    function pdlg_do(
                prn_dialog   : PRN_DIALOG_ptr;
                settings     : PRN_SETTINGS_ptr;
                document_name: in String;
                option_flags : int16)
               return int16;
    function Run(
                prn_dialog   : PRN_DIALOG_ptr;
                settings     : PRN_SETTINGS_ptr;
                document_name: in String;
                option_flags : int16)
               return int16 renames pdlg_do;

end Atari.Aes.Pdlg;
