package Atari.Aes.Graf is

    procedure Rubberbox(
                Ix        : int16;
                Iy        : int16;
                Iw        : int16;
                Ih        : int16;
                Fw        : out int16;
                Fh        : out int16) renames graf_rubberbox;

    procedure Rubberbox(
                r         : in GRECT;
                Fw        : out int16;
                Fh        : out int16) renames graf_rubberbox;

    procedure Dragbox(
                Sw        : int16;
                Sh        : int16;
                Sx        : int16;
                Sy        : int16;
                Bx        : int16;
                By        : int16;
                Bw        : int16;
                Bh        : int16;
                Fw        : out int16;
                Fh        : out int16) renames graf_dragbox;

    procedure Dragbox(
                little    : in GRECT;
                big       : in GRECT;
                Fw        : out int16;
                Fh        : out int16) renames graf_dragbox;

    procedure Movebox(
                Sw        : int16;
                Sh        : int16;
                Sx        : int16;
                Sy        : int16;
                Dx        : int16;
                Dy        : int16) renames graf_movebox;

    procedure Movebox(
                r         : in grect;
                Dx        : int16;
                Dy        : int16) renames graf_movebox;

    procedure Growbox(
                Sx        : int16;
                Sy        : int16;
                Sw        : int16;
                Sh        : int16;
                Fx        : int16;
                Fy        : int16;
                Fw        : int16;
                Fh        : int16) renames graf_growbox;

    procedure Growbox(
                little    : in GRECT;
                big       : in GRECT) renames graf_growbox;

    procedure Shrinkbox(
                Fx        : int16;
                Fy        : int16;
                Fw        : int16;
                Fh        : int16;
                Sx        : int16;
                Sy        : int16;
                Sw        : int16;
                Sh        : int16) renames graf_shrinkbox;

    procedure Shrinkbox(
                big       : in GRECT;
                little    : in GRECT) renames graf_shrinkbox;

    function Watchbox(
                tree      : OBJECT_ptr;
                Obj       : int16;
                InState   : int16;
                OutState  : int16)
               return int16 renames graf_watchbox;

    function Slidebox(
                tree      : OBJECT_ptr;
                Parent    : int16;
                Obj       : int16;
                Direction : int16)
               return int16 renames graf_slidebox;

    function Multirubber(
                bx        : int16;
                by        : int16;
                minw      : int16;
                minh      : int16;
                rec       : GRECT_ptr;
                rw        : out int16;
                rh        : out int16)
               return int16 renames graf_multirubber;

    function Handle(
                Wchar     : out int16;
                Hchar     : out int16;
                Wbox      : out int16;
                Hbox      : out int16)
               return int16 renames graf_handle;

    function Handle(
                Wchar     : out int16;
                Hchar     : out int16;
                Wbox      : out int16;
                Hbox      : out int16;
                device    : out int16)
               return int16 renames graf_handle;

    procedure Mouse(
                Form       : Mouse_Type;
                FormAddress: MFORM_const_ptr := null) renames graf_mouse;

    procedure Mkstate(
                Mx         : out int16;
                My         : out int16;
                ButtonState: out int16;
                KeyState   : out int16) renames graf_mkstate;

end Atari.Aes.Graf;
