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


    function menu_bar(
                me_tree: in Objects.AEStree_ptr;
                me_mode: int16)
               return int16;

    function menu_icheck(
                me_tree : in Objects.AEStree_ptr;
                me_item : int16;
                me_check: int16)
               return int16;

    function menu_ienable(
                me_tree  : in Objects.AEStree_ptr;
                me_item  : int16;
                me_enable: int16)
               return int16;

    function menu_tnormal(
                me_tree  : in Objects.AEStree_ptr;
                me_item  : int16;
                me_normal: int16)
               return int16;

    function menu_text(
                me_tree: in Objects.AEStree_ptr;
                me_item: int16;
                me_text: const_chars_ptr)
               return int16;

    function menu_register(
                ap_id  : int16;
                me_text: const_chars_ptr)
               return int16;

    function menu_unregister(
                id    : int16)
               return int16;

    function menu_popup(
                me_menu : in AMENU;
                me_xpos : int16;
                me_ypos : int16;
                me_mdata: out AMENU)
               return int16;

    function menu_attach(
                me_flag : int16;
                me_tree : in Objects.AEStree_ptr;
                me_item : int16;
                me_mdata: AMENU_ptr)
               return int16;

    function menu_click(
                click : int16;
                setit : int16)
               return int16;

    function menu_istart(
                me_flag : int16;
                me_tree : in Objects.AEStree_ptr;
                me_imenu: int16;
                me_item : int16)
               return int16;

    function menu_settings(
                me_flag  : int16;
                me_values: in MN_SET)
               return int16;


    function Bar(
                me_tree: in Objects.AEStree_ptr;
                me_mode: int16)
               return int16 renames menu_bar;

    function Icheck(
                me_tree : in Objects.AEStree_ptr;
                me_item : int16;
                me_check: int16)
               return int16 renames menu_icheck;

    function Ienable(
                me_tree  : in Objects.Aestree_Ptr;
                me_item  : int16;
                me_enable: int16)
               return int16 renames menu_ienable;

    function Tnormal(
                me_tree  : in Objects.Aestree_Ptr;
                me_item  : int16;
                me_normal: int16)
               return int16 renames menu_tnormal;

    function Text(
                me_tree: in Objects.Aestree_Ptr;
                me_item: int16;
                me_text: const_chars_ptr)
               return int16 renames menu_text;

    function Register(
                ap_id  : int16;
                me_text: const_chars_ptr)
               return int16 renames menu_register;

    function Unregister(
                id    : int16)
               return int16 renames menu_unregister;

    function Popup(
                me_menu : in AMENU;
                me_xpos : int16;
                me_ypos : int16;
                me_mdata: out AMENU)
               return int16 renames menu_popup;

    function Attach(
                me_flag : int16;
                me_tree : in Objects.Aestree_Ptr;
                me_item : int16;
                me_mdata: AMENU_ptr)
               return int16 renames menu_attach;

    function Click(
                click : int16;
                setit : int16)
               return int16 renames menu_click;

    function Istart(
                me_flag : int16;
                me_tree : in Objects.Aestree_Ptr;
                me_imenu: int16;
                me_item : int16)
               return int16 renames menu_istart;

    function Settings(
                me_flag  : int16;
                me_values: in MN_SET)
               return int16 renames menu_settings;

end Atari.Aes.Menu;
