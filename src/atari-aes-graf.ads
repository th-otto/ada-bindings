with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Graf is

    procedure Rubber_Box(
                Ix        : Int16;
                Iy        : Int16;
                Iw        : Int16;
                Ih        : Int16;
                Fw        : out Int16;
                Fh        : out Int16);

    procedure Rubber_Box(
                r         : in Rectangle;
                Fw        : out Int16;
                Fh        : out Int16);

    procedure Drag_Box(
                Sw        : Int16;
                Sh        : Int16;
                Sx        : Int16;
                Sy        : Int16;
                Bx        : Int16;
                By        : Int16;
                Bw        : Int16;
                Bh        : Int16;
                Fw        : out Int16;
                Fh        : out Int16);

    procedure Drag_Box(
                little    : in Rectangle;
                big       : in Rectangle;
                Fw        : out Int16;
                Fh        : out Int16);

    procedure Move_Box(
                Sw        : Int16;
                Sh        : Int16;
                Sx        : Int16;
                Sy        : Int16;
                Dx        : Int16;
                Dy        : Int16);

    procedure Move_Box(
                r         : in Rectangle;
                Dx        : Int16;
                Dy        : Int16);

    procedure Grow_Box(
                Sx        : Int16;
                Sy        : Int16;
                Sw        : Int16;
                Sh        : Int16;
                Fx        : Int16;
                Fy        : Int16;
                Fw        : Int16;
                Fh        : Int16);

    procedure Grow_Box(
                little    : in Rectangle;
                big       : in Rectangle);

    procedure Shrink_Box(
                Fx        : Int16;
                Fy        : Int16;
                Fw        : Int16;
                Fh        : Int16;
                Sx        : Int16;
                Sy        : Int16;
                Sw        : Int16;
                Sh        : Int16);

    procedure Shrink_Box(
                big       : in Rectangle;
                little    : in Rectangle);

    function Watch_Box(
                tree      : Objects.Object_Ptr;
                Obj       : Int16;
                InState   : Int16;
                OutState  : Int16)
               return Int16;

    function Slide_Box(
                tree      : Objects.Object_Ptr;
                Parent    : Int16;
                Obj       : Int16;
                Direction : Int16)
               return Int16;

    function Multirubber(
                bx        : Int16;
                by        : Int16;
                minw      : Int16;
                minh      : Int16;
                rec       : Rectangle_Ptr;
                rw        : out Int16;
                rh        : out Int16)
               return Int16;

    function Handle(
                Wchar     : out Int16;
                Hchar     : out Int16;
                Wbox      : out Int16;
                Hbox      : out Int16)
               return Int16;

    function Handle(
                Wchar     : out Int16;
                Hchar     : out Int16;
                Wbox      : out Int16;
                Hbox      : out Int16;
                device    : out Int16)
               return Int16;

    procedure Mouse(
                Form       : Mouse_Type;
                FormAddress: MFORM_const_ptr := null);

    procedure Mkstate(
                Mx         : out Int16;
                My         : out Int16;
                ButtonState: out Int16;
                KeyState   : out Int16);



    --  old C-style names
    procedure graf_rubberbox(
                Ix        : Int16;
                Iy        : Int16;
                Iw        : Int16;
                Ih        : Int16;
                Fw        : out Int16;
                Fh        : out Int16) renames Rubber_Box;

    procedure graf_rubberbox(
                r         : in Rectangle;
                Fw        : out Int16;
                Fh        : out Int16) renames Rubber_Box;

    procedure graf_dragbox(
                Sw        : Int16;
                Sh        : Int16;
                Sx        : Int16;
                Sy        : Int16;
                Bx        : Int16;
                By        : Int16;
                Bw        : Int16;
                Bh        : Int16;
                Fw        : out Int16;
                Fh        : out Int16) renames Drag_Box;

    procedure graf_dragbox(
                little    : in Rectangle;
                big       : in Rectangle;
                Fw        : out Int16;
                Fh        : out Int16) renames Drag_Box;

    procedure graf_movebox(
                Sw        : Int16;
                Sh        : Int16;
                Sx        : Int16;
                Sy        : Int16;
                Dx        : Int16;
                Dy        : Int16) renames Move_Box;

    procedure graf_movebox(
                r         : in grect;
                Dx        : Int16;
                Dy        : Int16) renames Move_Box;


    procedure graf_growbox(
                Sx        : Int16;
                Sy        : Int16;
                Sw        : Int16;
                Sh        : Int16;
                Fx        : Int16;
                Fy        : Int16;
                Fw        : Int16;
                Fh        : Int16) renames Grow_Box;

    procedure graf_growbox(
                little    : in Rectangle;
                big       : in Rectangle) renames Grow_Box;

    procedure graf_shrinkbox(
                Fx        : Int16;
                Fy        : Int16;
                Fw        : Int16;
                Fh        : Int16;
                Sx        : Int16;
                Sy        : Int16;
                Sw        : Int16;
                Sh        : Int16) renames Shrink_Box;

    procedure graf_shrinkbox(
                big       : in Rectangle;
                little    : in Rectangle) renames Shrink_Box;

    function graf_watchbox(
                tree      : Objects.Object_Ptr;
                Obj       : Int16;
                InState   : Int16;
                OutState  : Int16)
               return Int16 renames Watch_Box;

    function graf_slidebox(
                tree      : Objects.Object_Ptr;
                Parent    : Int16;
                Obj       : Int16;
                Direction : Int16)
               return Int16 renames Slide_Box;

    function graf_multirubber(
                bx        : Int16;
                by        : Int16;
                minw      : Int16;
                minh      : Int16;
                rec       : Rectangle_Ptr;
                rw        : out Int16;
                rh        : out Int16)
               return Int16 renames Multirubber;

    function graf_handle(
                Wchar     : out Int16;
                Hchar     : out Int16;
                Wbox      : out Int16;
                Hbox      : out Int16)
               return Int16 renames Handle;

    function graf_handle(
                Wchar     : out Int16;
                Hchar     : out Int16;
                Wbox      : out Int16;
                Hbox      : out Int16;
                device    : out Int16)
               return Int16 renames Handle;

    procedure graf_mouse(
                Form       : Mouse_Type;
                FormAddress: MFORM_const_ptr := null) renames Mouse;

    procedure graf_mkstate(
                Mx         : out Int16;
                My         : out Int16;
                ButtonState: out Int16;
                KeyState   : out Int16) renames Mkstate;


end Atari.Aes.Graf;
