with Atari.Aes.Wdialog;
with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Listbox is

    LBOX_VERT                : constant  := 1;                  -- *< Listbox with vertical slider
    LBOX_AUTO                : constant  := 2;                  -- *< Auto-scrolling
    LBOX_AUTOSLCT            : constant  := 4;                  -- *< Automatic display during auto-scrolling
    LBOX_REAL                : constant  := 8;                  -- *< Real-time slider
    LBOX_SNGL                : constant  := 16;                 -- *< Only a selectable entry
    LBOX_SHFT                : constant  := 32;                 -- *< Multi-selection with Shift
    LBOX_TOGGLE              : constant  := 64;                 -- *< Toggle status of an entry at selection
    LBOX_2SLDRS              : constant  := 128;                -- *< Listbox has a horiz. and a vertical slider

    type Listbox is
        record
            inside: aliased char_array(0..119);
        end record;
    type Listbox_Ptr is access all Listbox;

    type Listbox_Item;
    type Listbox_Item_Ptr is access all Listbox_Item;
    type Listbox_Item is
        record
            next    : aliased Listbox_Item_Ptr;
            selected: aliased Int16;
            data1   : aliased Int16;
            data2   : aliased void_ptr;
            data3   : aliased void_ptr;
        end record;

    type Select_Item_Args is
        record
            box       : aliased Listbox_Ptr;
            tree      : aliased Objects.Object_Ptr;
            item      : aliased Listbox_Item_Ptr;
            user_data : aliased void_ptr;
            obj_index : aliased Int16;
            last_state: aliased Int16;
        end record;

    type Select_Item is access procedure(p1: Select_Item_Args);
    pragma Convention(C, Select_Item);

    type Set_Item_Args is
        record
            box      : aliased Listbox_Ptr;
            tree     : aliased Objects.Object_Ptr;
            item     : aliased Listbox_Item_Ptr;
            obj_index: aliased Int16;
            user_data: aliased void_ptr;
            rect     : aliased Rectangle_Ptr;
            first    : aliased Int16;
        end record;

    type Set_Item is access function(p1: Set_Item_Args) return Int16;
    pragma Convention(C, Set_Item);

    function Create(
                tree     : Objects.Object_Ptr;
                slct     : Select_Item;
                set      : Set_Item;
                items    : Listbox_Item_Ptr;
                visible_a: Int16;
                first_a  : Int16;
                ctrl_objs: in short_array;
                objs     : in short_array;
                flags    : Int16;
                pause_a  : Int16;
                user_data: void_ptr;
                dialog   : Wdialog.DIALOG_ptr;
                visible_b: Int16;
                first_b  : Int16;
                entries_b: Int16;
                pause_b  : Int16)
               return Listbox_Ptr;

    procedure Update(box: Listbox_Ptr; rect: in Rectangle);

    function Run(box: Listbox_Ptr; Obj: Int16) return Int16;

    procedure Delete(box: Listbox_Ptr);

    function Count_Items(box: Listbox_Ptr) return Int16;

    function Get_Tree(box: Listbox_Ptr) return Objects.Object_Ptr;

    function Get_A_Visible(box: Listbox_Ptr) return Int16;

    function Get_User_Data(box: Listbox_Ptr) return void_ptr;

    function Get_A_First(box: Listbox_Ptr) return Int16;

    function Get_Select_Index(box: Listbox_Ptr) return Int16;

    function Get_Items(box: Listbox_Ptr) return Listbox_Item_Ptr;

    function Get_Item(box: Listbox_Ptr; n: Int16) return Listbox_Item_Ptr;

    function Get_Select_Item(box: Listbox_Ptr) return Listbox_Item_Ptr;

    function Get_Index(items: Listbox_Item_Ptr; search: Listbox_Item_Ptr) return Int16;

    function Get_B_Visible(box: Listbox_Ptr) return Int16;

    function Get_B_Entries(box: Listbox_Ptr) return Int16;

    function Get_B_First(box: Listbox_Ptr) return Int16;

    procedure Set_A_Slider(box: Listbox_Ptr; first: Int16; rect: in Rectangle);

    procedure Set_Items(box: Listbox_Ptr; items: Listbox_Item_Ptr);

    procedure Free_Items(box: Listbox_Ptr);

    procedure Free_List(items: Listbox_Item_Ptr);

    procedure A_Scroll_To(box: Listbox_Ptr; first: Int16; box_rect: in Rectangle; slider_rect: in Rectangle);

    procedure Set_B_Slider(box: Listbox_Ptr; first: Int16; rect: in Rectangle);

    procedure Set_B_Entries(box: Listbox_Ptr; entries: Int16);

    procedure B_Scroll_To(box: Listbox_Ptr; first: Int16; box_rect: in Rectangle; slider_rect: in Rectangle);


    --  alternative names for listboxes with only one slider
    function Get_Visible(box: Listbox_Ptr) return Int16
        renames Get_A_Visible;
    function Get_First(box: Listbox_Ptr) return Int16
        renames Get_A_First;
    procedure Set_Slider(box: Listbox_Ptr; first: Int16; rect: in Rectangle)
        renames Set_A_Slider;
    procedure Scroll_To(box: Listbox_Ptr; first: Int16; box_rect: in Rectangle; slider_rect: in Rectangle)
        renames A_Scroll_To;


    --  old C-style names
    function lbox_create(
                tree     : Objects.Object_Ptr;
                slct     : Select_Item;
                set      : Set_Item;
                items    : Listbox_Item_Ptr;
                visible_a: Int16;
                first_a  : Int16;
                ctrl_objs: in short_array;
                objs     : in short_array;
                flags    : Int16;
                pause_a  : Int16;
                user_data: void_ptr;
                dialog   : Wdialog.DIALOG_ptr;
                visible_b: Int16;
                first_b  : Int16;
                entries_b: Int16;
                pause_b  : Int16)
               return Listbox_Ptr
             renames Create;

    procedure lbox_update(box: Listbox_Ptr; rect: in Rectangle)
        renames Update;

    function lbox_do(box: Listbox_Ptr; Obj: Int16) return Int16
        renames Run;

    procedure lbox_delete(box: Listbox_Ptr)
        renames Delete;

    function lbox_cnt_items(box: Listbox_Ptr) return Int16
        renames Count_Items;

    function lbox_get_tree(box: Listbox_Ptr) return Objects.Object_Ptr
        renames Get_Tree;

    function lbox_get_avis(box: Listbox_Ptr) return Int16
        renames Get_A_Visible;

    function lbox_get_udata(box: Listbox_Ptr) return void_ptr
        renames Get_User_Data;

    function lbox_get_afirst(box: Listbox_Ptr) return Int16
        renames Get_A_First;

    function lbox_get_slct_idx(box: Listbox_Ptr) return Int16
        renames Get_Select_Index;

    function lbox_get_items(box: Listbox_Ptr) return Listbox_Item_Ptr
        renames Get_Items;

    function lbox_get_item(box: Listbox_Ptr; n: Int16) return Listbox_Item_Ptr
        renames Get_Item;

    function lbox_get_slct_item(box: Listbox_Ptr) return Listbox_Item_Ptr
        renames Get_Select_Item;

    function lbox_get_idx(items: Listbox_Item_Ptr; search: Listbox_Item_Ptr) return Int16
        renames Get_Index;

    function lbox_get_bvis(box: Listbox_Ptr) return Int16
        renames Get_B_Visible;

    function lbox_get_bentries(box: Listbox_Ptr) return Int16
        renames Get_B_Entries;

    function lbox_get_bfirst(box: Listbox_Ptr) return Int16
        renames Get_B_First;

    procedure lbox_set_asldr(box: Listbox_Ptr; first: Int16; rect: in Rectangle)
        renames Set_A_Slider;

    procedure lbox_set_items(box: Listbox_Ptr; items: Listbox_Item_Ptr)
        renames Set_Items;

    procedure lbox_free_items(box: Listbox_Ptr)
        renames Free_Items;

    procedure lbox_free_list(items: Listbox_Item_Ptr)
        renames Free_List;

    procedure lbox_ascroll_to(box: Listbox_Ptr; first: Int16; box_rect: in Rectangle; slider_rect: in Rectangle)
        renames A_Scroll_To;

    procedure lbox_set_bsldr(box: Listbox_Ptr; first: Int16; rect: in Rectangle)
        renames Set_B_Slider;

    procedure lbox_set_bentries(box: Listbox_Ptr; entries: Int16)
        renames Set_B_Entries;

    procedure lbox_bscroll_to(box: Listbox_Ptr; first: Int16; box_rect: in Rectangle; slider_rect: in Rectangle)
        renames B_Scroll_To;

end Atari.Aes.Listbox;
