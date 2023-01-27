pragma No_Strict_Aliasing;
with Ada.Unchecked_Conversion;
with Interfaces; use Interfaces;

package body Atari.Aes.Resource is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);


function Load(Name: const_chars_ptr) return Int16 is
begin
	aes_control.opcode := 110;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;

	aes_addrin(0) := Name.all'Address;
	aes_trap;
	return aes_intout(0);
end;


function Load(Name: String) return Int16 is
    c_str: String := Name & ASCII.NUL;
    function to_address is new Ada.Unchecked_Conversion(void_ptr, const_chars_ptr);
begin
	return rsrc_load(to_address(c_str(c_str'First)'Address));
end;


function Free return Int16 is
begin
	aes_control.opcode := 111;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;

	aes_trap;
	return aes_intout(0);
end;


function Get_Address(Typ: Resource_Type; Index: Int16; Addr: out void_ptr) return Int16 is
begin
	aes_control.opcode := 112;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 1;
	aes_intin(0) := Typ'Enum_Rep;
	aes_intin(1) := Index;
	aes_trap;
	addr := aes_addrout(0);
	return aes_intout(0);
end;


function Get_Address(Index: Int16) return Objects.AEStree_ptr is
    treeadr: void_ptr;
begin
	if rsrc_gaddr(R_TREE, Index, treeadr) = 0 then
	   return null;
	end if;
	return Objects.AEStree_ptr'Deref(treeadr'Address);
end;


function Get_Address(Index: Int16) return const_chars_ptr is
    stradr: void_ptr;
begin
	--
	-- Note: R_FRSTR returns the address of the string pointer,
	-- while R_STRING returns the string pointer itself
	--
	if rsrc_gaddr(R_STRING, Index, stradr) = 0 then
	   return null;
	end if;
	return const_chars_ptr'Deref(stradr'Address);
end;


function Get_Address(Index: int16) return Objects.BITBLK_ptr is
    bitadr: void_ptr;
begin
	--
	-- Note: R_FRIMG returns the address of the BITBLK pointer,
	-- while R_IMAGEDATA returns the BITBLK pointer itself
	--
	if rsrc_gaddr(R_IMAGEDATA, Index, bitadr) = 0 then
	   return null;
	end if;
	return Objects.BITBLK_ptr'Deref(bitadr'Address);
end;


function Set_Address(Typ: Resource_Type; Index: int16; Addr: void_ptr) return Int16 is
begin
	aes_control.opcode := 113;
	aes_control.num_intin := 2;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Typ'Enum_Rep;
	aes_intin(1) := Index;
	aes_addrin(0) := Addr;
	aes_trap;
	return aes_intout(0);
end;


procedure Obfix(tree: Objects.Object_Ptr; Index: Int16) is
begin
	aes_control.opcode := 114;
	aes_control.num_intin := 1;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_intin(0) := Index;
	aes_addrin(0) := tree.all'Address;
	aes_trap;
end;


function Rcfix(
            rc_header : void_ptr)
           return int16 is
begin
	aes_control.opcode := 115;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := rc_header;
	aes_trap;
	return aes_intout(0);
end;



end Atari.Aes.Resource;
