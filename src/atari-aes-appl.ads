package Atari.Aes.Appl is

    function Init return int16 renames appl_init;
    procedure aExit renames appl_exit;
    function Read(
                ap_id     : int16;
                length    : int16;
                ap_pbuff  : System.Address)
               return int16 renames appl_read;
    function Write(
                ap_id     : int16;
                length    : int16;
                ap_pbuff  : System.Address)
               return int16 renames appl_write;
    function Write(
                ap_id     : int16;
                length    : int16;
                ap_pbuff  : array_8_ptr)
               return int16 renames appl_write;
    function Find(name: chars_ptr) return int16 renames appl_find;
    function Find(name: String) return int16 renames appl_find;
    procedure Tplay(
                mem       : System.Address;
                num       : int16;
                scale     : int16) renames appl_tplay;
    function Trecord(
                mem       : System.Address;
                count     : int16)
               return int16 renames appl_trecord;
    function Bvset(
                bvdisk    : int16;
                bvhard    : int16)
               return int16 renames appl_bvset;
    procedure Yield renames appl_yield;
    function Search(
                mode      : int16;
                fname     : chars_ptr;
                c_type    : out int16;
                ap_id     : out int16)
               return int16 renames appl_search;
    function Search(
                mode      : int16;
                fname     : String;
                c_type    : out int16;
                ap_id     : out int16)
               return int16 renames appl_search;
    function Control(
                ap_cid    : int16;
                ap_cwhat  : int16;
                ap_cout   : System.Address)
               return int16 renames appl_control;
    function Getinfo(
                c_type    : int16;
                out1      : out int16;
                out2      : out int16;
                out3      : out int16;
                out4      : out int16)
               return int16 renames appl_getinfo;
    function Xgetinfo(
                c_type    : int16;
                out1      : out int16;
                out2      : out int16;
                out3      : out int16;
                out4      : out int16)
               return int16 renames appl_xgetinfo;
    function Getinfo(
                c_type    : int16;
                out1      : chars_ptr;
                out2      : chars_ptr;
                out3      : chars_ptr;
                out4      : chars_ptr)
               return int16 renames appl_getinfo;

end Atari.Aes.Appl;
