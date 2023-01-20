with Interfaces;
with System;

package Atari is

    subtype int8 is Interfaces.Integer_8;
    subtype uint8 is Interfaces.Unsigned_8;
    subtype int16 is Interfaces.Integer_16;
    subtype uint16 is Interfaces.Unsigned_16;
    subtype int32 is Interfaces.Integer_32;
    subtype uint32 is Interfaces.Unsigned_32;
    subtype intptr is Interfaces.Integer_32;
    type short_ptr is access all int16;
    type const_short_ptr is access constant int16;
    type uint8_ptr is access all uint8;

    type char_array is array(Integer range <>) of aliased Character;

    type short_array is array(Integer range <>) of aliased int16;
    type short_array_ptr is access all short_array;

	type chars_ptr is access all Character;
	for chars_ptr'Size use Standard'Address_Size;
	pragma No_Strict_Aliasing (chars_ptr);

    type long_array is array(Integer range <>) of aliased int32;

    type const_chars_ptr is access constant Character;
	for const_chars_ptr'Size use Standard'Address_Size;
	pragma No_Strict_Aliasing (const_chars_ptr);
    type chars_ptr_array is array (integer range <>) of aliased chars_ptr;

    type void_ptr_ptr is access System.Address;

    function "not"(i: int16) return int16;
    function "or"(left: int16; right: int16) return int16;
    function "and"(left: int16; right: int16) return int16;
    function "xor"(left: int16; right: int16) return int16;

end Atari;
