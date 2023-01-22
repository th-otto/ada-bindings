package Atari.Aes.Resource is

    function Load(
                Name      : const_chars_ptr)
               return int16 renames rsrc_load;

    function Load(
                Name      : String)
               return int16 renames rsrc_load;

    function Free return int16 renames rsrc_free;

    function Get_Addr(
                c_Type    : int16;
                Index     : int16;
                Addr      : out System.Address)
               return int16 renames rsrc_gaddr;

    function Get_Addr(
                Index     : int16)
               return AEStree_ptr renames rsrc_gaddr;

    function Get_Addr(
                Index     : int16)
               return const_chars_ptr renames rsrc_gaddr;

    function Set_Addr(
                c_Type    : int16;
                Index     : int16;
                Addr      : System.Address)
               return int16 renames rsrc_saddr;

    function Obfix(
                tree      : OBJECT_ptr;
                Index     : int16)
               return int16 renames rsrc_obfix;

    function Rcfix(
                rc_header : System.Address)
               return int16 renames rsrc_rcfix;



end Atari.Aes.Resource;
