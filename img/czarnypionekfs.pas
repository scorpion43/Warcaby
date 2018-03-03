unit czarnyPionekFS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, czarnyPionekFP, czarnaDamkaFS, globalne, uniwersalne;

procedure rozpoznajCzarneFigury();
procedure wybierzPoleDoceloweDlaCzarnegoGracza();
procedure wykonajRuchDlaCzarnegoPionka();

implementation

//wykonanie ruchu dla czarnego gracza
procedure wykonajRuchDlaCzarnegoPionka();
begin
     if (wybranePoleDoc.MyRow = 8) then
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'CzarnaDamka', sciezkaCD);
     end
     else
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'CzarnyPionek', sciezkaCP);
     end;
     zmienPionekWTablicy(czarnePionki, iloscCzarnychPionkow, kliknietePole, wybranePoleDoc);
     zmianaStanuIObrazka(kliknietePole, 'PustePole', sciezkaCPole);
end;

procedure wykonajBicieCP();
var
  row, colummn : integer;
  odstepR, odstepC : integer;
  var wzorzec : TPole2;
begin
     odstepR := kliknietePole.MyRow - wybranePoleDoc.MyRow;
     odstepC := kliknietePole.MyColummn - wybranePoleDoc.MyColummn;
     row := kliknietePole.MyRow;
     colummn := kliknietePole.MyColummn;

     if (odstepR = 2) then
     begin
          row := row - 1;
     end
     else
     if (odstepR = -2) then
     begin
          row := row + 1;
     end;
     if (odstepC = 2) then
     begin
          colummn := colummn - 1;
     end
     else
     if (odstepC = -2) then
     begin
          colummn := colummn + 1;
     end;
     wzorzec := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     wzorzec.Enabled := true;
     zmianaStanuIObrazka(wzorzec, 'PustePole', sciezkaCPole);
     WykasujElementZTablicy(bialePionki, iloscBialychPionkow, wzorzec);
     wykonajRuchDlaCzarnegoPionka();
     if (wybranePoleDoc.MyStan = 'CzarnyPionek') then
     begin
          if (SprMozliwoscBiciaDlaCzarnegoPionka(wybranePoleDoc)) then
          begin
               dezaktywujPionkiCzarne();
               wybranePoleDoc.Enabled := true;
               pomylka := true;
          end;
     end
     else
     begin
          //Sprawdzenie dalszej mozliwosci bicia dla damki
          SprDalszaMozliwoscBicia_CD();
     end;
end;

//rozsadzenie czy wykonac ruch czy bicie dla czarnego gracza
procedure wykonajRuchAlboBicieDlaCzarnegoPionka();
begin
     if (czyJestBicie) then
     begin
         if (SprMozliwoscBiciaCP()) then
         begin
            wykonajBicieCP();
         end
         else
         begin
              pomylka := true;
         end;
     end
     else
     begin
          if (SprMozliwoscRuchuCP()) then
          begin
               wykonajRuchDlaCzarnegoPionka();
          end
          else
          begin
               pomylka := true;
          end;
     end;
end;

//wybranie pola docelowego dla czarnego gracza
procedure wybierzPoleDoceloweDlaCzarnegoGracza();
begin
     if (wybranePoleDoc.MyStan = 'CzarnyPionek') then
     begin
          pomylka := true;
          sprIZmienObrazekDamkaLubPionekC();
          kliknietePole := wybranePoleDoc;
          wybranePoleDoc := nil;
     end
     else if (wybranePoleDoc.MyStan = 'CzarnaDamka') then
     begin
          pomylka := true;
          sprIZmienObrazekDamkaLubPionekC();
          kliknietePole := wybranePoleDoc;
          wybranePoleDoc := nil;
     end
     else if (wybranePoleDoc.MyStan = 'PustePole') then
     begin
          if (kliknietePole.MyStan = 'CzarnyPionek') then
          begin
               wykonajRuchAlboBicieDlaCzarnegoPionka();
          end
          else
          begin
               wykonajRuchAlboBicie_CD();
          end;
     end;
end;

//procedura rozpoznajaca czy uzytkownik wybral odpowiednia figure
procedure rozpoznajCzarneFigury();
begin
     if (kliknietePole.MyStan = 'PustePole') then
     begin
          //podmiana obrazka na polu
          pomylka := true;
     end
     else if (kliknietePole.MyStan = 'CzarnyPionek') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaCPZ);
     end
     else if (kliknietePole.MyStan = 'CzarnaDamka') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaCDZ);
     end;
end;

end.


