with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Wdialog is

    type DIALOG is record null; end record;
    type DIALOG_ptr is access all DIALOG;

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

    SORTBYNAME               : constant  := 0;
    SORTBYDATE               : constant  := 1;
    SORTBYSIZE               : constant  := 2;
    SORTBYTYPE               : constant  := 3;
    SORTBYNONE               : constant  := 4;
    SORTDEFAULT              : constant  := -1;

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
            msg     : aliased Message_Buffer;
            unused  : aliased short_array(0..7);
        end record
    	with Convention => C;
    type EVNT_ptr is access all EVNT;


    type HNDL_OBJ_args is
        record
            dialog: aliased DIALOG_ptr;
            events: aliased EVNT_ptr;
            obj   : aliased int16;
            clicks: aliased int16;
            data  : aliased void_ptr;
        end record;
    pragma Convention(C_Pass_By_Copy, HNDL_OBJ_args);

    type HNDL_OBJ is access function(p1: HNDL_OBJ_args) return int16
    	with Convention => C;


    function wdlg_create(
                handle_exit: HNDL_OBJ;
                tree       : Objects.Aestree_Ptr;
                user_data  : void_ptr;
                code       : int16;
                data       : void_ptr;
                flags      : int16)
               return DIALOG_ptr;

    function wdlg_open(
                dialog: DIALOG_ptr;
                title : const_chars_ptr;
                kind  : int16;
                x     : int16;
                y     : int16;
                code  : int16;
                data  : void_ptr)
               return int16;

    function wdlg_close(
                dialog: DIALOG_ptr;
                x     : out int16;
                y     : out int16)
               return int16;

    function wdlg_close(dialog: DIALOG_ptr) return int16;

    function wdlg_delete(dialog: DIALOG_ptr) return int16;

    function wdlg_get_tree(
                dialog: DIALOG_ptr;
                r     : out GRECT)
               return Objects.Aestree_Ptr;

    function wdlg_get_edit(
                dialog: DIALOG_ptr;
                cursor: out int16)
               return int16;

    function wdlg_get_udata(dialog: DIALOG_ptr) return void_ptr;

    function wdlg_get_handle(dialog: DIALOG_ptr) return int16;

    function wdlg_set_edit(
                dialog: DIALOG_ptr;
                obj   : int16)
               return int16;

    function wdlg_set_tree(
                dialog: DIALOG_ptr;
                tree  : Objects.Aestree_Ptr)
               return int16;

    function wdlg_set_size(
                dialog: DIALOG_ptr;
                size  : in GRECT)
               return int16;

	function wdlg_set_iconify(
	            dialog: DIALOG_ptr;
	            g     : in GRECT;
	            title : const_chars_ptr;
	            tree  : Objects.Aestree_Ptr;
	            obj   : int16)
	           return int16;

	function wdlg_set_iconify(
	            dialog: DIALOG_ptr;
	            g     : in GRECT;
	            title : in String;
	            tree  : Objects.Aestree_Ptr;
	            obj   : int16)
	           return int16;

    function wdlg_set_uniconify(
                dialog: DIALOG_ptr;
                g     : in GRECT;
                title : const_chars_ptr;
                tree  : Objects.Aestree_Ptr)
               return int16;

    function wdlg_set_uniconify(
                dialog: DIALOG_ptr;
                g     : in GRECT;
                title : in String;
                tree  : Objects.Aestree_Ptr)
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
