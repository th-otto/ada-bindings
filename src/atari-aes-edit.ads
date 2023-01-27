with Atari.Aes.Objects;
with Atari.Aes.Wdialog;
use Atari;

package Atari.Aes.Edit is

    type Editinfo is private;
    type Editinfo_Ptr is access all Editinfo;

    function Create return Editinfo_Ptr;

    function Open(tree: Objects.Object_Ptr; Obj: int16) return boolean;

    procedure Close(tree: Objects.Object_Ptr; Obj: int16);

    procedure Delete(x: Editinfo_ptr);

    function Cursor(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                whdl  : int16;
                show  : int16)
               return int16;

    function Event(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                whdl  : int16;
                ev    : Wdialog.EVNT_ptr;
                errc  : out int32)
               return int16;

    function Get_Buffer(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                buf   : out chars_ptr;
                buflen: out int32;
                txtlen: out int32)
               return boolean;

    function Get_Format(
                tree    : Objects.Object_Ptr;
                Obj     : int16;
                tabwidth: out int16;
                autowrap: out int16)
               return boolean;

    function Get_Color(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                tcolor: out int16;
                bcolor: out int16)
               return boolean;

    function Get_Font(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                fontID : out int16;
                fontH  : out int16;
                fontPix: out int16;
                mono   : out int16)
               return boolean;

    function Get_Cursor(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                cursorpos: out chars_ptr)
               return boolean;

    procedure Get_Pos(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                xscroll  : out int16;
                yscroll  : out int32;
                cyscroll : out chars_ptr;
                cursorpos: out chars_ptr;
                cx       : out int16;
                cy       : out int16);

    function Get_Dirty(
                tree  : Objects.Object_Ptr;
                Obj   : int16)
               return boolean;

    procedure Get_Sel(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                bsel  : out chars_ptr;
                esel  : out chars_ptr);

    procedure Get_Scrollinfo(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                nlines : out int32;
                yscroll: out int32;
                yvis   : out int16;
                yval   : out int16;
                ncols  : out int16;
                xscroll: out int16;
                xvis   : out int16);

    procedure Set_Buffer(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                buf   : chars_ptr;
                buflen: int32);

    procedure Set_Format(
                tree    : Objects.Object_Ptr;
                Obj     : int16;
                tabwidth: int16;
                autowrap: int16);

    procedure Set_Color(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                tcolor: int16;
                bcolor: int16);

    procedure Set_Font(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                fontID : int16;
                fontH  : int16;
                fontPix: int16;
                mono   : int16);

    function Set_Cursor(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                cursorpos: chars_ptr) return boolean;

    procedure Set_Pos(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                xscroll  : int16;
                yscroll  : int32;
                cyscroll : chars_ptr;
                cursorpos: chars_ptr;
                cx       : int16;
                cy       : int16);

    function Resized(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                oldrh : out int16;
                newrh : out int16)
               return boolean;

    procedure Set_Dirty(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                dirty : boolean);

    function Scroll(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                whdl   : int16;
                yscroll: int32;
                xscroll: int16)
               return boolean;




    function edit_create return Editinfo_Ptr renames Create;

    function edit_open(tree: Objects.OBJECT_ptr; Obj: int16) return boolean renames Open;

    procedure edit_close(tree: Objects.Object_Ptr; Obj: int16) renames Close;

    procedure edit_delete(x: Editinfo_ptr) renames Delete;

    function edit_cursor(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                whdl  : int16;
                show  : int16)
               return int16 renames Cursor;

    function edit_evnt(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                whdl  : int16;
                ev    : Wdialog.EVNT_ptr;
                errc  : out int32)
               return int16 renames Event;

    function edit_get_buf(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                buf   : out chars_ptr;
                buflen: out int32;
                txtlen: out int32)
               return boolean renames Get_Buffer;

    function edit_get_format(
                tree    : Objects.Object_Ptr;
                Obj     : int16;
                tabwidth: out int16;
                autowrap: out int16)
               return boolean renames Get_Format;

    function edit_get_colour(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                tcolor: out int16;
                bcolor: out int16)
               return boolean renames Get_Color;

    function edit_get_font(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                fontID : out int16;
                fontH  : out int16;
                fontPix: out int16;
                mono   : out int16)
               return boolean renames Get_Font;

    function edit_get_cursor(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                cursorpos: out chars_ptr)
               return boolean renames Get_Cursor;

    procedure edit_get_pos(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                xscroll  : out int16;
                yscroll  : out int32;
                cyscroll : out chars_ptr;
                cursorpos: out chars_ptr;
                cx       : out int16;
                cy       : out int16) renames Get_Pos;

    function edit_get_dirty(
                tree  : Objects.Object_Ptr;
                Obj   : int16)
               return boolean renames Get_Dirty;

    procedure edit_get_sel(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                bsel  : out chars_ptr;
                esel  : out chars_ptr) renames Get_Sel;

    procedure edit_get_scrollinfo(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                nlines : out int32;
                yscroll: out int32;
                yvis   : out int16;
                yval   : out int16;
                ncols  : out int16;
                xscroll: out int16;
                xvis   : out int16) renames Get_Scrollinfo;

    procedure edit_set_buf(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                buf   : chars_ptr;
                buflen: int32) renames Set_Buffer;

    procedure edit_set_format(
                tree    : Objects.Object_Ptr;
                Obj     : int16;
                tabwidth: int16;
                autowrap: int16) renames Set_Format;


    procedure edit_set_color(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                tcolor: int16;
                bcolor: int16) renames Set_Color;


    procedure edit_set_font(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                fontID : int16;
                fontH  : int16;
                fontPix: int16;
                mono   : int16) renames Set_Font;

    function edit_set_cursor(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                cursorpos: chars_ptr) return boolean renames Set_Cursor;

    procedure edit_set_pos(
                tree     : Objects.Object_Ptr;
                Obj      : int16;
                xscroll  : int16;
                yscroll  : int32;
                cyscroll : chars_ptr;
                cursorpos: chars_ptr;
                cx       : int16;
                cy       : int16) renames Set_Pos;

    function edit_resized(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                oldrh : out int16;
                newrh : out int16)
               return boolean renames Resized;

    procedure edit_set_dirty(
                tree  : Objects.Object_Ptr;
                Obj   : int16;
                dirty : boolean) renames Set_Dirty;

    function edit_scroll(
                tree   : Objects.Object_Ptr;
                Obj    : int16;
                whdl   : int16;
                yscroll: int32;
                xscroll: int16)
               return boolean renames Scroll;

private
    type Editinfo is record null; end record;

end Atari.Aes.Edit;
