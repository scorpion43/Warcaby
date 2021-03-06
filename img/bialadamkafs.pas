unit bialaDamkaFS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, bialaDamkaFP, globalne, uniwersalne;

procedure wykonajRuchAlboBicie_BD();
procedure SprDalszaMozliwoscBicia_BD();

implementation

//------------- Sprawdzenie dalszej mozliwosc bicia dla bialej damki
procedure SprDalszaMozliwoscBicia_BD();
begin
     if (SprMozliwoscBicia_BD(wybranePoleDoc)) then
     begin
          dezaktywujPionkiBiale();
          wybranePoleDoc.Enabled := true;
          pomylka := true;
     end;
end;

//wykonanie bicia bialej damki do dolu na prawo DP
procedure WykonajBicie_BD_DP();
begin
     if (SprMozliwoscWykonaniaBicia_BD_DP()) then
     begin
          ZbijFigury_BD_DP();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_BD();
     end
     else
     begin
          pomylka := true;
     end;
end;

//wykonanie bicia bialej damki do dolu na lewo
procedure WykonajBicie_BD_DL();
begin
     if (SprMozliwoscWykonaniaBicia_BD_DL()) then
     begin
          ZbijFigury_BD_DL();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_BD();
     end
     else
     begin
          pomylka := true;
     end;
end;

//wykonanie bicia bialej damki do gory na lewo
procedure WykonajBicie_BD_GL();
begin
     if (SprMozliwoscWykonaniaBicia_BD_GL()) then
     begin
          ZbijFigury_BD_GL();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_BD();
     end
     else
     begin
          pomylka := true;
     end;
end;

//wykonanie bicia bialej damki do gory na prawo
procedure WykonajBicie_BD_GP();
begin
     if (SprMozliwoscWykonaniaBicia_BD_GP()) then
     begin
          ZbijFigury_BD_GP();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_BD();
     end
     else
     begin
          pomylka := true;
     end;
end;

procedure RozstrzygnijOpcjeBicia_BD();
var
  odstepR, odstepC : integer;
begin
     odstepR := wybranePoleDoc.MyRow - kliknietePole.MyRow;
     odstepC := wybranePoleDoc.MyColummn - kliknietePole.MyColummn;
     if (odstepR > 0) then
     begin
          if (odstepC > 0) then
          begin
               WykonajBicie_BD_DP();
          end
          else
          begin
               WykonajBicie_BD_DL();
          end;
     end
     else
     begin
          if (odstepC > 0) then
          begin
               WykonajBicie_BD_GP();
          end
          else
          begin
               WykonajBicie_BD_GL();
          end;
     end;
end;

procedure RozstrzygnijOpcjeRuchu_BD();
var
  warunek : boolean;
begin
     warunek := SprMozliowscWykonaniaRuchuDlaDamki();
     if (warunek) then
     begin
          wykonajRuchDlaDamki();
     end
     else
     begin
          pomylka := true;
     end;
end;

procedure wykonajRuchAlboBicie_BD();
begin
     if (not warunekKonRuchuAlboBiciaDlaDamki()) then
     begin
       pomylka := true;
     end
     else
     begin
          if (czyJestBicie) then
          begin
               RozstrzygnijOpcjeBicia_BD();
          end
          else
          begin
               RozstrzygnijOpcjeRuchu_BD();
          end;
     end;
end;

end.


