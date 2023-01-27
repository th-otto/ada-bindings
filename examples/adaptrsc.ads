with Atari.Aes;
with Atari.Aes.Objects;
use Atari;

package adaptrsc is

	GAI_WDLG: constant := 16#0001#;	-- wdlg_xx()-functions available
	GAI_LBOX: constant := 16#0002#;	-- lbox_xx()-functions available
	GAI_FNTS: constant := 16#0004#;	-- fnts_xx()-functions available
	GAI_FSEL: constant := 16#0008#;	-- new file selector (fslx_xx) available
	GAI_PDLG: constant := 16#0010#;	-- pdlg_xx()-functions available

	GAI_MAGIC: constant := 16#0100#;	-- MagiC-AES present
	GAI_INFO: constant := 16#0200#;	-- appl_getinfo() supported
	GAI_3D: constant := 16#0400#;	-- 3D-Look supported
	GAI_CICN: constant := 16#0800#;	-- Color-Icons supported
	GAI_APTERM: constant := 16#1000#;	-- AP_TERM supported
	GAI_GSHORTCUT: constant := 16#2000#;	-- object type G_SHORTCUT supported

	vdi_handle: int16;
	gl_wchar, gl_hchar: int16;
    gl_wbox, gl_hbox: int16;
	aes_flags: uint16;
	hor_3d, ver_3d: int16;


	procedure get_aes_info;

	procedure substitute_objects(objects: Aes.Objects.AEStree_ptr; nobs: int16; flags: uint16);

	procedure substitute_free;

end adaptrsc;
