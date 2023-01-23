with System;
with Ada.Characters;
with Atari.Aes; use Atari.Aes;
use Atari;
with Interfaces; use Interfaces;
with Text_IO;
with wdlgdemo_resource; use wdlgdemo_resource;
with wdlgdemo_callbacks; use wdlgdemo_callbacks;
with Atari.Aes.Wdialog; use Atari.Aes.Wdialog;

Pragma Unreferenced(Text_IO);


procedure wdlgdemo is
    use ASCII;
    PARTS: constant int16 := NAME or CLOSER or MOVER;

    dialog: Wdialog.DIALOG_ptr;
    gl_wchar, gl_hchar: int16;
    gl_wbox, gl_hbox: int16;
    menu_id: int16;
    title: constant String := " WDLG DEMO ";
    menu_name: constant char_array(0..13) := " Wdialog Demo" & ASCII.NUL;
    tree: AEStree_ptr;
    dummy: aliased int16;

    procedure open_window is
	    out1, out2, out3, out4: int16;
    begin
        if dialog = null then
        	if appl_xgetinfo(7, out1, out2, out3, out4) = 0 or else (out1 and 1) = 0 then
        		dummy := form_alert(1, "[3][No WDIALOG functions available][Abort]");
        		return;
        	end if;
            dialog := Wdialog.wdlg_create(handle_dlg'Access, tree, System.Null_Address, 0, System.Null_Address, WDialog.WDLG_BKGD);
            if (dialog /= null) then
	            dummy := Wdialog.wdlg_open(dialog, title, PARTS, -1, -1, 0, System.Null_Address);
	        end if;
        else
            dummy := wind_set(Wdialog.wdlg_get_handle(dialog), WF_TOP);
        end if;
    end;

    procedure close_window is
	begin
        if dialog /= null then
       		dummy := Wdialog.wdlg_close(dialog);
       		dummy := Wdialog.wdlg_delete(dialog);
       		dialog := null;
       	end if;
	end;

    function handle_message(pipe: array_8_ptr) return boolean is
        dummy2: int16;
    begin
        -- Text_IO.Put_Line("got message " & pipe(0)'image);
        case pipe(0) is
            when AC_OPEN =>
                if pipe(4) = menu_id then
                    open_window;
                end if;
            when AC_CLOSE =>
                dialog := null;
            when others =>
                null;
        end case;
        return false;
    end;

    function event_loop return boolean is
        event: aliased Wdialog.EVNT;
	    events: int16;
        quit: boolean;
    begin
        quit := false;
        
        loop
	        if dialog = null then
	        	events := MU_MESAG;
	        else
	            events := MU_MESAG or MU_BUTTON or MU_KEYBD;
	        end if;
            event.mwhich := evnt_multi(events,
            	2, 1, 1,
                0, 0, 0, 0, 0,
                0, 0, 0, 0, 0,
                event.msg'Unchecked_Access,
                0,
                event.mx, event.my, event.mbutton, event.kstate, event.key, event.mclicks);
            if (event.mwhich and MU_MESAG) /= 0 then
                quit := handle_message(event.msg'Unchecked_Access);
            end if;
            if not quit and then dialog /= null then
	            quit := Wdialog.wdlg_evnt(dialog, event'Unchecked_Access) = 0;
	        end if;
            if quit then
                close_window;
                if not Is_Application then
                    quit := false;
                end if;
            end if;
            exit when quit;
        end loop;
        return quit;
    end;


begin
    if appl_init /= -1 then
    	dialog := null;
        graf_mouse(ARROW);
    	if rsrc_load("wdlgdemo.rsc") = 0 then
    		dummy := form_alert(1, "[3][Resource file not found][Abort]");
        else
        	dummy := graf_handle(gl_wchar, gl_hchar, gl_wbox, gl_hbox);
        	tree := rsrc_gaddr(TEST);
	        if not Is_Application then
	            menu_id := menu_register(gl_apid, menu_name(0)'Unchecked_Access);
	        else
	            open_window;
	        end if;
	        tree := rsrc_gaddr(TEST);
	        loop
	            exit when event_loop;
	        end loop;
	    end if;
        appl_exit;
    end if;
end wdlgdemo;
