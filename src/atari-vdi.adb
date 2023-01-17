pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;

package body Atari.Vdi is

vdi_control: aliased VDIContrl;
vdi_intin: aliased VDIIntIn;
vdi_ptsin: aliased VDIPtsIn;
vdi_intout: aliased VDIIntOut;
vdi_ptsout: aliased VDIPtsOut;


vdi_pb: aliased VDIPB := (
    control => vdi_control'Access,
    intin => vdi_intin'Access,
    ptsin => vdi_ptsin'Access,
    intout => vdi_intout'Access,
    ptsout => vdi_ptsout'Access
);


procedure vdi(pb: VDIPB_ptr) is
    use ASCII;
    function to_address is new Ada.Unchecked_Conversion(VDIPB_ptr, System.Address);
begin
    asm("move.l %0,%%d1" & LF & HT &
        "move.w #115,%%d0" & LF & HT &
        "trap #2" & LF & HT,
        volatile => true,
        inputs => System.Address'Asm_Input("g", to_address(pb)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
end;


procedure vdi_trap is
begin
    vdi(vdi_pb'Access);
end;


procedure v_circle(
            handle: VdiHdl;
            x     : int16;
            y     : int16;
            radius: int16) is
begin
	vdi_control.opcode := 11;
	vdi_control.num_ptsin := 3;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 4;
	vdi_control.handle := handle;

	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := 0;
	vdi_ptsin(3) := 0;
	vdi_ptsin(4) := radius;
	vdi_ptsin(5) := 0;
	vdi_trap;
end;


procedure v_ellipse(
            handle: VdiHdl;
            x   : int16;
            y   : int16;
            xradius: int16;
            yradius: int16) is
begin
	vdi_control.opcode := 11;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 5;
	vdi_control.handle := handle;

	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := xradius;
	vdi_ptsin(3) := yradius;
	vdi_trap;
end;


function vsf_interior(
            handle : VdiHdl;
            style: int16)
           return int16 is
begin
	vdi_control.opcode := 23;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := style;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vsf_style(
            handle : VdiHdl;
            style: int16)
           return int16 is
begin
	vdi_control.opcode := 24;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := style;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vsf_color(
            handle   : VdiHdl;
            color_idx: int16)
           return int16 is
begin
	vdi_control.opcode := 25;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := color_idx;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vswr_mode(
            handle: VdiHdl;
            mode: int16)
           return int16 is
begin
	vdi_control.opcode := 32;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := mode;

	vdi_trap;
	
	return vdi_intout(0);
end;


procedure v_opnvwk(
            work_in : vdi_workin_array_ptr;
            handle  : short_ptr;
            work_out: vdi_workout_array_ptr) is
    pb: aliased VDIPB;
    function to_intin is new Ada.Unchecked_Conversion(vdi_workin_array_ptr, VDIIntIn_ptr);
    function to_intout is new Ada.Unchecked_Conversion(vdi_workout_array_ptr, VDIIntOut_ptr);
    function to_ptsout is new Ada.Unchecked_Conversion(short_ptr, VDIPtsOut_ptr);
begin
	vdi_control.opcode := 100;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := work_in'Length;
	vdi_control.subcode := 0;
	vdi_control.handle := handle.all;

	pb.control := vdi_control'Access;
	pb.intin := to_intin(work_in);
	pb.ptsin := vdi_ptsin'Access;
	pb.intout := to_intout(work_out);
	pb.ptsout := to_ptsout(work_out(45)'Access);
	
	vdi(pb'Unchecked_Access);
	
	handle.all := vdi_control.handle;
end;


procedure v_clsvwk(handle: VdiHdl) is
begin
	vdi_control.opcode := 101;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


function vsf_perimeter(
            handle: VdiHdl;
            vis: int16)
           return int16 is
begin
	vdi_control.opcode := 104;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := vis;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vsf_perimeter(
            handle : VdiHdl;
            vis  : int16;
            style: int16)
           return int16 is
begin
	vdi_control.opcode := 104;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 2;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := vis;
	vdi_intin(1) := style;
	vdi_trap;
	
	return vdi_intout(0);
end;


procedure vr_recfl(
            handle : VdiHdl;
            pxy    : short_array) is
begin
	vdi_control.opcode := 114;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	vdi_trap;
end;


procedure vs_clip(
            handle   : VdiHdl;
            clip_flag: int16;
            pxy      : short_array) is
begin
	vdi_control.opcode := 129;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := clip_flag;
	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	vdi_trap;
end;


procedure vs_clip(
            handle   : VdiHdl;
            clip_flag: int16;
            pxy      : PXY_array) is
begin
	vdi_control.opcode := 129;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := clip_flag;
	vdi_ptsin(0) := pxy(0).p_x;
	vdi_ptsin(1) := pxy(0).p_y;
	vdi_ptsin(2) := pxy(1).p_x;
	vdi_ptsin(3) := pxy(1).p_y;
	vdi_trap;
end;



end Atari.Vdi;
