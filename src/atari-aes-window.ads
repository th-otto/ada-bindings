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




end Atari.Aes.Window;
