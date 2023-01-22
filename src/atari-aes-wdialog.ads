with Atari.Aes.Extensions;

package Atari.Aes.Wdialog is

	subtype DIALOG_ptr is Atari.Aes.Extensions.DIALOG_ptr;
	subtype EVNT_ptr is Atari.Aes.Extensions.EVNT_ptr;

    type HNDL_OBJ_args is
        record
            dialog: aliased DIALOG_ptr;
            events: aliased EVNT_ptr;
            obj   : aliased int16;
            clicks: aliased int16;
            data  : aliased System.Address;
        end record;
    pragma Convention(C_Pass_By_Copy, HNDL_OBJ_args);

    type HNDL_OBJ is access function(p1: HNDL_OBJ_args) return int16;
    pragma Convention(C, HNDL_OBJ);


    function wdlg_create(
                handle_exit: HNDL_OBJ;
                tree       : OBJECT_ptr;
                user_data  : System.Address;
                code       : int16;
                data       : System.Address;
                flags      : int16)
               return DIALOG_ptr;

    function wdlg_open(
                dialog: DIALOG_ptr;
                title : in String;
                kind  : int16;
                x     : int16;
                y     : int16;
                code  : int16;
                data  : System.Address)
               return int16;

    function wdlg_close(
                dialog: DIALOG_ptr;
                x     : out int16;
                y     : out int16)
               return int16;

    function wdlg_delete(dialog: DIALOG_ptr) return int16;

    function wdlg_get_tree(
                dialog: DIALOG_ptr;
                r     : out GRECT)
               return OBJECT_ptr;

    function wdlg_get_edit(
                dialog: DIALOG_ptr;
                cursor: out int16)
               return int16;

    function wdlg_get_udata(dialog: DIALOG_ptr) return System.Address;

    function wdlg_get_handle(dialog: DIALOG_ptr) return int16;

    function wdlg_set_edit(
                dialog: DIALOG_ptr;
                obj   : int16)
               return int16;

    function wdlg_set_tree(
                dialog: DIALOG_ptr;
                tree  : OBJECT_ptr)
               return int16;

    function wdlg_set_size(
                dialog: DIALOG_ptr;
                size  : in GRECT)
               return int16;

	function wdlg_set_iconify(
	            dialog: DIALOG_ptr;
	            g     : in GRECT;
	            title : const_chars_ptr;
	            tree  : OBJECT_ptr;
	            obj   : int16)
	           return int16;

	function wdlg_set_iconify(
	            dialog: DIALOG_ptr;
	            g     : in GRECT;
	            title : in String;
	            tree  : OBJECT_ptr;
	            obj   : int16)
	           return int16;

    function wdlg_set_uniconify(
                dialog: DIALOG_ptr;
                g     : in GRECT;
                title : const_chars_ptr;
                tree  : OBJECT_ptr)
               return int16;

    function wdlg_set_uniconify(
                dialog: DIALOG_ptr;
                g     : in GRECT;
                title : in String;
                tree  : OBJECT_ptr)
               return int16;

    function wdlg_evnt(
                dialog: DIALOG_ptr;
                events: EVNT_ptr)
               return int16;

    procedure wdlg_redraw(
                dialog: DIALOG_ptr;
                rect  : in GRECT;
                obj   : int16;
                depth : int16);


end Atari.Aes.Wdialog;
