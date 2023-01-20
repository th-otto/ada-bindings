package Atari.Aes.Filesel is

    function Input(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16)
               return int16 renames fsel_input;

    function Exinput(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr)
               return int16 renames fsel_exinput;

    function Boxinput(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr;
                callback   : FSEL_CALLBACK)
               return int16 renames fsel_boxinput;

end Atari.Aes.Filesel;
