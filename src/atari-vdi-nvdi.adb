pragma No_Strict_Aliasing;
with Interfaces; use Interfaces;

--
-- NOT YET IMPLEMENTED:
--  v_trays

--  v_ps_halftone
--  vq_calibrate
--  vq_page_name
--  vq_tray_names
--  vs_calibrate
--  v_etext

--  v_setrgbi
--  v_xbit_image
--  v_topbot
--  vs_bkcolor
--  v_pat_rotate
--  vs_grayoverride

--  v_opnbm
--  v_clsbm

--  v_get_driver_info
--  vqt_real_extent

--  vq_margins
--  vq_driver_info
--  vq_bit_image
--  vs_page_info
--  vs_crop
--  vq_image_type
--  vs_save_disp_list
--  vs_load_disp_list

--  vqt_xfntinfo
--  vq_ext_devinfo
--  vqt_ext_name
--  vqt_name_and_id
--  vst_name

--  vqt_char_index

--  vqt_is_char_available

--  v_color2nearest
--  v_color2value
--  v_create_ctab
--  v_create_itab
--  v_ctab_idx2value
--  v_ctab_idx2vdi
--  v_ctab_vdi2idx
--  v_delete_ctab
--  v_delete_itab
--  v_get_ctab_id
--  v_get_outline
--  v_open_bm
--  v_resize_bm
--  v_setrgb
--  v_value2color
--  vq_ctab
--  vq_ctab_entry
--  vq_ctab_id
--  vq_dflt_ctab
--  vq_hilite_color
--  vq_margins
--  vq_max_color
--  vq_min_color
--  vq_prn_scaling
--  vq_px_format
--  vq_weight_color
--  vqf_bg_color
--  vqf_fg_color
--  vql_bg_color
--  vql_fg_color
--  vqm_bg_color
--  vqm_fg_color
--  vqr_bg_color
--  vqr_fg_color
--  vqt_bg_color
--  vqt_fg_color
--  vr_transfer_bits
--  vs_ctab
--  vs_ctab_entry
--  vs_dflt_ctab
--  vs_document_info
--  vs_hilite_color
--  vs_max_color
--  vs_min_color
--  vs_weight_color
--  vsf_bg_color
--  vsf_fg_color
--  vsl_bg_color
--  vsl_fg_color
--  vsm_bg_color
--  vsm_fg_color
--  vsr_bg_color
--  vsr_fg_color
--  vst_bg_color
--  vst_fg_color
--


package body Atari.Vdi.Nvdi is

function fix31_to_point(fix: fix31) return int16 is
begin
	return int16(Shift_Right(Unsigned_32(fix + 32768), 16));
end;


function point_to_fix31(point: int16) return fix31 is
begin
	return fix31(Shift_Left(Unsigned_32(point), 16));
end;


end Atari.Vdi.Nvdi;
