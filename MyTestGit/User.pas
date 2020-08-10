unit User;

interface

uses
Classes,Data.DB, Data.Win.ADODB,System.SysUtils,Vcl.Dialogs,Generics.Collections;

type
  TUser = class
    private
      FIDUser: integer;
      FUserName: string;
      procedure SetIDUser(const Value: integer);
      procedure SetUserName(const Value: string);
      published
    public
      function Autorization(DBQ:TadoQuery;Pass:String):Boolean;
      property IDUser : integer read FIDUser write SetIDUser;
      property UserName : string read FUserName write SetUserName;
  end;

var
ListUsers :TObjectList<TUser>;
procedure LoadAllUsers(DBQ:TadoQuery);


implementation
{$S *.dfm  }

procedure LoadAllUsers(DBQ:TadoQuery);
var
  StrSQL: string;
  qr: TADOQuery;
  MyUser:TUser;
begin
  try
    if ListUsers = nil then
       ListUsers := TObjectList<TUser>.Create;

    StrSQL := 'SELECT * FROM medic';
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
        MyUser := TUser.Create;
        MyUser.IDUser := qr.FieldByName('id_med').AsInteger;
        MyUser.UserName := qr.FieldByName('FIO_Med').AsString;
        ListUsers.Add(MyUser);
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

procedure TUser.SetIDUser(const Value: integer);
begin
  FIDUser := Value;
end;

procedure TUser.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

function TUser.Autorization(DBQ:TadoQuery;Pass:String):Boolean;
var
  StrSQL: string;
  qr: TADOQuery;
begin
  try
    StrSQL := 'SELECT * FROM medic WHERE FIO_med = :FIO_med and pass = :pass';
    qr := TADOQuery.Create(DBQ.Owner);
    try
      qr.Connection := DBQ.Connection;
      qr.ParamCheck := False;
      qr.Parameters.Clear;

      qr.sql.Text := StrSQL;

      qr.Parameters.AddParameter.Name := 'FIO_med';
      qr.Parameters.ParamByName('FIO_med').DataType := ftString;
      qr.Parameters.ParamByName('FIO_med').Value := FUserName;

      qr.Parameters.AddParameter.Name := 'Pass';
      qr.Parameters.ParamByName('Pass').DataType := ftString;
      qr.Parameters.ParamByName('Pass').Value := Pass;

      qr.Open;
      if qr.RecordCount > 0 then
      begin
       Result := true;
       FIDUser := qr.FieldByName('id_med').AsInteger;
      end
      else
       Result:= false;
    finally
      qr.Free;
    end;
  except
    on E:Exception do
      ShowMessage(e.Message);
  end;
end;

end.

