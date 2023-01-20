package Atari.Aes.Shell is

    function Read(
                Command   : chars_ptr;
                Tail      : chars_ptr)
               return int16 renames shel_read;

    function Write(
                c_Exit    : int16;
                Graphic   : int16;
                Aes       : int16;
                Command   : System.Address;
                Tail      : chars_ptr)
               return int16 renames shel_write;

    function Get(
                Buf       : chars_ptr;
                Len       : int16)
               return int16 renames shel_get;

    function Put(
                Buf       : chars_ptr;
                Len       : int16)
               return int16 renames shel_put;

    function Find(
                buf       : chars_ptr)
               return int16 renames shel_find;

    function Environ(
                result    : out chars_ptr;
                param     : chars_ptr)
               return int16 renames shel_envrn;

    procedure Rdef(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr) renames shel_rdef;

    procedure Wdef(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr) renames shel_wdef;

    function Help(
                sh_hmode  : int16;
                sh_hfile  : chars_ptr;
                sh_hkey   : chars_ptr)
               return int16 renames shel_help;

end Atari.Aes.Shell;
