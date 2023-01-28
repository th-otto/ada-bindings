with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Menu is

    --  menu_attach modes
    ME_INQUIRE           : constant  := 0;                      -- *< inquire information on a sub-menu attached, see mt_menu_attach()
    ME_ATTACH            : constant  := 1;                      -- *< attach or change a sub-menu, see mt_menu_attach()
    ME_REMOVE            : constant  := 2;                      -- *< remove a sub-menu. see mt_menu_attach()

    --  menu_attach attributes
    SCROLL_NO            : constant  := 0;                      -- *< the menu will not scroll, see MENU::mn_scroll structure
    SCROLL_YES           : constant  := 1;                      -- *< menu may scroll if it is too high, see MENU::mn_scroll structure

    --  Menu definitions as used by menu_bar()
    MENU_INQUIRE         : constant  := -1;                     -- *< inquire the AES application ID of the process which own the displayed menu, see mt_menu_bar()
    MENU_REMOVE          : constant  := 0;                      -- *< remove a menu bar, see mt_menu_bar()
    MENU_INSTALL         : constant  := 1;                      -- *< install a menu bar, see mt_menu_bar()
    MENU_GETMODE         : constant  := 3;                      -- *< Get the menu bar mode, see mt_menu_bar()
    MENU_SETMODE         : constant  := 4;                      -- *< Set the menu bar mode, see mt_menu_bar()
    MENU_UPDATE          : constant  := 5;                      -- *< Update the system part of the menu bar, see mt_menu_bar()
    MENU_INSTL           : constant  := 100;                    -- *< Install a menu without switching the top application (Magic), see mt_menu_bar()
    MENU_HIDDEN          : constant  := 16#1#;                  -- *< menu bar only visible when needed, see #MENU_GETMODE or #MENU_SETMODE
    MENU_PULLDOWN        : constant  := 16#2#;                  -- *< Pulldown-Menus, see #MENU_GETMODE or #MENU_SETMODE
    MENU_SHADOWED        : constant  := 16#4#;                  -- *< menu bar with shadows, see #MENU_GETMODE or #MENU_SETMODE

    UNCHECK              : constant  := 0;                      -- *< remove the check mark of a menu item, see mt_menu_icheck()
    CHECK                : constant  := 1;                      -- *< set a check mark of a menu item, see mt_menu_icheck()

    DISABLE              : constant  := 0;                      -- *< disable a menu item, see mt_menu_ienable()
    ENABLE               : constant  := 1;                      -- *< enable a menu item, see mt_menu_ienable()

    MIS_GETALIGN         : constant  := 0;                      -- *< get the alignment of a parent menu item with a sub-menu item, see mt_menu_istart()
    MIS_SETALIGN         : constant  := 1;                      -- *< set the alignment of a parent menu item with a sub-menu item, see mt_menu_istart()

    --  menu_popup modes
    SCROLL_LISTBOX       : constant  := -1;                     -- *< display a drop-down list (with slider) instead of popup menu, see MENU::mn_scroll

    REG_NEWNAME          : constant  := -1;                     -- *< register your application with a new name, see mt_menu_register()

    MN_INQUIRE           : constant  := 0;                      -- *< inquire the current menu settings, see mt_menu_settings()
    MN_CHANGE            : constant  := 1;                      -- *< set the menu settings, see mt_menu_settings()

    HIGHLIGHT            : constant  := 0;                      -- *< display the title in reverse mode, see mt_menu_tnormal()
    UNHIGHLIGHT          : constant  := 1;                      -- *< display the title in normal mode, see mt_menu_tnormal()

    type AMENU is
        record
            mn_tree    : aliased Objects.OBJECT_ptr;
            mn_menu    : aliased int16;
            mn_item    : aliased int16;
            mn_scroll  : aliased int16;
            mn_keystate: aliased int16;
        end record;
    type AMENU_ptr is access all AMENU;

    type MN_SET is
        record
            display: aliased int32;
            drag   : aliased int32;
            c_delay: aliased int32;
            speed  : aliased int32;
            height : aliased int16;
        end record;


    function Bar(
                me_tree: in Objects.AEStree_ptr;
                me_mode: int16)
               return int16;

    function Icheck(
                me_tree : in Objects.AEStree_ptr;
                me_item : int16;
                me_check: int16)
               return int16;

    function Ienable(
                me_tree  : in Objects.Aestree_Ptr;
                me_item  : int16;
                me_enable: int16)
               return int16;

    function Tnormal(
                me_tree  : in Objects.Aestree_Ptr;
                me_item  : int16;
                me_normal: int16)
               return int16;

    function Text(
                me_tree: in Objects.Aestree_Ptr;
                me_item: int16;
                me_text: const_chars_ptr)
               return int16;

    function Register(
                ap_id  : int16;
                me_text: const_chars_ptr)
               return int16;

    function Unregister(
                id    : int16)
               return int16;

    function Popup(
                me_menu : in AMENU;
                me_xpos : int16;
                me_ypos : int16;
                me_mdata: out AMENU)
               return int16;

    function Attach(
                me_flag : int16;
                me_tree : in Objects.Aestree_Ptr;
                me_item : int16;
                me_mdata: AMENU_ptr)
               return int16;

    function Click(
                click : int16;
                setit : int16)
               return int16;

    function Istart(
                me_flag : int16;
                me_tree : in Objects.Aestree_Ptr;
                me_imenu: int16;
                me_item : int16)
               return int16;

    function Settings(
                me_flag  : int16;
                me_values: in MN_SET)
               return int16;


    --  old C-style names
    function menu_bar(
                me_tree: in Objects.AEStree_ptr;
                me_mode: int16)
               return int16 renames Bar;

    function menu_icheck(
                me_tree : in Objects.AEStree_ptr;
                me_item : int16;
                me_check: int16)
               return int16 renames Icheck;

    function menu_ienable(
                me_tree  : in Objects.AEStree_ptr;
                me_item  : int16;
                me_enable: int16)
               return int16 renames Ienable;

    function menu_tnormal(
                me_tree  : in Objects.AEStree_ptr;
                me_item  : int16;
                me_normal: int16)
               return int16 renames Tnormal;

    function menu_text(
                me_tree: in Objects.AEStree_ptr;
                me_item: int16;
                me_text: const_chars_ptr)
               return int16 renames Text;

    function menu_register(
                ap_id  : int16;
                me_text: const_chars_ptr)
               return int16 renames Register;

    function menu_unregister(
                id    : int16)
               return int16 renames Unregister;

    function menu_popup(
                me_menu : in AMENU;
                me_xpos : int16;
                me_ypos : int16;
                me_mdata: out AMENU)
               return int16 renames Popup;

    function menu_attach(
                me_flag : int16;
                me_tree : in Objects.AEStree_ptr;
                me_item : int16;
                me_mdata: AMENU_ptr)
               return int16 renames Attach;

    function menu_click(
                click : int16;
                setit : int16)
               return int16 renames Click;

    function menu_istart(
                me_flag : int16;
                me_tree : in Objects.AEStree_ptr;
                me_imenu: int16;
                me_item : int16)
               return int16 renames Istart;

    function menu_settings(
                me_flag  : int16;
                me_values: in MN_SET)
               return int16 renames Settings;


end Atari.Aes.Menu;
