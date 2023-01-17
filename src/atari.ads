with Interfaces;

package Atari is

    subtype Int16 is Interfaces.Integer_16;
    subtype uint16 is Interfaces.Unsigned_16;
    subtype int32 is Interfaces.Integer_32;
    subtype uint32 is Interfaces.Unsigned_32;
    subtype intptr is Interfaces.Integer_32;
    type short_ptr is access all int16;
    type const_short_ptr is access constant int16;

    type short_array is array(Integer range <>) of aliased int16;
    type short_array_ptr is access all short_array;

    function "not"(i: int16) return int16;
    function "or"(left: int16; right: int16) return int16;
    function "and"(left: int16; right: int16) return int16;
    function "xor"(left: int16; right: int16) return int16;

end Atari;
