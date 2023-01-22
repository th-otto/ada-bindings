with Atari; use Atari;
with Atari.Aes; use Atari.Aes;
with Interfaces; use Interfaces;
with wdlgdemo_resource; use wdlgdemo_resource;


package body wdlgdemo_callbacks is

	function handle_dlg(args: Wdialog.HNDL_OBJ_args) return int16 is
		tree: AEStree_ptr;
		r: GRECT;
	begin
		tree := Wdialog.wdlg_get_tree(args.dialog, r);
	
        case args.obj is
            when WDialog.HNDL_CLSD =>
				return 0;
			when TEST_OK =>
				tree(TEST_OK).ob_state := tree(TEST_OK).ob_state and not OS_SELECTED;
				return 0;
            when others =>
                null;
        end case;
		return 1;
	end;

end wdlgdemo_callbacks;
