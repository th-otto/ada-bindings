--
--  resource set indices for wdlgrsc
--
--  created by ORCS 2.18
--


with Atari; use Atari;

package wdlgrsc is

--  constants

    Num_Strings: constant int16 :=        4;
    Num_Bitblks: constant int16 :=        0;
    Num_Iconblks: constant int16 :=       0;
    Num_Color_Iconblks: constant int16 := 0;
    Num_Color_Icons: constant int16 :=    0;
    Num_Tedinfos: constant int16 :=       0;
    Num_Free_Strings: constant int16 :=   0;
    Num_Free_Images: constant int16 :=    0;
    Num_Objects: constant int16 :=        5;
    Num_Trees: constant int16 :=          1;
    Num_Userdefs: constant int16 :=       0;

--  object numbers


    TEST                            : constant int16 :=   0; --  form/dialog
    TEST_OK                         : constant int16 :=   3; --  BUTTON in tree TEST




end wdlgrsc;
