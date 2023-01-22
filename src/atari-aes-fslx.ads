package Atari.Aes.Fslx is

pragma Elaborate_Body;

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

end Atari.Aes.Fslx;
