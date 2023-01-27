with Interfaces.C.Extensions;

package Atari.Aes.Objects is

    --  object flags
    OF_NONE              : constant  := 16#0#;
    OF_SELECTABLE        : constant  := 16#1#;
    OF_DEFAULT           : constant  := 16#2#;
    OF_EXIT              : constant  := 16#4#;
    OF_EDITABLE          : constant  := 16#8#;
    OF_RBUTTON           : constant  := 16#10#;
    OF_LASTOB            : constant  := 16#20#;
    OF_TOUCHEXIT         : constant  := 16#40#;
    OF_HIDETREE          : constant  := 16#80#;
    OF_INDIRECT          : constant  := 16#100#;
    OF_FL3DIND           : constant  := 16#200#;                -- bit 9
    OF_FL3DBAK           : constant  := 16#400#;                -- bit 10
    OF_FL3DACT           : constant  := 16#600#;
    OF_FL3DMASK          : constant  := 16#600#;
    OF_SUBMENU           : constant  := 16#800#;                -- bit 11
    OF_FLAG11            : constant  := 16#800#;
    OF_FLAG12            : constant  := 16#1000#;
    OF_FLAG13            : constant  := 16#2000#;
    OF_FLAG14            : constant  := 16#4000#;
    OF_FLAG15            : constant  := 16#8000#;

    --  object states
    OS_NORMAL            : constant  := 16#0#;
    OS_SELECTED          : constant  := 16#1#;
    OS_CROSSED           : constant  := 16#2#;
    OS_CHECKED           : constant  := 16#4#;
    OS_DISABLED          : constant  := 16#8#;
    OS_OUTLINED          : constant  := 16#10#;
    OS_SHADOWED          : constant  := 16#20#;
    OS_WHITEBAK          : constant  := 16#40#;
    OS_DRAW3D            : constant  := 16#80#;
    OS_STATE08           : constant  := 16#100#;
    OS_STATE09           : constant  := 16#200#;
    OS_STATE10           : constant  := 16#400#;
    OS_STATE11           : constant  := 16#800#;
    OS_STATE12           : constant  := 16#1000#;
    OS_STATE13           : constant  := 16#2000#;
    OS_STATE14           : constant  := 16#4000#;
    OS_STATE15           : constant  := 16#8000#;

    NO_DRAW              : constant  := 0;                      -- *< object will not be redrawn, see mt_objc_change()
    REDRAW               : constant  := 1;                      -- *< object will be redrawn, see mt_objc_change()

    OO_LAST              : constant  := -1;                     -- *< make object the last child, see mt_objc_order()
    OO_FIRST             : constant  := 0;                      -- *< make object the first child, see mt_objc_order()

    --  objc_sysvar modes
    SV_INQUIRE           : constant  := 0;                      -- *< inquire sysvar data, see mt_objc_sysvar()
    SV_SET               : constant  := 1;                      -- *< set sysvar data, see mt_objc_sysvar()

    --  the objc_sysvar ob_swhich values
    LK3DIND              : constant  := 1;                      -- *< text of indicator object moves when selected, see mt_objc_sysvar()
    LK3DACT              : constant  := 2;                      -- *< text of activator object moves when selected, see mt_objc_sysvar()
    INDBUTCOL            : constant  := 3;                      -- *< default color for indicator objects, see mt_objc_sysvar()
    ACTBUTCOL            : constant  := 4;                      -- *< default color for activator objects, see mt_objc_sysvar()
    BACKGRCOL            : constant  := 5;                      -- *< default color for background objects, see mt_objc_sysvar()
    AD3DVAL              : constant  := 6;                      -- *< number of extra pixels to accomodate 3D effects, see mt_objc_sysvar()
    MX_ENABLE3D          : constant  := 10;                     -- *< enable or disable the 3D look (MagiC 3), see mt_objc_sysvar()
    MENUCOL              : constant  := 11;                     -- *< TO BE COMPLETED (MagiC 6), see mt_objc_sysvar()

    type OBJC_COLORWORD is
        record
            borderc: Interfaces.C.Extensions.Unsigned_4;
            textc  : Interfaces.C.Extensions.Unsigned_4;
            opaque : Interfaces.C.Extensions.Unsigned_1;
            pattern: Interfaces.C.Extensions.Unsigned_3;
            fillc  : Interfaces.C.Extensions.Unsigned_4;
        end record;

    type OBJECT;
    type OBJECT_ptr is access all OBJECT;
    type OBJECT_ptr_ptr is access all OBJECT_ptr;

    type BFOBSPEC is
        record
            character  : Interfaces.C.Extensions.Unsigned_8;
            framesize  : Interfaces.C.signed_char;
            framecol   : Interfaces.C.Extensions.Unsigned_4;
            textcol    : Interfaces.C.Extensions.Unsigned_4;
            textmode   : Interfaces.C.Extensions.Unsigned_1;
            fillpattern: Interfaces.C.Extensions.Unsigned_3;
            interiorcol: Interfaces.C.Extensions.Unsigned_4;
        end record
        with Pack => True, Alignment => 2;


    type PARMBLK is
        record
            pb_tree     : aliased OBJECT_ptr;
            pb_obj      : aliased int16;
            pb_prevstate: aliased int16;
            pb_currstate: aliased int16;
            pb_x        : aliased int16;
            pb_y        : aliased int16;
            pb_w        : aliased int16;
            pb_h        : aliased int16;
            pb_xc       : aliased int16;
            pb_yc       : aliased int16;
            pb_wc       : aliased int16;
            pb_hc       : aliased int16;
            pb_parm     : aliased intptr;
        end record;
	type PARMBLK_ptr is access all PARMBLK;

    type ub_code_func_ptr is access function(
               parmblock: PARMBLK_ptr)
               return int16;
    pragma Convention(C, ub_code_func_ptr);

    type USERBLK is
        record
            ub_code: aliased ub_code_func_ptr;
            ub_parm: aliased intptr;
        end record;
    type USERBLK_ptr is access all USERBLK;

    type TEDINFO is
        record
            te_ptext    : aliased chars_ptr;
            te_ptmplt   : aliased chars_ptr;
            te_pvalid   : aliased chars_ptr;
            te_font     : aliased int16;
            te_fontid   : aliased int16;
            te_just     : aliased int16;
            te_color    : aliased int16;
            te_fontsize : aliased int16;
            te_thickness: aliased int16;
            te_txtlen   : aliased int16;
            te_tmplen   : aliased int16;
        end record;
    type TEDINFO_ptr is access all TEDINFO;

    type BITBLK is
        record
            bi_pdata: aliased void_ptr;
            bi_wb   : aliased int16;
            bi_hl   : aliased int16;
            bi_x    : aliased int16;
            bi_y    : aliased int16;
            bi_color: aliased int16;
        end record;
    type BITBLK_ptr is access all BITBLK;


    type ICONBLK is
        record
            ib_pmask: aliased void_ptr;
            ib_pdata: aliased void_ptr;
            ib_ptext: aliased chars_ptr;
            ib_char : aliased int16;
            ib_xchar: aliased int16;
            ib_ychar: aliased int16;
            ib_xicon: aliased int16;
            ib_yicon: aliased int16;
            ib_wicon: aliased int16;
            ib_hicon: aliased int16;
            ib_xtext: aliased int16;
            ib_ytext: aliased int16;
            ib_wtext: aliased int16;
            ib_htext: aliased int16;
        end record;
    type ICONBLK_ptr is access all ICONBLK;


    type CICON;
    type CICON_ptr is access all CICON;
    type CICON is
        record
            num_planes: aliased int16;
            col_data  : aliased void_ptr;
            col_mask  : aliased void_ptr;
            sel_data  : aliased void_ptr;
            sel_mask  : aliased void_ptr;
            next_res  : aliased CICON_ptr;
        end record;

    type CICONBLK is
        record
            monoblk : aliased ICONBLK;
            mainlist: aliased CICON_ptr;
        end record;
    type CICONBLK_ptr is access all CICONBLK;


    type OBSPEC;
    type OBSPEC_ptr is access all OBSPEC;
    type OBSPEC (Which: int16 := 0) is
        record
            case Which is
                when OF_INDIRECT =>
                    indirect   : aliased OBSPEC_ptr;
                when G_BOX | G_IBOX | G_BOXCHAR =>
                    obspec     : aliased BFOBSPEC;
                when G_BOXTEXT | G_TEXT | G_FTEXT | G_FBOXTEXT =>
                    tedinfo    : aliased TEDINFO_ptr;
                when G_IMAGE =>
                    bitblk     : aliased BITBLK_ptr;
                when G_ICON =>
                    iconblk    : aliased ICONBLK_ptr;
                when G_CICON =>
                    ciconblk   : aliased CICONBLK_ptr;
                when G_USERDEF =>
                    userblk    : aliased USERBLK_ptr;
                when G_BUTTON | G_STRING | G_TITLE | G_SHORTCUT =>
                    free_string: aliased chars_ptr;
                when others =>
                    index      : aliased intptr;
            end case;
        end record;
    pragma Convention(C, OBSPEC);
    pragma Unchecked_Union(OBSPEC);


    type OBJECT is
        record
            ob_next  : aliased int16;
            ob_head  : aliased int16;
            ob_tail  : aliased int16;
            ob_type  : aliased uint16;
            ob_flags : aliased uint16;
            ob_state : aliased uint16;
            ob_spec  : OBSPEC;
            ob_x     : aliased int16;
            ob_y     : aliased int16;
            ob_width : aliased int16;
            ob_height: aliased int16;
        end record
        with Convention => C;
    type OBJECT_array is array(int16 range <>) of aliased OBJECT;
    subtype AEStree is OBJECT_array(0..2339);
    type AEStree_ptr is access all AEStree;
    type AEStree_ptr_ptr is access all AEStree_ptr;



    procedure Add(
                tree  : OBJECT_ptr;
                Parent: int16;
                Child : int16);

    function objc_delete(
                tree      : OBJECT_ptr;
                Obj       : int16)
               return int16;

    procedure objc_draw(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Cx        : int16;
                Cy        : int16;
                Cw        : int16;
                Ch        : int16);

    procedure objc_draw(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                r         : in GRECT);

    function objc_find(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Mx        : int16;
                My        : int16)
               return int16;

    procedure objc_offset(
                tree      : OBJECT_ptr;
                Obj       : int16;
                X         : out int16;
                Y         : out int16);

    function objc_order(
                tree      : OBJECT_ptr;
                Obj       : int16;
                NewPos    : int16)
               return int16;

    function objc_edit(
                tree      : OBJECT_ptr;
                Obj       : int16;
                Kchar     : int16;
                Index     : in out int16;
                Kind      : int16)
               return int16;

    function objc_edit(
                tree      : OBJECT_ptr;
                Obj       : int16;
                Kchar     : int16;
                Index     : in out int16;
                Kind      : int16;
                r         : out GRECT)
               return int16;

    procedure objc_change(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Cx        : int16;
                Cy        : int16;
                Cw        : int16;
                Ch        : int16;
                NewState  : int16;
                Redraw    : int16);

    procedure objc_change(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                r         : in GRECT;
                NewState  : int16;
                Redraw    : int16);

    function objc_sysvar(
                mode      : int16;
                which     : int16;
                in1       : int16;
                in2       : int16;
                out1      : out int16;
                out2      : out int16)
               return int16;

    function objc_xfind(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Mx        : int16;
                My        : int16)
               return int16;



    function Delete(
                tree      : OBJECT_ptr;
                Obj       : int16)
               return int16 renames objc_delete;

    procedure Draw(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Cx        : int16;
                Cy        : int16;
                Cw        : int16;
                Ch        : int16) renames objc_draw;

    procedure Draw(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                r         : in GRECT) renames objc_draw;

    function Find(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Mx        : int16;
                My        : int16)
               return int16 renames objc_find;

    procedure Offset(
                tree      : OBJECT_ptr;
                Obj       : int16;
                X         : out int16;
                Y         : out int16) renames objc_offset;

    function Order(
                tree      : OBJECT_ptr;
                Obj       : int16;
                NewPos    : int16)
               return int16 renames objc_order;

    function Edit(
                tree      : OBJECT_ptr;
                Obj       : int16;
                Kchar     : int16;
                Index     : in out int16;
                Kind      : int16)
               return int16 renames objc_edit;

    function Edit(
                tree      : OBJECT_ptr;
                Obj       : int16;
                Kchar     : int16;
                Index     : in out int16;
                Kind      : int16;
                r         : out GRECT)
               return int16 renames objc_edit;

    procedure Change(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Cx        : int16;
                Cy        : int16;
                Cw        : int16;
                Ch        : int16;
                NewState  : int16;
                Redraw    : int16) renames objc_change;

    procedure Change(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                r         : in GRECT;
                NewState  : int16;
                Redraw    : int16) renames objc_change;

    function Sysvar(
                mode      : int16;
                which     : int16;
                in1       : int16;
                in2       : int16;
                out1      : out int16;
                out2      : out int16)
               return int16 renames objc_sysvar;

    function Xfind(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Mx        : int16;
                My        : int16)
               return int16 renames objc_xfind;


    procedure objc_add(
                tree  : OBJECT_ptr;
                Parent: int16;
                Child : int16) renames Add;

end Atari.Aes.Objects;
