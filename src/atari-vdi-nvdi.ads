package Atari.Vdi.Nvdi is

	subtype fix31 is int32;

	function fix31_to_point(fix: fix31) return int16;
	function point_to_fix31(point: int16) return fix31;

end Atari.Vdi.Nvdi;
