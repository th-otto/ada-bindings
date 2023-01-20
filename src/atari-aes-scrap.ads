package Atari.Aes.Scrap is

    function Read(
                Scrappath : chars_ptr)
               return int16 renames scrp_read;
    function Write(
                Scrappath : const_chars_ptr)
               return int16 renames scrp_write;

    function Clear return int16 renames scrp_clear;

end Atari.Aes.Scrap;
