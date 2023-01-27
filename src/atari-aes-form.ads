with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Form is

    function Run(
                tree      : Objects.Object_Ptr;
                StartObj  : int16)
               return int16;

    function Dial(
                Flag      : int16;
                Sx        : int16;
                Sy        : int16;
                Sw        : int16;
                Sh        : int16;
                Bx        : int16;
                By        : int16;
                Bw        : int16;
                Bh        : int16)
               return int16;

    function Dial(
                Flag      : int16;
                little    : in GRECT;
                big       : in GRECT)
               return int16;

    function Alert(fo_adefbttn: int16; alertstr: String) return int16;
    function Alert(fo_adefbttn: int16; alertstr: const_chars_ptr) return int16;

    function Error(ErrorCode: int16) return int16;

    function Error(ErrorCode: int32; filename: String) return int16;

    function Center(
                tree      : Objects.Object_Ptr;
                Cx        : out int16;
                Cy        : out int16;
                Cw        : out int16;
                Ch        : out int16)
               return int16;

    function Center(
                tree      : Objects.Object_Ptr;
                r         : out GRECT)
               return int16;

    function Keybd(
                tree      : Objects.Object_Ptr;
                Kobject   : int16;
                Kobnext   : int16;
                Kchar     : int16;
                Knxtobject: out int16;
                Knxtchar  : out int16)
               return int16;

    function Button(
                tree      : Objects.Object_Ptr;
                Bobject   : int16;
                Bclicks   : int16;
                Bnxtobj   : out int16)
               return int16;

	--  old C-style names
    function form_do(
                tree      : Objects.Object_Ptr;
                StartObj  : int16)
               return int16 renames Run;

    function form_dial(
                Flag      : int16;
                Sx        : int16;
                Sy        : int16;
                Sw        : int16;
                Sh        : int16;
                Bx        : int16;
                By        : int16;
                Bw        : int16;
                Bh        : int16)
               return int16 renames Dial;

    function form_dial(
                Flag      : int16;
                little    : in Rectangle;
                big       : in Rectangle)
               return int16 renames Dial;

    function form_alert(fo_adefbttn: int16; alertstr: String) return int16 renames Alert;
    function form_alert(fo_adefbttn: int16; alertstr: const_chars_ptr) return int16 renames Alert;

    function form_error(ErrorCode: int16) return int16 renames Error;

    function form_error(ErrorCode: int32; filename: String) return int16 renames Error;

    function form_center(
                tree      : Objects.Object_Ptr;
                Cx        : out int16;
                Cy        : out int16;
                Cw        : out int16;
                Ch        : out int16)
               return int16 renames Center;

    function form_center(
                tree      : Objects.Object_Ptr;
                r         : out Rectangle)
               return int16 renames Center;

    function form_keybd(
                tree      : Objects.Object_Ptr;
                Kobject   : int16;
                Kobnext   : int16;
                Kchar     : int16;
                Knxtobject: out int16;
                Knxtchar  : out int16)
               return int16 renames Keybd;

    function form_button(
                tree      : Objects.Object_Ptr;
                Bobject   : int16;
                Bclicks   : int16;
                Bnxtobj   : out int16)
               return int16 renames Button;


end Atari.Aes.Form;
