with Interfaces; use Interfaces;

package body Atari.Aes.Pdlg is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function pdlg_create(dialog_flags: int16) return PRN_DIALOG_ptr is
begin
	aes_control.opcode := 200;
	aes_control.num_intin := 1;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 1;
	aes_intin(0) := dialog_flags;
	aes_trap;
	return PRN_DIALOG_ptr'Deref(aes_addrout(0)'Address);
end;


procedure pdlg_delete(prn_dialog: PRN_DIALOG_ptr) is
begin
	aes_control.opcode := 201;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_trap;
end;


function pdlg_open(
            prn_dialog   : PRN_DIALOG_ptr;
            settings     : PRN_SETTINGS_ptr;
            document_name: in String;
            option_flags : int16;
            x            : int16;
            y            : int16)
           return int16 is
    c_name: constant String := document_name & ASCII.NUL;
begin
	aes_control.opcode := 202;
	aes_control.num_intin := 3;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := settings.all'Address;
	aes_addrin(2) := c_name(c_name'First)'Address;
	aes_intin(0) := option_flags;
	aes_intin(1) := x;
	aes_intin(2) := y;
	aes_trap;
	return aes_intout(0);
end;


procedure pdlg_close(
            prn_dialog: PRN_DIALOG_ptr;
            x         : out int16;
            y         : out int16)
           is
begin
	aes_control.opcode := 203;
	aes_control.num_intin := 0;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_trap;
	x := aes_intout(1);
	y := aes_intout(2);
end;


function pdlg_get_setsize return int32 is
begin
	aes_control.opcode := 204;
	aes_control.num_intin := 1;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	aes_trap;
	return int32'Deref(aes_intout(0)'Address);
end;


function pdlg_add_printers(
            prn_dialog: PRN_DIALOG_ptr;
            drv_info  : DRV_INFO_ptr)
           return boolean is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := drv_info.all'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


procedure pdlg_remove_printers(prn_dialog: PRN_DIALOG_ptr) is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 1;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_trap;
end;


function pdlg_update(
            prn_dialog   : PRN_DIALOG_ptr;
            document_name: in String)
           return boolean is
    c_name: constant String := document_name & ASCII.NUL;
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_intin(0) := 2;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := System.Null_Address;
	aes_addrin(2) := c_name(c_name'First)'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


function pdlg_add_sub_dialogs(
            prn_dialog : PRN_DIALOG_ptr;
            sub_dialogs: PDLG_SUB_ptr)
           return boolean is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 3;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := sub_dialogs.all'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


procedure pdlg_remove_sub_dialogs(prn_dialog: PRN_DIALOG_ptr) is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 4;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_trap;
end;


function pdlg_new_settings(prn_dialog: PRN_DIALOG_ptr) return PRN_SETTINGS_ptr is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 1;
	aes_intin(0) := 5;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_trap;
	return PRN_SETTINGS_ptr'Deref(aes_addrout(0)'Address);
end;


function pdlg_free_settings(settings: PRN_SETTINGS_ptr) return boolean is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 6;
	aes_addrin(0) := settings.all'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


procedure pdlg_dflt_settings(
            prn_dialog: PRN_DIALOG_ptr;
            settings  : PRN_SETTINGS_ptr) is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 7;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := settings.all'Address;
	aes_trap;
end;


function pdlg_validate_settings(
            prn_dialog: PRN_DIALOG_ptr;
            settings  : PRN_SETTINGS_ptr)
           return boolean is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 8;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := settings.all'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


function pdlg_use_settings(
            prn_dialog: PRN_DIALOG_ptr;
            settings  : PRN_SETTINGS_ptr)
           return boolean is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 9;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := settings.all'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


function pdlg_save_default_settings(
            prn_dialog: PRN_DIALOG_ptr;
            settings  : PRN_SETTINGS_ptr)
           return boolean is
begin
	aes_control.opcode := 205;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 10;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := settings.all'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


function pdlg_evnt(
            prn_dialog: PRN_DIALOG_ptr;
            settings  : PRN_SETTINGS_ptr;
            events    : Wdialog.EVNT_ptr;
            button    : out int16)
           return boolean is
begin
	aes_control.opcode := 206;
	aes_control.num_intin := 0;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := settings.all'Address;
	aes_addrin(2) := events.all'Address;
	aes_trap;
	button := aes_intout(1);
	return aes_intout(0) /= 0;
end;


function pdlg_do(
            prn_dialog   : PRN_DIALOG_ptr;
            settings     : PRN_SETTINGS_ptr;
            document_name: in String;
            option_flags : int16)
           return int16 is
    c_name: constant String := document_name & ASCII.NUL;
begin
	aes_control.opcode := 207;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_intin(0) := option_flags;
	aes_addrin(0) := prn_dialog.all'Address;
	aes_addrin(1) := settings.all'Address;
	aes_addrin(2) := c_name(c_name'First)'Address;
	aes_trap;
	return aes_intout(0);
end;

 
end Atari.Aes.Pdlg;
