package Atari.Aes.Form is

    function aDo(
                tree      : OBJECT_ptr;
                StartObj  : int16)
               return int16 renames form_do;

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
               return int16 renames form_dial;

    function Dial(
                Flag      : int16;
                little    : in GRECT;
                big       : in GRECT)
               return int16 renames form_dial;

    function Error(
                ErrorCode : int16)
               return int16 renames form_error;

    function Error(
                ErrorCode : int32;
                filename: String)
               return int16 renames form_error;

    function Center(
                tree      : OBJECT_ptr;
                Cx        : out int16;
                Cy        : out int16;
                Cw        : out int16;
                Ch        : out int16)
               return int16 renames form_center;

    function Center(
                tree      : OBJECT_ptr;
                r         : out GRECT)
               return int16 renames form_center;

    function Keybd(
                tree      : OBJECT_ptr;
                Kobject   : int16;
                Kobnext   : int16;
                Kchar     : int16;
                Knxtobject: out int16;
                Knxtchar  : out int16)
               return int16 renames form_keybd;

    function Button(
                tree      : OBJECT_ptr;
                Bobject   : int16;
                Bclicks   : int16;
                Bnxtobj   : out int16)
               return int16 renames form_button;

end Atari.Aes.Form;
