package Atari.Aes.Filesel is

    FSEL_CANCEL          : constant  := 0;                      -- *< the fileselector has been closed by using the CANCEL button, see mt_fsel_exinput()
    FSEL_OK              : constant  := 1;                      -- *< the fileselector has been closed by using the OK button, see mt_fsel_exinput()

    --  callback function used by BoxKite file selector. See fsel_boxinput()
    type FSEL_CALLBACK is access procedure(msg: access int16);
    pragma Convention(C, FSEL_CALLBACK);

    function Input(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16)
               return boolean;

	--  fsel_exinput
    function Input(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr)
               return boolean;

	--  fsel_boxinput
    function Input(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr;
                callback   : FSEL_CALLBACK)
               return boolean;

	--  old C-style names
    function fsel_input(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16)
               return boolean renames Input;

    function fsel_input(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr)
               return boolean renames Input;

    function fsel_boxinput(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr;
                callback   : FSEL_CALLBACK)
               return boolean Renames Input;

end Atari.Aes.Filesel;
