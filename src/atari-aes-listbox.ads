package Atari.Aes.Listbox is

pragma Elaborate_Body;

    LBOX_VERT                : constant  := 1;                  -- *< Listbox with vertical slider
    LBOX_AUTO                : constant  := 2;                  -- *< Auto-scrolling
    LBOX_AUTOSLCT            : constant  := 4;                  -- *< Automatic display during auto-scrolling
    LBOX_REAL                : constant  := 8;                  -- *< Real-time slider
    LBOX_SNGL                : constant  := 16;                 -- *< Only a selectable entry
    LBOX_SHFT                : constant  := 32;                 -- *< Multi-selection with Shift
    LBOX_TOGGLE              : constant  := 64;                 -- *< Toggle status of an entry at selection
    LBOX_2SLDRS              : constant  := 128;                -- *< Listbox has a horiz. and a vertical slider

    type LIST_BOX is
        record
            inside: aliased char_array(0..119);
        end record;
    type LIST_BOX_ptr is access all LIST_BOX;

    type LBOX_ITEM;
    type LBOX_ITEM_ptr is access all LBOX_ITEM;
    type LBOX_ITEM is
        record
            next    : aliased LBOX_ITEM_ptr;
            selected: aliased int16;
            data1   : aliased int16;
            data2   : aliased System.Address;
            data3   : aliased System.Address;
        end record;

end Atari.Aes.Listbox;
