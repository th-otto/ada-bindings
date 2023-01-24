with Atari.Aes.Wdialog;
package Atari.Aes.Fontsel is

    type FNT_DIALOG is record null; end record;
    type FNT_DIALOG_ptr is access all FNT_DIALOG;

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

    type UTXT_FN is access procedure(p1: UTXT_FN_args)
    with Convention => C;

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

    function fnts_create(
                vdi_handle  : int16; -- VdiHdl
                no_fonts    : int16;
                font_flags  : int16;
                dialog_flags: int16;
                sample      : in String;
                opt_button  : in String)
               return FNT_DIALOG_ptr;

    function fnts_delete(
                fnt_dialog: FNT_DIALOG_ptr;
                vdi_handle: int16)
               return int16;

    function fnts_add(
                fnt_dialog: FNT_DIALOG_ptr;
                user_fonts: FNTS_ITEM_ptr)
               return int16;

    function fnts_open(
                fnt_dialog  : FNT_DIALOG_ptr;
                button_flags: int16;
                x           : int16;
                y           : int16;
                id          : int32;
                pt          : int32;
                ratio       : int32)
               return int16;

    function fnts_close(
                fnt_dialog: FNT_DIALOG_ptr;
                x         : out int16;
                y         : out int16)
               return int16;

    function fnts_get_no_styles(
                fnt_dialog: FNT_DIALOG_ptr;
                id        : int32)
               return int16;

    function fnts_get_style(
                fnt_dialog: FNT_DIALOG_ptr;
                id        : int32;
                index     : int16)
               return int32;

    function fnts_get_name(
                fnt_dialog : FNT_DIALOG_ptr;
                id         : int32;
                full_name  : out String;
                family_name: out String;
                style_name : out String)
               return boolean;

    function fnts_get_info(
                fnt_dialog: FNT_DIALOG_ptr;
                id        : int32;
                mono      : out boolean;
                outline   : out boolean)
               return int16;

    procedure fnts_remove(fnt_dialog: FNT_DIALOG_ptr);

    function fnts_update(
                fnt_dialog  : FNT_DIALOG_ptr;
                button_flags: int16;
                id          : int32;
                pt          : int32;
                ratio       : int32)
               return int16;

    function fnts_evnt(
                fnt_dialog : FNT_DIALOG_ptr;
                events     : Wdialog.EVNT_ptr;
                button     : out int16;
                check_boxes: out int16;
                id         : out int32;
                pt         : out int32;
                ratio      : out int32)
               return int16;

    function fnts_do(
                fnt_dialog  : FNT_DIALOG_ptr;
                button_flags: int16;
                id_in       : int32;
                pt_in       : int32;
                ratio_in    : int32;
                check_boxes : out int16;
                id          : out int32;
                pt          : out int32;
                ratio       : out int32)
               return int16;

end Atari.Aes.Fontsel;
