with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Menu is

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
