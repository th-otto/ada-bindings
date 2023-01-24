pragma No_Strict_Aliasing;
with System;
with Ada.Unchecked_Conversion;
with Interfaces; use Interfaces;

package body Atari.Aes.Fontsel is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function to_pointer is new Ada.Unchecked_Conversion(void_ptr, FNT_DIALOG_ptr);


procedure set_intin_long(offset: Integer; val: int32) is
    ptr: System.Address;
begin
    ptr := aes_intin(offset)'Address;
    int32'Deref(ptr) := val;
end;


function get_intout_long(offset: Integer) return int32 is
    ptr: System.Address;
begin
    ptr := aes_intout(offset)'Address;
    return int32'Deref(ptr);
end;




function fnts_create(
            vdi_handle  : int16; -- VdiHdl
            no_fonts    : int16;
            font_flags  : int16;
            dialog_flags: int16;
            sample      : in String;
            opt_button  : in String)
           return FNT_DIALOG_ptr is
    c_str: String := sample & ASCII.NUL;
    c_str2: String := opt_button & ASCII.NUL;
begin
	aes_control.opcode := 180;
	aes_control.num_intin := 1;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 1;
	aes_intin(0) := vdi_handle;
	aes_intin(1) := no_fonts;
	aes_intin(2) := font_flags;
	aes_intin(3) := dialog_flags;
	aes_addrin(0) := c_str'Address;
	if c_str2'Length = 0 then
		aes_addrin(1) := System.null_address;
	else
		aes_addrin(1) := c_str2'Address;
	end if;
	aes_trap;
	return to_pointer(aes_addrout(0));
end;


function fnts_delete(
            fnt_dialog: FNT_DIALOG_ptr;
            vdi_handle: int16)
           return int16 is
begin
	aes_control.opcode := 181;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := vdi_handle;
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function fnts_open(
            fnt_dialog  : FNT_DIALOG_ptr;
            button_flags: int16;
            x           : int16;
            y           : int16;
            id          : int32;
            pt          : int32;
            ratio       : int32)
           return int16 is
begin
	aes_control.opcode := 182;
	aes_control.num_intin := 9;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := button_flags;
	aes_intin(1) := x;
	aes_intin(2) := y;
	set_intin_long(3, id);
	set_intin_long(5, pt);
	set_intin_long(7, ratio);
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function fnts_close(fnt_dialog: FNT_DIALOG_ptr; x, y: out int16) return int16 is
begin
	aes_control.opcode := 183;
	aes_control.num_intin := 0;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intout(1) := -1;
	aes_intout(2) := -1;
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
	x := aes_intout(1);
	y := aes_intout(2);
	return aes_intout(0);
end;


function fnts_get_no_styles(
            fnt_dialog: FNT_DIALOG_ptr;
            id        : int32)
           return int16 is
begin
	aes_control.opcode := 184;
	aes_control.num_intin := 3;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	set_intin_long(1, id);
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function fnts_get_style(
            fnt_dialog: FNT_DIALOG_ptr;
            id        : int32;
            index     : int16)
           return int32 is
begin
	aes_control.opcode := 184;
	aes_control.num_intin := 4;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 1;
	set_intin_long(1, id);
	aes_intin(3) := index;
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
	return get_intout_long(0);
end;


function fnts_get_name(
            fnt_dialog : FNT_DIALOG_ptr;
            id         : int32;
            full_name  : out String;
            family_name: out String;
            style_name : out String)
           return boolean is
begin
	aes_control.opcode := 184;
	aes_control.num_intin := 3;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_intin(0) := 2;
	set_intin_long(1, id);
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_addrin(1) := full_name(full_name'First)'Address;
	aes_addrin(2) := family_name(family_name'First)'Address;
	aes_addrin(3) := style_name(style_name'First)'Address;
	aes_trap;
	return aes_intout(0) /= 0;
end;


function fnts_get_info(
            fnt_dialog: FNT_DIALOG_ptr;
            id        : int32;
            mono      : out boolean;
            outline   : out boolean)
           return int16 is
begin
	aes_control.opcode := 184;
	aes_control.num_intin := 3;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 3;
	set_intin_long(1, id);
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
	mono := aes_intout(1) /= 0;
	outline := aes_intout(2) /= 0;
	return aes_intout(0);
end;


function fnts_add(
            fnt_dialog: FNT_DIALOG_ptr;
            user_fonts: FNTS_ITEM_ptr)
           return int16 is
begin
	aes_control.opcode := 185;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_addrin(1) := user_fonts.all'Address;
	aes_trap;
	return aes_intout(0);
end;


procedure fnts_remove(fnt_dialog: FNT_DIALOG_ptr) is
begin
	aes_control.opcode := 185;
	aes_control.num_intin := 1;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 1;
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
end;


function fnts_update(
            fnt_dialog  : FNT_DIALOG_ptr;
            button_flags: int16;
            id          : int32;
            pt          : int32;
            ratio       : int32)
           return int16 is
begin
	aes_control.opcode := 185;
	aes_control.num_intin := 8;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 2;
	aes_intin(1) := button_flags;
	set_intin_long(2, id);
	set_intin_long(4, pt);
	set_intin_long(6, ratio);
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function fnts_evnt(
            fnt_dialog : FNT_DIALOG_ptr;
            events     : Wdialog.EVNT_ptr;
            button     : out int16;
            check_boxes: out int16;
            id         : out int32;
            pt         : out int32;
            ratio      : out int32)
           return int16 is
begin
	aes_control.opcode := 186;
	aes_control.num_intin := 0;
	aes_control.num_intout := 9;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_addrin(1) := events.all'Address;
	aes_trap;
	button := aes_intout(1);
	check_boxes := aes_intout(2);
	id := get_intout_long(3);
	pt := get_intout_long(5);
	ratio := get_intout_long(7);
	return aes_intout(0);
end;


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
           return int16 is
begin
	aes_control.opcode := 187;
	aes_control.num_intin := 7;
	aes_control.num_intout := 8;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := fnt_dialog.all'Address;
	aes_intin(0) := button_flags;
	set_intin_long(1, id_in);
	set_intin_long(3, pt_in);
	set_intin_long(5, ratio_in);
	aes_trap;
	check_boxes := aes_intout(1);
	id := get_intout_long(2);
	pt := get_intout_long(4);
	ratio := get_intout_long(6);
	return aes_intout(0);
end;



end Atari.Aes.Fontsel;
