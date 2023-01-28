package Atari.Aes.Clipboard is

    --  scrp_read return values
    SCRAP_CSV            : constant  := 16#1#;                  -- *< clipboard has a scrap.csv file, see mt_scrap_read()
    SCRAP_TXT            : constant  := 16#2#;                  -- *< clipboard has a scrap.txt file, see mt_scrap_read()
    SCRAP_GEM            : constant  := 16#4#;                  -- *< clipboard has a scrap.gem file, see mt_scrap_read()
    SCRAP_IMG            : constant  := 16#8#;                  -- *< clipboard has a scrap.img file, see mt_scrap_read()
    SCRAP_DCA            : constant  := 16#10#;                 -- *< clipboard has a scrap.dca file, see mt_scrap_read()
    SCRAP_DIF            : constant  := 16#20#;                 -- *< clipboard has a scrap.dif file, see mt_scrap_read()
    SCRAP_USR            : constant  := 16#8000#;               -- *< clipboard has a scrap.usr file, see mt_scrap_read()

    function Read(Scrappath: chars_ptr) return int16;
    function Write(Scrappath: const_chars_ptr) return int16;
    function Clear return boolean;


    function scrp_read(Scrappath: chars_ptr) return int16 renames Read;
    function scrp_write(Scrappath: const_chars_ptr) return int16 renames Write;
    function scrp_clear return boolean renames Clear;

end Atari.Aes.Clipboard;
