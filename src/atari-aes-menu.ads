package Atari.Aes.Menu is

    function Bar(
                me_tree: in AEStree;
                me_mode: int16)
               return int16 renames menu_bar;

    function Icheck(
                me_tree : in AEStree;
                me_item : int16;
                me_check: int16)
               return int16 renames menu_icheck;

    function Ienable(
                me_tree  : in AEStree;
                me_item  : int16;
                me_enable: int16)
               return int16 renames menu_ienable;

    function Tnormal(
                me_tree  : in AEStree;
                me_item  : int16;
                me_normal: int16)
               return int16 renames menu_tnormal;

    function Text(
                me_tree: in AEStree;
                me_item: int16;
                me_text: const_chars_ptr)
               return int16 renames menu_text;

    function Register(
                ap_id  : int16;
                me_text: const_chars_ptr)
               return int16 renames menu_register;

    function Unregister(
                id    : int16)
               return int16 returns menu_unregister;

    function Popup(
                me_menu : in MENU;
                me_xpos : int16;
                me_ypos : int16;
                me_mdata: out MENU)
               return int16 renames menu_popup;

    function Attach(
                me_flag : int16;
                me_tree : in AEStree;
                me_item : int16;
                me_mdata: MENU_ptr)
               return int16 renames menu_attach;

    function Click(
                click : int16;
                setit : int16)
               return int16 renames menu_click;

    function Istart(
                me_flag : int16;
                me_tree : in AEStree;
                me_imenu: int16;
                me_item : int16)
               return int16 renames menu_istart;

    function Settings(
                me_flag  : int16;
                me_values: in MN_SET)
               return int16 renames menu_settings;

end package Atari.Aes.Menu;
