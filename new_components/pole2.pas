unit Pole2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type
  TPole2 = class(TImage)
  private
    { Private declarations }
    PStan : String;
    PRow : Integer;
    PColummn : Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property MyStan : String read PStan write PStan;
    property MyRow : Integer read PRow write PRow;
    property MyColummn : Integer read PColummn write PColummn;
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Additional',[TPole2]);
end;

end.
