unit Patient;
interface

uses
Classes,Data.DB, Data.Win.ADODB,System.SysUtils,Vcl.Dialogs,Generics.Collections;

type
//датой,
//фио пациента,
//номером полиса,
//поставленным диагнозом (текст),
//назначенным лечением,
//стоимостью приема,
//врачем который этот прием выполнил
  TPatient = class
    private
      FNumPol: String;
      FFIO: string;
      FIdPatient: integer;
      procedure SetFIO(const Value: string);
      procedure SetIdPatient(const Value: integer);
      procedure SetNumPol(const Value: String);
    published
    public

      procedure UpdatePatient(DBQ:TADOQuery;NewPatient:TPatient);
      property FIO:string read FFIO write SetFIO;
      property NumPol:String read FNumPol write SetNumPol;
      property IdPatient: integer read FIdPatient write SetIdPatient;
  end;

var
ListPatient :TObjectList<TPatient>;

procedure LoadAllPatient(DBQ:TadoQuery);

implementation
{$S *.dfm  }

{ TPatient }

procedure LoadAllPatient(DBQ:TadoQuery);
var
  StrSQL: string;
  qr: TADOQuery;
  MyPatient:TPatient;
begin
  try
  if ListPatient = nil then
   ListPatient := TObjectList<TPatient>.Create;
    StrSQL := 'SELECT * FROM Patient';
    qr := TADOQuery.Create(DBQ.Owner);
    try
      qr.Connection := DBQ.Connection;
      qr.ParamCheck := False;
      qr.Parameters.Clear;

      qr.sql.Text := StrSQL;

      qr.Open;
      if qr.RecordCount > 0 then
      while not qr.Eof do
      begin
        MyPatient := TPatient.Create;
        MyPatient.IdPatient := qr.FieldByName('id_pat').AsInteger;
        MyPatient.FIO := qr.FieldByName('FIO_pat').AsString;
        MyPatient.NumPol := qr.FieldByName('Num_polis').AsString;
        ListPatient.Add(MyPatient);
        qr.Next;
      end;
    finally
      qr.Free;
    end;
  except
    on E:Exception do
      ShowMessage(e.Message);
  end;
end;

procedure TPatient.UpdatePatient(DBQ:TADOQuery;NewPatient:TPatient);
var
  StrSQL: string;
  qr: TADOQuery;
  idx:integer;
begin
  try
    StrSQL := 'UPDATE Patient SET ' +
    ' FIO_pat = :FIO_pat ,'+
    ' Num_polis = :Num_polis '+
    '  WHERE  id_pat = :id_pat';
    qr := TADOQuery.Create(DBQ.Owner);
    try
      qr.Connection := DBQ.Connection;
      qr.ParamCheck := False;
      qr.Parameters.Clear;

      qr.sql.Text := StrSQL;

      qr.Parameters.AddParameter.Name := 'FIO_pat';
      qr.Parameters.ParamByName('FIO_pat').DataType := ftString;
      qr.Parameters.ParamByName('FIO_pat').Value := NewPatient.FIO;

      qr.Parameters.AddParameter.Name := 'Num_polis';
      qr.Parameters.ParamByName('Num_polis').DataType := ftString;
      qr.Parameters.ParamByName('Num_polis').Value := NewPatient.NumPol;

      qr.Parameters.AddParameter.Name := 'id_pat';
      qr.Parameters.ParamByName('id_pat').DataType := ftInteger;
      qr.Parameters.ParamByName('id_pat').Value := IdPatient;

      qr.ExecSQL;
    finally
      qr.Free;
    end;

    for idx := 0 to ListPatient.Count - 1 do
     if ListPatient[idx].IdPatient = NewPatient.IdPatient then
        begin
          ListPatient[idx] := NewPatient;
          break;
        end;
  except
    on E:Exception do
      ShowMessage(e.Message);
  end;
end;

procedure TPatient.SetFIO(const Value: string);
begin
  FFIO := Value;
end;

procedure TPatient.SetIdPatient(const Value: integer);
begin
  FIdPatient := Value;
end;

procedure TPatient.SetNumPol(const Value: String);
begin
  FNumPol := Value;
end;

end.
