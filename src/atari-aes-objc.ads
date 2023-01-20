package Atari.Aes.Objc is

    procedure Add(
                tree  : OBJECT_ptr;
                Parent: int16;
                Child : int16) renames objc_add;

    function Delete(
                tree      : OBJECT_ptr;
                Obj       : int16)
               return int16 renames objc_delete;

    procedure Draw(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Cx        : int16;
                Cy        : int16;
                Cw        : int16;
                Ch        : int16) renames objc_draw;

    procedure Draw(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                r         : in GRECT) renames objc_draw;

    function Find(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Mx        : int16;
                My        : int16)
               return int16 renames objc_find;

    procedure Offset(
                tree      : OBJECT_ptr;
                Obj       : int16;
                X         : out int16;
                Y         : out int16) renames objc_offset;

    function Order(
                tree      : OBJECT_ptr;
                Obj       : int16;
                NewPos    : int16)
               return int16 renames objc_order;

    function Edit(
                tree      : OBJECT_ptr;
                Obj       : int16;
                Kchar     : int16;
                Index     : in out int16;
                Kind      : int16)
               return int16 renames objc_edit;

    function Edit(
                tree      : OBJECT_ptr;
                Obj       : int16;
                Kchar     : int16;
                Index     : in out int16;
                Kind      : int16;
                r         : out GRECT)
               return int16 renames objc_edit;

    procedure Change(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Cx        : int16;
                Cy        : int16;
                Cw        : int16;
                Ch        : int16;
                NewState  : int16;
                Redraw    : int16) renames objc_change;

    procedure Change(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                r         : in GRECT;
                NewState  : int16;
                Redraw    : int16) renames objc_change;

    function Sysvar(
                mode      : int16;
                which     : int16;
                in1       : int16;
                in2       : int16;
                out1      : out int16;
                out2      : out int16)
               return int16 renames objc_sysvar;

    function Xfind(
                tree      : OBJECT_ptr;
                Start     : int16;
                Depth     : int16;
                Mx        : int16;
                My        : int16)
               return int16 renames objc_xfind;

end Atari.Aes.Objc;
