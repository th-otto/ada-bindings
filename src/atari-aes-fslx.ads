with Atari.Aes.Wdialog;

package Atari.Aes.Fslx is

	type XFSL_DIALOG is record null; end record;
    type XFSL_DIALOG_ptr is access all XFSL_DIALOG;

    DOSMODE                  : constant  := 1;
    NFOLLOWSLKS              : constant  := 2;
    GETMULTI                 : constant  := 8;

    SHOW8P3                  : constant  := 1;

    type XFSL_FILTER is access function(
                path : chars_ptr;
                name : chars_ptr;
                xattr: System.Address)
               return int16
    with Convention => C;

	type String_Array is array(Integer range <>) of String(1..256);
	
    function fslx_open(
                title    : in String;
                x        : int16;
                y        : int16;
                handle   : out int16;
                path     : in out String;
                pathlen  : int16;
                fname    : in out String;
                fnamelen : int16;
                patterns : in String_Array;
                filter   : XFSL_FILTER;
                paths    : in String_Array;
                sort_mode: int16;
                flags    : int16)
               return XFSL_DIALOG_ptr;

    function fslx_close(fsd: XFSL_DIALOG_ptr; x, y: out int16) return int16;

    function fslx_getnxtfile(fsd: XFSL_DIALOG_ptr; fname: out String) return boolean;

    function fslx_evnt(
                fsd      : XFSL_DIALOG_ptr;
                events   : Wdialog.EVNT_ptr;
                path     : in out String;
                fname    : in out String;
                button   : out int16;
                nfiles   : out int16;
                sort_mode: out int16;
                pattern  : out String)
               return boolean;

    function fslx_do(
                title    : in String;
                path     : in out String;
                pathlen  : int16;
                fname    : in out String;
                fnamelen : int16;
                patterns : in String_Array;
                filter   : XFSL_FILTER;
                paths    : in String_Array;
                sort_mode: in out int16;
                flags    : int16;
                button   : out int16;
                nfiles   : out int16;
                pattern  : out String)
               return XFSL_DIALOG_ptr;

    function fslx_set_flags(
                flags : int16;
                oldval: out int16)
               return boolean;


end Atari.Aes.Fslx;
