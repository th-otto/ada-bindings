with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Resource is

    type RSHDR is
        record
            rsh_vrsn   : aliased int16;
            rsh_object : aliased uint16;
            rsh_tedinfo: aliased uint16;
            rsh_iconblk: aliased uint16;
            rsh_bitblk : aliased uint16;
            rsh_frstr  : aliased uint16;
            rsh_string : aliased uint16;
            rsh_imdata : aliased uint16;
            rsh_frimg  : aliased uint16;
            rsh_trindex: aliased uint16;
            rsh_nobs   : aliased int16;
            rsh_ntree  : aliased int16;
            rsh_nted   : aliased int16;
            rsh_nib    : aliased int16;
            rsh_nbb    : aliased int16;
            rsh_nstring: aliased int16;
            rsh_nimages: aliased int16;
            rsh_rssize : aliased uint16;
        end record;
    type RSHDR_ptr is access all RSHDR;

    type RSXHDR is
        record
            rsh_vrsn   : aliased uint16;
            rsh_extvrsn: aliased uint16;
            rsh_object : aliased uint32;
            rsh_tedinfo: aliased uint32;
            rsh_iconblk: aliased uint32;
            rsh_bitblk : aliased uint32;
            rsh_frstr  : aliased uint32;
            rsh_string : aliased uint32;
            rsh_imdata : aliased uint32;
            rsh_frimg  : aliased uint32;
            rsh_trindex: aliased uint32;
            rsh_nobs   : aliased uint32;
            rsh_ntree  : aliased uint32;
            rsh_nted   : aliased uint32;
            rsh_nib    : aliased uint32;
            rsh_nbb    : aliased uint32;
            rsh_nstring: aliased uint32;
            rsh_nimages: aliased uint32;
            rsh_rssize : aliased uint32;
        end record;
    type RSHXDR_ptr is access all RSXHDR;

    --  Resource structure types as used by rsrc_gaddr()/rsrc_saddr()
    type Resource_Type is (Tree,               -- R_TREE
                          R_Object,            -- R_OBJECT
                          Text_Ed_Info,        -- R_TEDINFO
                          Icon_Block,          -- R_ICONBLK
                          Bit_Block,           -- R_BITBLK
                          R_String,            -- R_STRING
                          Image_Data,          -- R_IMAGEDATA
                          Object_Spec,         -- R_OBSPEC
                          Text_Pointer,        -- R_TEPTEXT
                          Template_Pointer,    -- R_TEPTMPLT
                          Valid_Pointer,       -- R_TEPVALID
                          Icon_Mask_Pointer,   -- R_IBPMASK
                          Icon_Data_Pointer,   -- R_IBPDATA
                          Icon_Text_Pointer,   -- R_IBPTEXT
                          Bitmap_Data_Pointer, -- R_BIPDATA
                          Free_String,         -- R_FRSTR
                          Free_Image           -- R_FRIMG
                         );
    for Resource_Type use (Tree => 0,
                          R_Object => 1,
                          Text_Ed_Info => 2,
                          Icon_Block => 3,
                          Bit_Block => 4,
                          R_String => 5,
                          Image_Data => 6,
                          Object_Spec => 7,
                          Text_Pointer => 8,
                          Template_Pointer => 9,
                          Valid_Pointer => 10,
                          Icon_Mask_Pointer => 11,
                          Icon_Data_Pointer => 12,
                          Icon_Text_Pointer => 13,
                          Bitmap_Data_Pointer => 14,
                          Free_String => 15,
                          Free_Image => 16
                         );
    for Resource_Type'Size use Int16'Size;

    function Load(Name: const_chars_ptr) return Int16;

    function Load(Name: String) return Int16;

    function Free return Int16;

    function Get_Address(Typ: Resource_Type; Index: Int16; Addr: out System.Address) return Int16;

    function Get_Address(Index: Int16) return Objects.AEStree_ptr;

    function Get_Address(Index: Int16) return const_chars_ptr;

    function Get_Address(Index: Int16) return Objects.BITBLK_ptr;

    function Set_Address(Typ: Resource_Type; Index: Int16; Addr: System.Address) return Int16;

    procedure Obfix(tree: Objects.Object_Ptr; Index: Int16);

    function Rcfix(rc_header: System.Address) return Int16;


    --  old C-style names
    R_TREE               : constant Resource_Type := Tree;                   -- *< Object tree, see mt_rsrc_gaddr()
    -- R_OBJECT          : constant Resource_Type := R_Object;               -- *< Individual object, see mt_rsrc_gaddr()
    R_TEDINFO            : constant Resource_Type := Text_Ed_Info;           -- *< TEDINFO structure, see mt_rsrc_gaddr()
    R_ICONBLK            : constant Resource_Type := Icon_Block;             -- *< ICONBLK structure, see mt_rsrc_gaddr()
    R_BITBLK             : constant Resource_Type := Bit_Block;              -- *< BITBLK structure, see mt_rsrc_gaddr()
    -- R_STRING          : constant Resource_Type := R_String;               -- *< Free String data, see mt_rsrc_gaddr()
    R_IMAGEDATA          : constant Resource_Type := Image_Data;             -- *< Free Image data, see mt_rsrc_gaddr()
    R_OBSPEC             : constant Resource_Type := Object_Spec;            -- *< ob_spec field within OBJECTs, see mt_rsrc_gaddr()
    R_TEPTEXT            : constant Resource_Type := Text_Pointer;           -- *< te_ptext within TEDINFOs, see mt_rsrc_gaddr()
    R_TEPTMPLT           : constant Resource_Type := Template_Pointer;       -- *< te_ptmplt within TEDINFOs, see mt_rsrc_gaddr()
    R_TEPVALID           : constant Resource_Type := Valid_Pointer;          -- *< te_pvalid within TEDINFOs, see mt_rsrc_gaddr()
    R_IBPMASK            : constant Resource_Type := Icon_Mask_Pointer;      -- *< ib_pmask within ICONBLKs, see mt_rsrc_gaddr()
    R_IBPDATA            : constant Resource_Type := Icon_Data_Pointer;      -- *< ib_pdata within ICONBLKs, see mt_rsrc_gaddr()
    R_IBPTEXT            : constant Resource_Type := Icon_Text_Pointer;      -- *< ib_ptext within ICONBLKs, see mt_rsrc_gaddr()
    R_BIPDATA            : constant Resource_Type := Bitmap_Data_Pointer;    -- *< bi_pdata within BITBLKs, see mt_rsrc_gaddr()
    R_FRSTR              : constant Resource_Type := Free_String;            -- *< Free string, see mt_rsrc_gaddr()
    R_FRIMG              : constant Resource_Type := Free_Image;             -- *< Free image, see mt_rsrc_gaddr()

    function rsrc_load(Name: const_chars_ptr) return Int16 renames Load;
    function rsrc_load(Name: String) return Int16 renames Load;
    function rsrc_free return int16 renames Free;
    function rsrc_gaddr(Typ: Resource_Type; Index: Int16; Addr: out void_ptr) return Int16 renames Get_Address;
    function rsrc_gaddr(Index: Int16) return Objects.AEStree_ptr renames Get_Address;
    function rsrc_gaddr(Index: Int16) return const_chars_ptr renames Get_Address;
    function rsrc_gaddr(Index: Int16) return Objects.BITBLK_ptr renames Get_Address;
    function rsrc_saddr(Typ: Resource_Type; Index: Int16; Addr: void_ptr) return Int16 renames Set_Address;
    procedure rsrc_obfix(tree: Objects.Object_Ptr; Index: Int16) renames Obfix;
    function rsrc_rcfix(rc_header: void_ptr) return Int16 renames Rcfix;


end Atari.Aes.Resource;
