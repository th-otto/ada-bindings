package body Atari.Aes.Listbox is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Create(
            tree     : Objects.Object_Ptr;
            slct     : Select_Item;
            set      : Set_Item;
            items    : Listbox_Item_Ptr;
            visible_a: int16;
            first_a  : int16;
            ctrl_objs: in short_array;
            objs     : in short_array;
            flags    : int16;
            pause_a  : int16;
            user_data: void_ptr;
            dialog   : Wdialog.DIALOG_ptr;
            visible_b: int16;
            first_b  : int16;
            entries_b: int16;
            pause_b  : int16)
           return Listbox_Ptr is
begin
    aes_control.opcode := 170;
    aes_control.num_intin := 8;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 8;
    aes_control.num_addrout := 1;
    aes_intin(0) := visible_a;
    aes_intin(1) := first_a;
    aes_intin(2) := flags;
    aes_intin(3) := pause_a;
    aes_intin(4) := visible_b;
    aes_intin(5) := first_b;
    aes_intin(6) := entries_b;
    aes_intin(7) := pause_b;
    aes_addrin(0) := tree.all'Address;
    aes_addrin(1) := slct.all'Address;
    aes_addrin(2) := set.all'Address;
    aes_addrin(3) := items.all'Address;
    aes_addrin(4) := ctrl_objs(ctrl_objs'First)'Address;
    aes_addrin(5) := objs(objs'First)'Address;
    aes_addrin(6) := user_data;
    aes_addrin(7) := dialog.all'Address;
    aes_trap;
    return Listbox_Ptr'Deref(aes_addrout(0)'Address);
end;


procedure Update(box: Listbox_Ptr; rect: in GRECT) is
begin
    aes_control.opcode := 171;
    aes_control.num_intin := 0;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_addrin(0) := box.all'Address;
    aes_addrin(1) := rect'Address;
    aes_trap;
end;


function Run(box: Listbox_Ptr; Obj: int16) return int16 is
begin
    aes_control.opcode := 172;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := box.all'Address;
    aes_intin(0) := Obj;
    aes_trap;
    return aes_intout(0);
end;


procedure Delete(box: Listbox_Ptr) is
begin
    aes_control.opcode := 173;
    aes_control.num_intin := 0;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_addrin(0) := box.all'Address;
    aes_trap;
end;


function Count_Items(box: Listbox_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 0;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return aes_intout(0);
end;


function Get_Tree(box: Listbox_Ptr) return Objects.Object_Ptr is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 1;
    aes_intin(0) := 1;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return Objects.Object_Ptr'Deref(aes_intout(0)'Address);
end;


function Get_A_Visible(box: Listbox_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 2;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return aes_intout(0);
end;


function Get_User_Data(box: Listbox_Ptr) return void_ptr is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 1;
    aes_intin(0) := 3;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return void_ptr'Deref(aes_addrout(0)'Address);
end;


function Get_A_First(box: Listbox_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 4;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return aes_intout(0);
end;


function Get_Select_Index(box: Listbox_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 5;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return aes_intout(0);
end;


function Get_Items(box: Listbox_Ptr) return Listbox_Item_Ptr is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 1;
    aes_intin(0) := 6;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return Listbox_Item_Ptr'Deref(aes_addrout(0)'Address);
end;


function Get_Item(box: Listbox_Ptr; n: int16) return Listbox_Item_Ptr is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 2;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 1;
    aes_intin(0) := 7;
    aes_intin(1) := n;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return Listbox_Item_Ptr'Deref(aes_addrout(0)'Address);
end;


function Get_Select_Item(box: Listbox_Ptr) return Listbox_Item_Ptr is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 1;
    aes_intin(0) := 8;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return Listbox_Item_Ptr'Deref(aes_addrout(0)'Address);
end;


function Get_Index(items: Listbox_Item_Ptr; search: Listbox_Item_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_intin(0) := 9;
    aes_addrin(0) := items.all'Address;
    aes_addrin(1) := search.all'Address;
    aes_trap;
    return aes_intout(0);
end;


function Get_B_Visible(box: Listbox_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 10;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return aes_intout(0);
end;


function Get_B_Entries(box: Listbox_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 11;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return aes_intout(0);
end;


function Get_B_First(box: Listbox_Ptr) return int16 is
begin
    aes_control.opcode := 174;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 12;
    aes_addrin(0) := box.all'Address;
    aes_trap;
    return aes_intout(0);
end;


procedure Set_A_Slider(box: Listbox_Ptr; first: int16; rect: in GRECT) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 2;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_intin(0) := 0;
    aes_intin(1) := first;
    aes_addrin(0) := box.all'Address;
    aes_addrin(1) := rect'Address;
    aes_trap;
end;


procedure Set_Items(box: Listbox_Ptr; items: Listbox_Item_Ptr) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_intin(0) := 1;
    aes_addrin(0) := box.all'Address;
    aes_addrin(1) := items.all'Address;
    aes_trap;
end;


procedure Free_Items(box: Listbox_Ptr) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 2;
    aes_addrin(0) := box.all'Address;
    aes_trap;
end;


procedure Free_List(items: Listbox_Item_Ptr) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 1;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 3;
    aes_addrin(0) := items.all'Address;
    aes_trap;
end;


procedure A_Scroll_To(box: Listbox_Ptr; first: int16; box_rect: in GRECT; slider_rect: in GRECT) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 2;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 3;
    aes_control.num_addrout := 0;
    aes_intin(0) := 4;
    aes_intin(1) := first;
    aes_addrin(0) := box.all'Address;
    aes_addrin(1) := box_rect'Address;
    aes_addrin(2) := slider_rect'Address;
    aes_trap;
end;


procedure Set_B_Slider(box: Listbox_Ptr; first: int16; rect: in GRECT) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 2;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 2;
    aes_control.num_addrout := 0;
    aes_intin(0) := 5;
    aes_intin(1) := first;
    aes_addrin(0) := box.all'Address;
    aes_addrin(1) := rect'Address;
    aes_trap;
end;


procedure Set_B_Entries(box: Listbox_Ptr; entries: int16) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 2;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 1;
    aes_control.num_addrout := 0;
    aes_intin(0) := 6;
    aes_intin(1) := entries;
    aes_addrin(0) := box.all'Address;
    aes_trap;
end;


procedure B_Scroll_To(box: Listbox_Ptr; first: int16; box_rect: in GRECT; slider_rect: in GRECT) is
begin
    aes_control.opcode := 175;
    aes_control.num_intin := 2;
    aes_control.num_intout := 0;
    aes_control.num_addrin := 3;
    aes_control.num_addrout := 0;
    aes_intin(0) := 7;
    aes_intin(1) := first;
    aes_addrin(0) := box.all'Address;
    aes_addrin(1) := box_rect'Address;
    aes_addrin(2) := slider_rect'Address;
    aes_trap;
end;

end Atari.Aes.Listbox;
