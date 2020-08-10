unit MyFunctions;

interface
uses
User,Reception,Patient,Generics.Collections,Data.DB, Data.Win.ADODB,Vcl.Dialogs,System.SysUtils,AdvGrid,Winapi.ActiveX,System.Win.ComObj,System.Variants,
Forms,Vcl.Controls,extCtrls,stdCtrls,grids;

//Отображаем все приемы
procedure ShowAllReceptions(Grid:TADVStringGrid;ListReception :TObjectList<TReception>; ListPatients :TObjectList<TPatient>;ListUsers:TObjectList<TUser>);

// Сохранение таблицы в Excel
procedure SaveXLS(FileName: string; Table: TADVStringGrid;
  ColInt, ColFl, ColData, ColHide: Array of integer);

// Создание OLE объекта
function CreateOleObject(const ClassName: string): IDispatch;

//Процедура которую утащил из своего проекта.. на проверку валидности цены
procedure EditKeyPressFilterCena(Sender: TObject; var Key: char; Znaki: byte);

function CopyCell(Table: TADVStringGrid): string;

function NBetween(n, n1, n2: integer): boolean;

//Удаление стрки
procedure DelRow(SG: TStringGrid; idx: integer);


// Фильтр по User
procedure SortSGWithUser(Grid:TADVStringGrid;SortedUser:String);

procedure SortedWithDate(Grid:TADVStringGrid;DateAfter,DatePrev:TDateTime);


implementation

//Отображаем все приемы
procedure ShowAllReceptions(Grid:TADVStringGrid;ListReception :TObjectList<TReception>; ListPatients :TObjectList<TPatient>;ListUsers:TObjectList<TUser>);
var
Row,i,idx:integer;
begin
  //  ID приема
  //  датой,
  //  фио пациента,
  //  номером полиса,
  //  поставленным диагнозом (текст),
  //  назначенным лечением,
  //  стоимостью приема,
  //  врачем, который этот прием выполнил
  Grid.ClearNormalCells;
  for i := 0 to ListReception.Count - 1 do
    begin
      Row := i + Grid.FixedRows;
      Grid.RowCount := ListReception.Count + Grid.FixedRows;
      Grid.Cells[0, Row] := ListReception[i].IdRec.ToString;
      Grid.Cells[1, Row] := DateTimeToStr(ListReception[i].Date);
   
      for idx := 0 to ListPatients.Count - 1 do
        if ListReception[i].IdPatient = ListPatients[idx].IdPatient then
          Break;

      Grid.Cells[2, Row] := ListPatients[idx].FIO;
      Grid.Cells[3, Row] := ListPatients[idx].NumPol;
      Grid.Cells[4, Row] := ListReception[i].Diagnosis;
      Grid.Cells[5, Row] := ListReception[i].Treatment;
      Grid.Cells[6, Row] := FormatFloat('0.00',ListReception[i].Price) + 'р.';

      for idx := 0 to ListUsers.Count - 1 do
        if ListReception[i].IdUser = ListUsers[idx].IdUser then
          Break;

      Grid.Cells[7, Row] := ListUsers[idx].UserName; //Сюда ФИО ВРАЧА
    end;
end;


//Отображаем все приемы
procedure SortAllReceptions(Grid:TADVStringGrid;ListReception :TObjectList<TReception>; ListPatients :TObjectList<TPatient>;ListUsers:TObjectList<TUser>);
var
Row,i,idx:integer;
begin
  //  ID приема
  //  датой,
  //  фио пациента,
  //  номером полиса,
  //  поставленным диагнозом (текст),
  //  назначенным лечением,
  //  стоимостью приема,
  //  врачем, который этот прием выполнил
  Grid.ClearNormalCells;
  for i := 0 to ListReception.Count - 1 do
    begin
      Row := i + Grid.FixedRows;
      Grid.RowCount := ListReception.Count + Grid.FixedRows;
      Grid.Cells[0, Row] := ListReception[i].IdRec.ToString;
      Grid.Cells[1, Row] := DateTimeToStr(ListReception[i].Date);

      for idx := 0 to ListPatients.Count - 1 do
        if ListReception[i].IdPatient = ListPatients[idx].IdPatient then
          Break;

      Grid.Cells[2, Row] := ListPatients[idx].FIO;
      Grid.Cells[3, Row] := ListPatients[idx].NumPol;
      Grid.Cells[4, Row] := ListReception[i].Diagnosis;
      Grid.Cells[5, Row] := ListReception[i].Treatment;
      Grid.Cells[6, Row] := FormatFloat('0.00',ListReception[i].Price) + 'р.';

      for idx := 0 to ListUsers.Count - 1 do
        if ListReception[i].IdUser = ListUsers[idx].IdUser then
          Break;

      Grid.Cells[7, Row] := ListUsers[idx].UserName; //Сюда ФИО ВРАЧА
    end;
end;

// Сохранение таблицы в Excel
procedure SaveXLS(FileName: string; Table: TADVStringGrid;
  ColInt, ColFl, ColData, ColHide: Array of integer);
var
  XL, Workbook, ArrayData, Cell1, Cell2, Range, Sheet: Variant;
  rez: HRESULT;
  i, j, BeginCol, BeginRow, ColCnt, RowCnt, col: integer;
  ClassID: TCLSID;
begin
  rez := CLSIDFromProgID(PWideChar(WideString('Excel.Application')), ClassID);
  // Ищем CLSID OLE-объекта
  if rez = S_OK then
    try
      // Screen.Cursor := crHourglass;
      BeginCol := 1;
      // Координаты левого верхнего угла области, в которую будем выводить данные
      BeginRow := 1;
      XL := CreateOleObject('Excel.Application'); // Создание Excel
      XL.DisplayAlerts := false;
      XL.Application.EnableEvents := false;  // Отключаем реакцию Excel на события, чтобы ускорить вывод информации
      Workbook := XL.WorkBooks.Add;
      ColCnt := Table.ColCount;
      RowCnt := Table.RowCount;

      XL.WorkBooks[1].WorkSheets[1].Name := 'Накладные';
      ArrayData := VarArrayCreate([1, RowCnt, 1, ColCnt], varVariant);
      // Создаем Вариантный Массив, который заполним выходными данными
      col := 1;

      for j := 0 to RowCnt - 1 do
      begin
        col := 1;
        for i := 1 to ColCnt + Table.NumHiddenColumns - 1 do
          if Table.IsHiddenColumn(i) = false then
          begin
            if j = 0 then
              ArrayData[j + 1, col] := Table.Cells[i, j]
            else
            begin
//                if Among(i, ColFl) then
//                  ArrayData[j + 1, col] := StrToFloat(Table.Cells[i, j])
//                else
                ArrayData[j + 1, col] := Table.Cells[i, j];
            end;
            inc(col);
          end;
      end;

      Sheet := XL.ActiveWorkBook.Sheets[1];
      Sheet.Range[Sheet.Cells[1, 1], Sheet.Cells[RowCnt, ColCnt]].NumberFormat
        := AnsiChar('@');

      for i := 0 to High(ColFl) do
        Sheet.Range[Sheet.Cells[1, ColFl[i] - 1],
          Sheet.Cells[RowCnt, ColFl[i]]].NumberFormat := '0' +
        {$IF CompilerVersion >= 24}FormatSettings.{$IFEND}DecimalSeparator + '00';

      for i := 0 to High(ColInt) do
        Sheet.Range[Sheet.Cells[1, ColInt[i] - 1],
          Sheet.Cells[RowCnt, ColInt[i]]].NumberFormat := '0';

      for i := 0 to High(ColData) do
      begin
        j := ColData[i];
        Sheet.Range[Sheet.Cells[1, j - 1], Sheet.Cells[RowCnt, j]]
          .NumberFormat := 'ДД.ММ.ГГ;@';
      end;

      Cell1 := Workbook.WorkSheets[1].Cells[BeginRow, BeginCol];
      // Левая верхняя ячейка области, в которую будем выводить данные
      Cell2 := Workbook.WorkSheets[1].Cells[BeginCol + RowCnt - 1,
        BeginRow + ColCnt - 2];
      // Правая нижняя ячейка области, в которую будем выводить данные
      Range := Workbook.WorkSheets[1].Range[Cell1, Cell2];
      // Область, в которую будем выводить данные
      Range.Value := ArrayData;
      // А вот и сам вывод данных. Намного быстрее поячеечного присвоения

      Sheet.Rows[1].Font.Size := 12;
      Sheet.Rows[1].Font.Bold := true;
      Sheet.Range[Sheet.Cells[1, 1], Sheet.Cells[RowCnt, ColCnt]]
        .EntireColumn.AutoFit;

      for i := 0 to High(ColHide) do
      begin
        j := ColHide[i];
        Sheet.Columns[j].Hidden := true;
      end;

      XL.ActiveWorkBook.SaveAs(FileName);
      XL.DisplayAlerts := true;
      XL.Visible := true; // Делаем Excel видимым
      XL := UnAssigned;
      Screen.Cursor := crDefault;
    except
      XL.DisplayAlerts := false;
      XL.ActiveWorkBook.Close;
      XL.Application.Quit;
      Sheet := UnAssigned;
      XL := UnAssigned;
    end;
end;

// Создание OLE объекта
function CreateOleObject(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
begin
  try
    ClassID := ProgIDToClassID(ClassName);
    OleCheck(CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
      CLSCTX_LOCAL_SERVER, IDispatch, Result));
  except
    on E: EOleSysError do
      raise EOleSysError.Create(Format('%s, ProgID: "%s"',
        [E.Message, ClassName]), E.ErrorCode, 0) { Do not localize }
  end;
end;

procedure EditKeyPressFilterCena(Sender: TObject; var Key: char; Znaki: byte);
var
  vrPos, vrLength, vrSelStart: byte;
  NextText: string;
  i: byte;
begin
  i := Znaki - 1; // количество знаков после запятой
  if (Sender is TEdit) then
    with (Sender as TEdit) do
    begin
      vrLength := Length(Text); // определяем длину текста
      vrPos := Pos(',', Text); // проверяем наличие запятой
      vrSelStart := SelStart; // определяем положение курсора
    end;
  if (Sender is TLabeledEdit) then
    with (Sender as TLabeledEdit) do
    begin
      vrLength := Length(Text); // определяем длину текста
      vrPos := Pos(',', Text); // проверяем наличие запятой
      vrSelStart := SelStart; // определяем положение курсора
    end;


  case Key of
    #13, #8:
      ; // цифры и <Back Space>

    '0'..'9':
      begin
        // проверяем положение курсора и количество знаков после запятой
        if (vrPos > 0) and (vrLength - vrPos > i) and (vrSelStart >= vrPos) then
          Key := #0; // "погасить" клавишу
        if (Sender is TEdit) then
          if Trim((Sender as TEdit).Text) <> '' then
          begin
            NextText := Trim((Sender as TEdit).Text);
            if (vrPos > 0) and (vrSelStart >= vrPos) then
              Insert(Key, NextText, vrSelStart + 1)
            else
              Insert(Key, NextText, vrSelStart);

            if StrToFloat(NextText) > 9999.99 then
              Key := #0;
          end;
        if (Sender is TLabeledEdit) then
          if Trim((Sender as TLabeledEdit).Text) <> '' then
          begin
            NextText := Trim((Sender as TLabeledEdit).Text);
            if (vrPos > 0) and (vrSelStart >= vrPos) then
              Insert(Key, NextText, vrSelStart + 1)
            else
              Insert(Key, NextText, vrSelStart);

            if StrToFloat(NextText) > 9999.99 then
              Key := #0;
          end;
      end;
    '.', ',': // разделитель целой и дробной частей числа
      begin
        if Key <> FormatSettings.DecimalSeparator then
          Key := FormatSettings.DecimalSeparator;
        // заменим разделитель на допустимый
        if (Sender is TEdit) then
          if Pos(FormatSettings.DecimalSeparator, (Sender as TEdit).Text) <> 0 then
            Key := Chr(0); // запрет ввода второго разделителя

        if (Sender is TLabeledEdit) then
          if Pos(FormatSettings.DecimalSeparator, (Sender as TLabeledEdit).Text) <> 0 then
            Key := Chr(0); // запрет ввода второго разделителя
      end;
  else // остальные символы запрещены
    Key := Chr(0);
  end;
end;

function CopyCell(Table: TADVStringGrid): string;
  var
    r, c: integer;
    txt: string;
  begin
    txt := '';
    with Table do
    begin
      r := row;

      c := RealColIndex(col);
      if NBetween(r, FixedRows, RowCount - 1) and NBetween(c, 1, ColCount - 1)
      then
        txt := Cells[c, r];
    end;
    Result := txt;
  end;


function NBetween(n, n1, n2: integer): boolean;
  begin
    if ((n1 <= n) and (n <= n2)) then
      Result := true
    else
      Result := false;
  end;

// Реализация проzцедуры удаления строки
type
  TMyGreed = class(Grids.TCustomGrid)
  end;

procedure DelRow(SG: TStringGrid; idx: integer);
begin
  TMyGreed(SG).DeleteRow(idx);
end;

// Фильтр по User
procedure SortSGWithUser(Grid:TADVStringGrid;SortedUser:String);
var
i:integer;
begin
ShowAllReceptions(Grid,ListReception,ListPatient,ListUsers);
 for i := Grid.RowCount - 1 downto Grid.FixedRows do
   begin
     if Grid.Cells[7,i] <> SortedUser then
       DelRow(Grid,i);
   end;
end;

procedure SortedWithDate(Grid:TADVStringGrid;DateAfter,DatePrev:TDateTime);
var
i:integer;
begin
 for i := Grid.RowCount - 1 downto Grid.FixedRows do
   begin
     if not ((StrToDateTime(Grid.Cells[1,i]) > DateAfter) and (StrToDateTime(Grid.Cells[1,i]) < DatePrev)) then
       DelRow(Grid,i);
   end;
end;

end.
