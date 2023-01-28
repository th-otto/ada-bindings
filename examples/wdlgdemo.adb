--
--  Copyright (c) 2022 Thorsten Otto
--
--  Simple example for WDIALOG (dialogs in a window)
--  Example program for ADA Atari TOS bindings
--
--  This example program is in the Public Domain under the terms of
--  Unlicense: http://unlicense.org/
--

with System;
with Ada.Characters;
with Atari.Aes; use Atari.Aes;
with Atari.Aes.Application;
with Atari.Aes.Resource;
with Atari.Aes.Objects; use Atari.Aes.Objects;
with Atari.Aes.Menu;
with Atari.Aes.Graf;
with Atari.Aes.Form;
with Atari.Aes.Event;
with Atari.Aes.Window;
use Atari;
with Interfaces; use Interfaces;
with Text_IO;
with wdlgrsc; use wdlgrsc;
with Atari.Aes.Wdialog; use Atari.Aes.Wdialog;
with Adaptrsc;

Pragma Unreferenced(Text_IO);


procedure wdlgdemo is
    use ASCII;
    PARTS: constant int16 := Window.NAME or Window.CLOSER or Window.MOVER;

    dialog: Wdialog.DIALOG_ptr;
    menu_id: int16;
    title: constant char_array := " WDLG DEMO " & ASCII.NUL;
    menu_name: constant char_array := " Wdialog Demo" & ASCII.NUL;
    tree: AEStree_ptr;
    dummy: aliased int16;

    function handle_dlg(args: Wdialog.HNDL_OBJ_args) return int16 with Convention => C;
    function handle_dlg(args: Wdialog.HNDL_OBJ_args) return int16 is
        tree: AEStree_ptr;
        r: GRECT;
    begin
        tree := Wdialog.wdlg_get_tree(args.dialog, r);
    
        case args.obj is
            when WDialog.HNDL_CLSD =>
                return 0;
            when TEST_OK =>
                tree(TEST_OK).ob_state := tree(TEST_OK).ob_state and not OS_SELECTED;
                return 0;
            when others =>
                null;
        end case;
        return 1;
    end;

    procedure open_window is
        out1, out2, out3, out4: int16;
    begin
        if dialog = null then
            if Application.Get_Info(7, out1, out2, out3, out4) = false or else (out1 and 1) = 0 then
                dummy := Form.Alert(1, "[3][No WDIALOG functions available][Abort]");
                return;
            end if;
            dialog := Wdialog.wdlg_create(handle_dlg'Unrestricted_Access, tree, System.Null_Address, 0, System.Null_Address, WDialog.WDLG_BKGD);
            if (dialog /= null) then
                dummy := Wdialog.wdlg_open(dialog, title(title'First)'Unchecked_Access, PARTS, -1, -1, 0, System.Null_Address);
            end if;
        else
            dummy := Window.Set(Wdialog.wdlg_get_handle(dialog), Window.WF_TOP);
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

    function handle_message(pipe: Event.Message_Buffer) return boolean is
        dummy2: int16;
    begin
        -- Text_IO.Put_Line("got message " & pipe(0)'image);
        case pipe.simple.msgtype is
            when Event.AC_OPEN =>
                if pipe.simple.menu_id = menu_id then
                    open_window;
                end if;
            when Event.AC_CLOSE =>
                dialog := null;
            when Event.AP_TERM =>
                return true;
            when others =>
                null;
        end case;
        return false;
    end;

    function event_loop return boolean is
        event_rec: aliased Wdialog.EVNT;
        events: int16;
        quit: boolean;
    begin
        quit := false;
        
        loop
            if dialog = null then
                events := Event.MU_MESAG;
            else
                events := Event.MU_MESAG or Event.MU_BUTTON or Event.MU_KEYBD;
            end if;
            event_rec.mwhich := Event.Multi(events,
                2, 1, 1,
                0, 0, 0, 0, 0,
                0, 0, 0, 0, 0,
                event_rec.msg,
                0,
                event_rec.mx, event_rec.my, event_rec.mbutton, event_rec.kstate, event_rec.key, event_rec.mclicks);
            if (event_rec.mwhich and Event.MU_MESAG) /= 0 then
                quit := handle_message(event_rec.msg);
            end if;
            if not quit and then dialog /= null then
                quit := Wdialog.wdlg_evnt(dialog, event_rec'Unchecked_Access) = 0;
            end if;
            if quit then
                close_window;
                if not Application.Is_Application then
                    quit := false;
                end if;
            end if;
            exit when quit;
        end loop;
        return quit;
    end;


begin
    if Application.Init /= -1 then
        dialog := null;
        Graf.Mouse(ARROW);
        if Resource.Load("wdlgrsc.rsc") = 0 then
            dummy := Form.Alert(1, "[3][Resource file not found][Abort]");
        else
            adaptrsc.vdi_handle := Graf.Handle(adaptrsc.gl_wchar, adaptrsc.gl_hchar, adaptrsc.gl_wbox, adaptrsc.gl_hbox);
            adaptrsc.get_aes_info;
            tree := Resource.Get_Address(TEST);
            adaptrsc.substitute_objects(tree, Num_Objects, adaptrsc.aes_flags);
            if not Application.Is_Application then
                menu_id := Menu.Register(Application.Id, menu_name(menu_name'First)'Unchecked_Access);
            else
                open_window;
            end if;
            loop
                exit when event_loop;
            end loop;
            adaptrsc.substitute_free;
            dummy := Resource.Free;
        end if;
        Application.AExit;
    end if;

end wdlgdemo;
