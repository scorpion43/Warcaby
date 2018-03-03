unit bialyPionekFS;

{$mode objfpc}{$H+}

interface

procedure rozpoznajBialeFigury();
procedure wybierzPoleDoceloweDlaBialegoGracza();
procedure wykonajRuchAlboBicieDlaBialegoPionka();

implementation

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, bialyPionekFP, bialaDamkaFS, globalne, uniwersalne;

//wykonanie ruchu dla bialego pionka
procedure wykonajRuchDlaBialegoPionka();
begin
     if (wybranePoleDoc.MyRow = 1) then
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'BialaDamka', sciezkaBD);
     end
     else
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'BialyPionek', sciezkaBP);
     end;
     zmienPionekWTablicy(bialePionki, iloscBialychPionkow, kliknietePole, wybranePoleDoc);
     zmianaStanuIObrazka(kliknietePole, 'PustePole', sciezkaCPole);
end;

//wykonanie bicia dla bialego pionka
procedure wykonajBicieBP();
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
     wzorzec := zwrocElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     wzorzec.Enabled := true;
     zmianaStanuIObrazka(wzorzec, 'PustePole', sciezkaCPole);
     WykasujElementZTablicy(czarnePionki, iloscCzarnychPionkow, wzorzec);
     wykonajRuchDlaBialegoPionka();
     if (wybranePoleDoc.MyStan = 'BialyPionek') then
     begin
          if (SprMozliwoscBiciaDlaBialegoPionka(wybranePoleDoc)) then
          begin
               dezaktywujPionkiBiale();
               wybranePoleDoc.Enabled := true;
               pomylka := true;
          end;
     end
     else
     begin
          SprDalszaMozliwoscBicia_BD();
     end;
end;

//Sprawdzenie czy ma zostać wykonany ruch czy bicie dla bialego pionka
procedure wykonajRuchAlboBicieDlaBialegoPionka();
begin
     if (czyJestBicie) then
     begin
         if (SprMozliwoscBiciaBP()) then
         begin
            wykonajBicieBP();
         end
         else
         begin
              pomylka := true;
         end;
     end
     else
     begin
          if (SprMozliwoscRuchuBP()) then
          begin
               wykonajRuchDlaBialegoPionka();
          end;
     end;
end;

//Procedura wybrania pola docelowogo dla bialego gracza
procedure wybierzPoleDoceloweDlaBialegoGracza();
begin
     if (wybranePoleDoc.MyStan = 'BialyPionek') then
     begin
          pomylka := true;
          sprIZmienObrazekDamkaLubPionekB();
          kliknietePole := wybranePoleDoc;
          wybranePoleDoc := nil;
     end
     else if (wybranePoleDoc.MyStan = 'BialaDamka') then
     begin
          pomylka := true;
          sprIZmienObrazekDamkaLubPionekB();
          kliknietePole := wybranePoleDoc;
          wybranePoleDoc := nil;
     end
     else if (wybranePoleDoc.MyStan = 'PustePole') then
     begin
          if (kliknietePole.MyStan = 'BialyPionek') then
          begin
               wykonajRuchAlboBicieDlaBialegoPionka();
          end
          else
          begin
               wykonajRuchAlboBicie_BD();
          end;
     end;
end;

//procedura rozpoznajaca czy uzytkownik wybral odpowiednia figure
procedure rozpoznajBialeFigury();
begin
     if (kliknietePole.MyStan = 'PustePole') then
     begin
          //podmiana obrazka na polu
          pomylka := true;
     end
     else if (kliknietePole.MyStan = 'BialyPionek') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaBPZ);
     end
     else if (kliknietePole.MyStan = 'BialaDamka') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaBDZ);
     end;
end;


end.


