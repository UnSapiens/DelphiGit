unit Reception;
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
  TReception = class
    private
      FIdRec: Integer;

      FPrice: Real;
      FIdUser: Integer;
      FTreatment: string;
      FDiagnosis: string;
      FIdPatient: integer;
      FDate: TDateTime;
      procedure SetDate(const Value: TDateTime);
      procedure SetDiagnosis(const Value: string);
      procedure SetIdPatient(const Value: integer);
      procedure SetIdUser(const Value: Integer);
      procedure SetPrice(const Value: Real);
      procedure SetTreatment(const Value: string);
      procedure SetIdRec(const Value: Integer);
    published
    public
      procedure DeleteReception(DBQ:TADOQuery);
      procedure UpdateReception(DBQ:TADOQuery;NewReception:TReception);
      property IdRec:Integer read FIdRec write SetIdRec;
      property Price:Real read FPrice write SetPrice;
      property Date:TDateTime read FDate write SetDate;
      property IdPatient: integer read FIdPatient write SetIdPatient;
      property IdUser:Integer read FIdUser write SetIdUser;
      property Diagnosis: string read FDiagnosis write SetDiagnosis;
      property Treatment: string read FTreatment write SetTreatment;
  end;

procedure LoadAllReceptions(DBQ:TADOQuery);
procedure InsertReception(DBQ:TADOQuery;NewReception:TReception);

var
ListReception :TObjectList<TReception>;


implementation
{$S *.dfm  }

{TReception }

procedure LoadAllReceptions(DBQ:TadoQuery);
var
  StrSQL: string;
  qr: TADOQuery;
  MyReception:TReception;
begin
  try
  if ListReception <> nil then
    ListReception := TObjectList<TReception>.Create;
    StrSQL := 'SELECT * FROM Reception';
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
        MyReception := TReception.Create;
        MyReception.IdRec := qr.FieldByName('id_rec').AsInteger;
        MyReception.Date := qr.FieldByName('date_rec').AsDateTime;
        MyReception.Price := qr.FieldByName('Price_rec').AsFloat;
        MyReception.IdUser := qr.FieldByName('id_med').AsInteger;
        MyReception.Treatment := qr.FieldByName('Treatment').AsString;
        MyReception.Diagnosis := qr.FieldByName('Diagnosis').AsString;
        MyReception.IdPatient := qr.FieldByName('id_pat').AsInteger;
        ListReception.Add(MyReception);
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

procedure TReception.DeleteReception(DBQ:TADOQuery);
var
  StrSQL: string;
  qr: TADOQuery;
begin
  try
    StrSQL := 'DELETE * FROM Reception WHERE id_rec = :id_rec';
    qr := TADOQuery.Create(DBQ.Owner);
    try
      qr.Connection := DBQ.Connection;
      qr.ParamCheck := False;
      qr.Parameters.Clear;

      qr.sql.Text := StrSQL;

      qr.Parameters.AddParameter.Name := 'id_rec';
      qr.Parameters.ParamByName('id_rec').DataType := ftInteger;
      qr.Parameters.ParamByName('id_rec').Value := FIdRec;

      qr.ExecSQL;
    finally
      qr.Free;
    end;
  except
    on E:Exception do
      ShowMessage(e.Message);
  end;
end;

procedure TReception.UpdateReception(DBQ:TADOQuery;NewReception:TReception);
var
  StrSQL: string;
  qr: TADOQuery;
  idx:integer;
begin
  try
    StrSQL := 'UPDATE Reception SET ' +
    ' date_rec = :date_rec ,'+
    ' id_pat = :id_pat ,'+
    ' Diagnosis = :Diagnosis ,'+
    ' Treatment = :Treatment ,'+
    ' Price_rec = :Price_rec ,'+
    ' id_med = :id_med'+
    '  WHERE  id_rec = :id_rec';
    qr := TADOQuery.Create(DBQ.Owner);
    try
      qr.Connection := DBQ.Connection;
      qr.ParamCheck := False;
      qr.Parameters.Clear;

      qr.sql.Text := StrSQL;

      qr.Parameters.AddParameter.Name := 'date_rec';
      qr.Parameters.ParamByName('date_rec').DataType := ftDateTime;
      qr.Parameters.ParamByName('date_rec').Value := NewReception.Date;

      qr.Parameters.AddParameter.Name := 'id_pat';
      qr.Parameters.ParamByName('id_pat').DataType := ftInteger;
      qr.Parameters.ParamByName('id_pat').Value := NewReception.FIdPatient;

      qr.Parameters.AddParameter.Name := 'Diagnosis';
      qr.Parameters.ParamByName('Diagnosis').DataType := ftString;
      qr.Parameters.ParamByName('Diagnosis').Value := NewReception.FDiagnosis;

      qr.Parameters.AddParameter.Name := 'Treatment';
      qr.Parameters.ParamByName('Treatment').DataType := ftString;
      qr.Parameters.ParamByName('Treatment').Value := NewReception.Treatment;

      qr.Parameters.AddParameter.Name := 'Price_rec';
      qr.Parameters.ParamByName('Price_rec').DataType := ftFloat;
      qr.Parameters.ParamByName('Price_rec').Value := NewReception.FPrice;

      qr.Parameters.AddParameter.Name := 'id_med';
      qr.Parameters.ParamByName('id_med').DataType := ftInteger;
      qr.Parameters.ParamByName('id_med').Value := NewReception.IdUser;

      qr.Parameters.AddParameter.Name := 'id_rec';
      qr.Parameters.ParamByName('id_rec').DataType := ftInteger;
      qr.Parameters.ParamByName('id_rec').Value := NewReception.IdRec;

      qr.ExecSQL;
    finally
      qr.Free;
    end;

    for idx := 0 to ListReception.Count - 1 do
     if ListReception[idx].IdRec = NewReception.IdRec then
        begin
          ListReception[idx] := NewReception;
          break;
        end;
  except
    on E:Exception do
      ShowMessage(e.Message);
  end;
end;

procedure InsertReception(DBQ:TADOQuery;NewReception:TReception);
var
  StrSQL: string;
  qr: TADOQuery;
begin
  try
    StrSQL := 'INSERT INTO Reception (date_rec,id_pat,Diagnosis,Treatment,Price_rec,id_med)'+
    ' VALUES (:date_rec,:id_pat,:Diagnosis,:Treatment,:Price_rec,:id_med)';
    qr := TADOQuery.Create(DBQ.Owner);
    try
      qr.Connection := DBQ.Connection;
      qr.ParamCheck := False;
      qr.Parameters.Clear;

      qr.sql.Text := StrSQL;

      qr.Parameters.AddParameter.Name := 'date_rec';
      qr.Parameters.ParamByName('date_rec').DataType := ftDateTime;
      qr.Parameters.ParamByName('date_rec').Value := NewReception.Date;

      qr.Parameters.AddParameter.Name := 'id_pat';
      qr.Parameters.ParamByName('id_pat').DataType := ftInteger;
      qr.Parameters.ParamByName('id_pat').Value := NewReception.FIdPatient;

      qr.Parameters.AddParameter.Name := 'Diagnosis';
      qr.Parameters.ParamByName('Diagnosis').DataType := ftString;
      qr.Parameters.ParamByName('Diagnosis').Value := NewReception.FDiagnosis;

      qr.Parameters.AddParameter.Name := 'Treatment';
      qr.Parameters.ParamByName('Treatment').DataType := ftString;
      qr.Parameters.ParamByName('Treatment').Value := NewReception.Treatment;

      qr.Parameters.AddParameter.Name := 'Price_rec';
      qr.Parameters.ParamByName('Price_rec').DataType := ftFloat;
      qr.Parameters.ParamByName('Price_rec').Value := NewReception.FPrice;

      qr.Parameters.AddParameter.Name := 'id_med';
      qr.Parameters.ParamByName('id_med').DataType := ftInteger;
      qr.Parameters.ParamByName('id_med').Value := NewReception.IdUser;

      qr.ExecSQL;
    finally
      qr.Free;
    end;
    ListReception.Add(NewReception);
  except
    on E:Exception do
      ShowMessage(e.Message);
  end;
end;


procedure TReception.SetDate(const Value: TDateTime);
begin
  FDate := Value;
end;

procedure TReception.SetDiagnosis(const Value: string);
begin
  FDiagnosis := Value;
end;

procedure TReception.SetIdPatient(const Value: integer);
begin
  FIdPatient := Value;
end;

procedure TReception.SetIdRec(const Value: Integer);
begin
  FIdRec := Value;
end;

procedure TReception.SetIdUser(const Value: Integer);
begin
  FIdUser := Value;
end;

procedure TReception.SetPrice(const Value: Real);
begin
  FPrice := Value;
end;

procedure TReception.SetTreatment(const Value: string);
begin
  FTreatment := Value;
end;

end.
