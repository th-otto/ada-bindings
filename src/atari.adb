with Interfaces;
use Interfaces;

package body Atari is

    function "not"(i: int16) return int16 is
    begin
    	return int16(not uint16(i));
    end "not";

    function "or"(left: int16; right: int16) return int16 is
    begin
    	return int16(uint16(left) or uint16(right));
    end "or";

    function "and"(left: int16; right: int16) return int16 is
    begin
    	return int16(uint16(left) and uint16(right));
    end "and";

    function "xor"(left: int16; right: int16) return int16 is
    begin
    	return int16(uint16(left) xor uint16(right));
    end "xor";

end Atari;
