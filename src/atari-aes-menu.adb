pragma No_Strict_Aliasing;

package body Atari.Aes.Menu is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Bar(
            me_tree: Objects.Aestree_Ptr;
            me_mode: int16)
           return int16 is
begin
	aes_control.opcode := 30;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_mode;
	aes_addrin(0) := me_tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Icheck(
            me_tree : in Objects.Aestree_Ptr;
            me_item : int16;
            me_check: int16)
           return int16 is
begin
	aes_control.opcode := 30;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_intin(1) := me_check;
	aes_addrin(0) := me_tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Ienable(
            me_tree  : in Objects.Aestree_Ptr;
            me_item  : int16;
            me_enable: int16)
           return int16 is
begin
	aes_control.opcode := 32;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_intin(1) := me_enable;
	aes_addrin(0) := me_tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Tnormal(
            me_tree  : in Objects.Aestree_Ptr;
            me_item  : int16;
            me_normal: int16)
           return int16 is
begin
	aes_control.opcode := 33;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_intin(1) := me_normal;
	aes_addrin(0) := me_tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Text(
            me_tree: in Objects.Aestree_Ptr;
            me_item: int16;
            me_text: const_chars_ptr)
           return int16 is
begin
	aes_control.opcode := 34;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_item;
	aes_addrin(0) := me_tree.all'Address;
	aes_addrin(1) := me_text.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Register(
            ap_id  : int16;
            me_text: const_chars_ptr)
           return int16 is
begin
	aes_control.opcode := 35;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := ap_id;
	aes_addrin(0) := me_text.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Unregister(
            id    : int16)
           return int16 is
begin
	aes_control.opcode := 36;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := id;
	aes_trap;
	return aes_intout(0);
end;


function Popup(
            me_menu : in AMENU;
            me_xpos : int16;
            me_ypos : int16;
            me_mdata: out AMENU)
           return int16 is
begin
	aes_control.opcode := 36;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_xpos;
	aes_intin(1) := me_ypos;
	aes_addrin(0) := me_menu'Address;
	aes_addrin(1) := me_mdata'Address;
	aes_trap;
	return aes_intout(0);
end;


function Attach(
            me_flag : int16;
            me_tree : Objects.Aestree_Ptr;
            me_item : int16;
            me_mdata: AMENU_ptr)
           return int16 is
begin
	aes_control.opcode := 37;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_flag;
	aes_intin(1) := me_item;
	aes_addrin(0) := me_tree.all'Address;
	aes_addrin(1) := me_mdata.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Click(
            click : int16;
            setit : int16)
           return int16 is
begin
	aes_control.opcode := 37;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := click;
	aes_intin(1) := setit;
	aes_trap;
	return aes_intout(0);
end;


function Istart(
            me_flag : int16;
            me_tree : Objects.Aestree_Ptr;
            me_imenu: int16;
            me_item : int16)
           return int16 is
begin
	aes_control.opcode := 38;
	aes_control.num_intin := 3;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_flag;
	aes_intin(1) := me_imenu;
	aes_intin(2) := me_item;
	aes_addrin(0) := me_tree.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Settings(
            me_flag  : int16;
            me_values: in MN_SET)
           return int16 is
begin
	aes_control.opcode := 39;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := me_flag;
	aes_addrin(0) := me_values'Address;
	aes_trap;
	return aes_intout(0);
end;


end Atari.Aes.Menu;
