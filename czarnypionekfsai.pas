unit czarnyPionekFSAI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, bialyPionekFP, czarnyPionekFS,czarnyPionekFP ,czarnyPionekFPAI,
  czarnaDamkaFSAI, globalne, globalne2, uniwersalne;

procedure rozpocznijRuchDlaCzarnego();

implementation

procedure wykonajBicie_CP(wzorzec : TPole2);
begin
     wzorzec.Enabled := true;
     zmianaStanuIObrazka(wzorzec, 'PustePole', sciezkaCPole);
     WykasujElementZTablicy(bialePionki, iloscBialychPionkow, wzorzec);
     wykonajRuchDlaCzarnegoPionka();
end;

//wybieranie pola docelowego podczas bicia
procedure wybierzPoleDocelowe_B_CP();
var
  row , colummn : integer;
  rowW, colummnW : integer;
  warunek : boolean;
  wzorzec : TPole2;
begin
     warunek := true;
     while (warunek) do
     begin
          if (SprBicieCP_DL(kliknietePole)) then
          begin
               row := kliknietePole.MyRow + 2;
               colummn := kliknietePole.MyColummn - 2;
               rowW := row - 1;
               colummnW := colummn + 1;
          end
          else if (SprBicieCP_DP(kliknietePole)) then
          begin
               row := kliknietePole.MyRow + 2;
               colummn := kliknietePole.MyColummn + 2;
               rowW := row - 1;
               colummnW := colummn - 1;
          end
          else if (SprBicieCP_GL(kliknietePole)) then
          begin
               row := kliknietePole.MyRow - 2;
               colummn := kliknietePole.MyColummn - 2;
               rowW := row + 1;
               colummnW := colummn + 1;
          end
          else if (SprBicieCP_GP(kliknietePole)) then
          begin
               row := kliknietePole.MyRow - 2;
               colummn := kliknietePole.MyColummn + 2;
               rowW := row + 1;
               colummnW := colummn - 1;
          end;
          wybranePoleDoc := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
          if (kliknietePole.MyStan = 'CzarnyPionek') then
          begin
               wzorzec := zwrocElementTablicy(bialePionki, iloscBialychPionkow, rowW, colummnW);
               wykonajBicie_CP(wzorzec);
               kliknietePole.Enabled := true;
               wybranePoleDoc.Enabled := false;
               kliknietePole := wybranePoleDoc;
               if (not SprMozliwoscBiciaDlaCzarnegoPionka(kliknietePole)) then
               begin
                    warunek := false;
               end;
          end
          else
          begin
               wybierzPoleDocelowe_B_CD();
          end;

     end;


end;

procedure wykonajBicieDlaCzarnego();
begin
     utworzTabliceZPionkamiDoBicia();
     kliknietePole := wylosujElement();
     if (kliknietePole.MyStan = 'CzarnyPionek') then
     begin
          wybierzPoleDocelowe_B_CP();
     end
     else
     begin
          wybierzPoleDocelowe_B_CD();
     end;
end;

procedure przemiesc_CP();
begin
     wybranePoleDoc := znajdzOdpowiedniePoleDocelowe_CP;
     kliknietePole.Enabled := true;
     wybranePoleDoc.Enabled := false;
     wykonajRuchDlaCzarnegoPionka();
end;

procedure wykonajRuchDlaCzarnego();
begin
     utworzTabliceZPionkamiDoRuchu();
     kliknietePole := wylosujElement();
     if (kliknietePole.MyStan = 'CzarnyPionek') then
     begin
          przemiesc_CP();
     end
     else
     begin
          przemiesc_CD();
     end;
end;

procedure rozpocznijRuchDlaCzarnego();
var
  czyRuch : boolean;
  czyBicie : boolean;
begin
     if (not czyKoniecGry) then
     begin
     czyRuch := false;
     czyBicie := SprCzyJestMozliwoscBiciaDlaCzarnego();
     if (czyBicie) then
     begin
          wykonajBicieDlaCzarnego();
     end
     else if (SprawdzCzyJestMozliwoscRuchuDlaCzarnego()) then
     begin
          czyRuch := true;
          wykonajRuchDlaCzarnego();
     end
     else
     if ((not czyBicie) AND (not czyRuch)) then
     begin
          showMessage('Wygrales!!!!!!!!!!!!!!!! komputer nie ma mozliwosci ruchu');
     end
     else
     begin
          SprawdzZwyciezce();
     end;
     AkwtywujOdpowiednieFiguryDlaBialego();
     end;
end;

end.


