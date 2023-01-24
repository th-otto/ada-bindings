pragma No_Strict_Aliasing;
with Ada.Unchecked_Conversion;
with Interfaces; use Interfaces;

package body Atari.Aes.Wdialog is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

-- function to_address is new Ada.Unchecked_Conversion(OBJECT_ptr, void_ptr);
function to_address is new Ada.Unchecked_Conversion(const_chars_ptr, void_ptr);
function to_pointer is new Ada.Unchecked_Conversion(void_ptr, DIALOG_ptr);


function to_address(tree: AEStree_ptr) return void_ptr is
begin
	return tree.all'Address;
end;


function wdlg_create(
            handle_exit: HNDL_OBJ;
            tree       : AEStree_ptr;
            user_data  : void_ptr;
            code       : int16;
            data       : void_ptr;
            flags      : int16)
           return DIALOG_ptr is
begin
	aes_control.opcode := 160;
	aes_control.num_intin := 2;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 1;
	aes_intin(0) := code;
	aes_intin(1) := flags;
	aes_addrin(0) := handle_exit.all'Address;
	aes_addrin(1) := to_address(tree);
	aes_addrin(2) := user_data;
	aes_addrin(3) := data;
	aes_trap;
	return to_pointer(aes_addrout(0));
end;


function wdlg_open(
            dialog: DIALOG_ptr;
            title : const_chars_ptr;
            kind  : int16;
            x     : int16;
            y     : int16;
            code  : int16;
            data  : void_ptr)
           return int16 is
begin
	aes_control.opcode := 161;
	aes_control.num_intin := 4;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_intin(0) := kind;
	aes_intin(1) := x;
	aes_intin(2) := y;
	aes_intin(3) := code;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := title.all'Address;
	aes_addrin(2) := data;
	aes_trap;
	return aes_intout(0);
end;


function wdlg_close(
            dialog: DIALOG_ptr;
            x     : out int16;
            y     : out int16)
           return int16 is
begin
	aes_control.opcode := 162;
	aes_control.num_intin := 0;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := dialog.all'Address;
	aes_intout(0) := -1;
	aes_intout(1) := -1;
	aes_trap;
	x := aes_intout(1);
	y := aes_intout(2);
	return aes_intout(0);
end;


function wdlg_close(dialog: DIALOG_ptr) return int16 is
begin
	aes_control.opcode := 162;
	aes_control.num_intin := 0;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;



function wdlg_delete(dialog: DIALOG_ptr) return int16 is
begin
	aes_control.opcode := 163;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function wdlg_get_tree(
            dialog: DIALOG_ptr;
            r     : out GRECT)
           return AEStree_ptr is
    tree: AEStree_ptr;
begin
	aes_control.opcode := 164;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 3;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := tree'Address;
	aes_addrin(2) := r'Address;
	aes_trap;
	return tree;
end;


function wdlg_get_edit(
            dialog: DIALOG_ptr;
            cursor: out int16)
           return int16 is
begin
	aes_control.opcode := 164;
	aes_control.num_intin := 1;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 1;
	aes_addrin(0) := dialog.all'Address;
	aes_trap;
	cursor := aes_intout(1);
	return aes_intout(0);
end;


function wdlg_get_udata(dialog: DIALOG_ptr) return void_ptr is
begin
	aes_control.opcode := 164;
	aes_control.num_intin := 1;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 1;
	aes_intin(0) := 2;
	aes_addrin(0) := dialog.all'Address;
	aes_trap;
	return aes_addrout(0);
end;


function wdlg_get_handle(dialog: DIALOG_ptr) return int16 is
begin
	aes_control.opcode := 164;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 3;
	aes_addrin(0) := dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function wdlg_set_edit(
            dialog: DIALOG_ptr;
            obj   : int16)
           return int16 is
begin
	aes_control.opcode := 165;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	aes_intin(1) := obj;
	aes_addrin(0) := dialog.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function wdlg_set_tree(
            dialog: DIALOG_ptr;
            tree  : AEStree_ptr)
           return int16 is
begin
	aes_control.opcode := 165;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 1;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := to_address(tree);
	aes_trap;
	return aes_intout(0);
end;


function wdlg_set_size(
            dialog: DIALOG_ptr;
            size  : in GRECT)
           return int16 is
begin
	aes_control.opcode := 165;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := 2;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := size'Address;
	aes_trap;
	return aes_intout(0);
end;


function wdlg_set_iconify(
            dialog: DIALOG_ptr;
            g     : in GRECT;
            title : const_chars_ptr;
            tree  : AEStree_ptr;
            obj   : int16)
           return int16 is
begin
	aes_control.opcode := 165;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_intin(0) := 3;
	aes_intin(1) := obj;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := g'Address;
	aes_addrin(2) := to_address(title);
	aes_addrin(3) := to_address(tree);
	aes_trap;
	return aes_intout(0);
end;


function wdlg_set_iconify(
            dialog: DIALOG_ptr;
            g     : in GRECT;
            title : in String;
            tree  : AEStree_ptr;
            obj   : int16)
           return int16 is
    c_str: String := title & ASCII.NUL;
begin
	aes_control.opcode := 165;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_intin(0) := 3;
	aes_intin(1) := obj;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := g'Address;
	aes_addrin(2) := c_str'Address;
	aes_addrin(3) := to_address(tree);
	aes_trap;
	return aes_intout(0);
end;


function wdlg_set_uniconify(
            dialog: DIALOG_ptr;
            g     : in GRECT;
            title : const_chars_ptr;
            tree  : AEStree_ptr)
           return int16 is
begin
	aes_control.opcode := 165;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_intin(0) := 4;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := g'Address;
	aes_addrin(2) := to_address(title);
	aes_addrin(3) := to_address(tree);
	aes_trap;
	return aes_intout(0);
end;


function wdlg_set_uniconify(
            dialog: DIALOG_ptr;
            g     : in GRECT;
            title : in String;
            tree  : AEStree_ptr)
           return int16 is
    c_str: String := title & ASCII.NUL;
begin
	aes_control.opcode := 165;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 4;
	aes_control.num_addrout := 0;
	aes_intin(0) := 4;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := g'Address;
	aes_addrin(2) := c_Str'Address;
	aes_addrin(3) := to_address(tree);
	aes_trap;
	return aes_intout(0);
end;


function wdlg_evnt(
            dialog: DIALOG_ptr;
            events: EVNT_ptr)
           return int16 is
begin
	aes_control.opcode := 166;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := events.all'Address;
	aes_trap;
	return aes_intout(0);
end;


procedure wdlg_redraw(
            dialog: DIALOG_ptr;
            rect  : in GRECT;
            obj   : int16;
            depth : int16) is
begin
	aes_control.opcode := 167;
	aes_control.num_intin := 2;
	aes_control.num_intout := 0;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := obj;
	aes_intin(1) := depth;
	aes_addrin(0) := dialog.all'Address;
	aes_addrin(1) := rect'Address;
	aes_trap;
end;







end Atari.Aes.Wdialog;
