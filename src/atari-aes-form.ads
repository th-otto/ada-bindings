with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Form is

    FA_NOICON            : constant String := "[0]";            -- *< display no icon, see mt_form_alert()
    FA_ERROR             : constant String := "[1]";            -- *< display Exclamation icon, see mt_form_alert()
    FA_QUESTION          : constant String := "[2]";            -- *< display Question icon, see mt_form_alert()
    FA_STOP              : constant String := "[3]";            -- *< display Stop icon, see mt_form_alert()
    FA_INFO              : constant String := "[4]";            -- *< display Info icon, see mt_form_alert()
    FA_DISK              : constant String := "[5]";            -- *< display Disk icon, see mt_form_alert()

    --  Form dialog space actions, as used by form_dial()
    FMD_START            : constant  := 0;                      -- *< reserves the screen space for a dialog, see mt_form_dial()
    FMD_GROW             : constant  := 1;                      -- *< draws an expanding box, see mt_form_dial()
    FMD_SHRINK           : constant  := 2;                      -- *< draws a shrinking box, see mt_form_dial()
    FMD_FINISH           : constant  := 3;                      -- *< releases the screen space for a dialog, see mt_form_dial()

    FERR_FILENOTFOUND    : constant  := 2;                      -- *< File Not Found (GEMDOS error -33), see mt_form_error()
    FERR_PATHNOTFOUND    : constant  := 3;                      -- *< Path Not Found (GEMDOS error -34), see mt_form_error()
    FERR_NOHANDLES       : constant  := 4;                      -- *< No More File Handles (GEMDOS error -35), see mt_form_error()
    FERR_ACCESSDENIED    : constant  := 5;                      -- *< Access Denied (GEMDOS error -36), see mt_form_error()
    FERR_LOWMEM          : constant  := 8;                      -- *< Insufficient Memory (GEMDOS error -39), see mt_form_error()
    FERR_BADENVIRON      : constant  := 10;                     -- *< Invalid Environment (GEMDOS error -41), see mt_form_error()
    FERR_BADFORMAT       : constant  := 11;                     -- *< Invalid Format (GEMDOS error -42)
    FERR_BADDRIVE        : constant  := 15;                     -- *< Invalid Drive Specification (GEMDOS error -46), see mt_form_error()
    FERR_DELETEDIR       : constant  := 16;                     -- *< Attempt To Delete Working Directory (GEMDOS error -47), see mt_form_error()
    FERR_NOFILES         : constant  := 18;                     -- *< No More Files (GEMDOS error -49), see mt_form_error()

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
                little    : in Rectangle;
                big       : in Rectangle)
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
                r         : out Rectangle)
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
