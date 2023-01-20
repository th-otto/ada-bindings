package Atari.Aes.Window is

    function Draw(
                WindowHandle: int16;
                startob     : int16)
               return int16 renames wind_draw;

    function Create(
                Parts     : int16;
                Wx        : int16;
                Wy        : int16;
                Ww        : int16;
                Wh        : int16)
               return int16 renames wind_create;

    function Create(
                Parts     : int16;
                r         : in GRECT)
               return int16 renames wind_create;

    function Create(
                Parts     : int16;
                Wx        : int16;
                Wy        : int16;
                Ww        : int16;
                Wh        : int16;
                OutX      : out int16;
                OutY      : out int16;
                OutW      : out int16;
                OutH      : out int16)
               return int16 renames wind_create;

    function Open(
                WindowHandle: int16;
                Wx          : int16;
                Wy          : int16;
                Ww          : int16;
                Wh          : int16)
               return int16 renames wind_open;

    function Open(
                WindowHandle: int16;
                r           : in GRECT)
               return int16 renames wind_open;

    function Close(
                WindowHandle: int16)
               return int16 renames wind_close;

    function Delete(
                WindowHandle: int16)
               return int16 renames wind_delete;

    function Get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : out int16;
                W2          : out int16;
                W3          : out int16;
                W4          : out int16)
               return int16 renames wind_get;

    function Get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                r           : out GRECT)
               return int16 renames wind_get;

    function Get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                clip        : in GRECT;
                r           : out GRECT)
               return int16 renames wind_get;

    function Get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : out int16)
               return int16 renames wind_get;

    function Get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : chars_ptr)
               return int16 renames wind_get;

    function Set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : int16;
                W2          : int16;
                W3          : int16;
                W4          : int16)
               return int16 renames wind_set;

    function Set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                r           : in GRECT)
               return int16 renames wind_set;

    function Set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                s           : in GRECT;
                r           : out GRECT)
               return int16 renames wind_set;

    function Set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                str         : const_chars_ptr)
               return int16 renames wind_set;

    function Set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : int16 := 0)
               return int16 renames wind_set;

    function Set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                v           : System.Address;
                W3          : int16 := 0)
               return int16 renames wind_set;

    function Find(
                X         : int16;
                Y         : int16)
               return int16 renames wind_find;

    function Update(
                Code      : int16)
               return int16 renames wind_update;

    function Calc(
                c_Type    : int16;
                Parts     : int16;
                InX       : int16;
                InY       : int16;
                InW       : int16;
                InH       : int16;
                OutX      : out int16;
                OutY      : out int16;
                OutW      : out int16;
                OutH      : out int16)
               return int16 renames wind_calc;

    function Calc(
                c_Type    : int16;
                Parts     : int16;
                c_In      : in GRECT;
                c_Out     : out GRECT)
               return int16 renames wind_calc;

    -- procedure New renames wind_new;





end Atari.Aes.Window;
