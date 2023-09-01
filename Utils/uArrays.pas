// –азнообразные манипул€ции с массивами данных
unit uArrays;

interface

type
  TDoubleArray = array of Double;
  TIntegerArray = array of Integer;
  TVariantArray = array of Variant;
  TStringArray = array of string;
  TDateTimeArray = array of TDateTime;

{ ѕреобразование массивов в строки }
function ArrayToString(const pArray: TDoubleArray; const pDelimiter: Char = ','): string; overload;
function ArrayToString(const pArray: TIntegerArray; const pDelimiter: Char = ','): string; overload;
function ArrayToString(const pArray: TVariantArray; const pDelimiter: Char = ','): string; overload;
function ArrayToString(const pArray: TStringArray; const pDelimiter: Char = ','): string; overload;

{ ѕреобразование строки в массив }
function StringToArray(const pString: string; const pDelimiter: Char = ','): TStringArray;

{ ƒобавление значений в конец массивов }
procedure AppendToArray(var pArray: TDoubleArray; const pValue: Double); overload;
procedure AppendToArray(var pArray: TIntegerArray; const pValue: Integer); overload;
procedure AppendToArray(var pArray: TVariantArray; const pValue: Variant); overload;
procedure AppendToArray(var pArray: TStringArray; const pValue: string); overload;

{  опирование массивов }
procedure CloneArray(const pSrcArray: TDoubleArray; var pDstArray: TDoubleArray); overload;
procedure CloneArray(const pSrcArray: TIntegerArray; var pDstArray: TIntegerArray); overload;
procedure CloneArray(const pSrcArray: TVariantArray; var pDstArray: TVariantArray); overload;
procedure CloneArray(const pSrcArray: TStringArray; var pDstArray: TStringArray); overload;

{ ѕоиск элементов вхождени€ первого элемента в массив }
function FindInArray(const pArray: TDoubleArray; const pValue: Double): Integer; overload;
function FindInArray(const pArray: TIntegerArray; const pValue: Integer): Integer; overload;
function FindInArray(const pArray: TVariantArray; const pValue: Variant): Integer; overload;
function FindInArray(const pArray: TStringArray; const pValue: string): Integer; overload;

{ ¬ыполдн€ет распределение заданного значени€ по второму массиву
  пропорционально значени€м первого массива:
  pValue     - распредел€емое значение,
  pArray     - массив, пропорционально которому распредел€ем
  pOutput    - массив, куда сохран€ем результат
  pPrecision - количество знаков после зап€той, до которого округл€ем }
procedure DistributeValueToArray(const pValue: Double; const pArray,
  pOutput: TDoubleArray; const pPrecision: Integer);

implementation

uses
  uConversion, SysUtils, Variants, Classes, Math;

function ArrayToString(const pArray: TDoubleArray; const pDelimiter: Char = ','): string;
var
  Index: Integer;
begin
  Result := '';
  for Index := 0 to Length(pArray) - 1 do
  begin
    if Length(Result) <> 0 then
      Result := Result + pDelimiter;
    Result := Result + ValueToString(pArray[Index]);
  end;
end;

function ArrayToString(const pArray: TIntegerArray; const pDelimiter: Char = ','): string;
var
  Index: Integer;
begin
  Result := '';
  for Index := 0 to Length(pArray) - 1 do
  begin
    if Length(Result) <> 0 then
      Result := Result + pDelimiter;
    Result := Result + IntToStr(pArray[Index]);
  end;
end;

function ArrayToString(const pArray: TVariantArray; const pDelimiter: Char = ','): string;
var
  Index: Integer;
  Value: Double;
begin
  Result := '';
  for Index := 0 to Length(pArray) - 1 do
  begin
    if Length(Result) <> 0 then
      Result := Result + pDelimiter;
    if VarIsFloat(pArray[Index]) then
    begin
      Value := pArray[Index];
      Result := Result + ValueToString(Value);
    end
    else
      Result := Result + VarToStr(pArray[Index]);
  end;
end;

function ArrayToString(const pArray: TStringArray; const pDelimiter: Char = ','): string;
var
  Index: Integer;
begin
  Result := '';
  for Index := 0 to Length(pArray) - 1 do
  begin
    if Length(Result) <> 0 then
      Result := Result + pDelimiter;
    Result := Result + pArray[Index];
  end;
end;

procedure AppendToArray(var pArray: TDoubleArray; const pValue: Double);
var
  Index: Integer;
begin
  Index := Length(pArray);
  SetLength(pArray, Index + 1);
  pArray[Index] := pValue;
end;

procedure AppendToArray(var pArray: TIntegerArray; const pValue: Integer);
var
  Index: Integer;
begin
  Index := Length(pArray);
  SetLength(pArray, Index + 1);
  pArray[Index] := pValue;
end;

procedure AppendToArray(var pArray: TVariantArray; const pValue: Variant);
var
  Index: Integer;
begin
  Index := Length(pArray);
  SetLength(pArray, Index + 1);
  pArray[Index] := pValue;
end;

function FindInArray(const pArray: TDoubleArray; const pValue: Double): Integer;
var
  Index, Number: Integer;
begin
  Index := 0;
  Number := Length(pArray);
  while (Index < Number) and (pValue <> pArray[Index]) do
    Inc(Index);
  if Index <> Number then
    Result := Index
  else
    Result := -1;
end;

function FindInArray(const pArray: TIntegerArray; const pValue: Integer): Integer;
var
  Index, Number: Integer;
begin
  Index := 0;
  Number := Length(pArray);
  while (Index < Number) and (pValue <> pArray[Index]) do
    Inc(Index);
  if Index <> Number then
    Result := Index
  else
    Result := -1;
end;

function FindInArray(const pArray: TVariantArray; const pValue: Variant): Integer;
var
  Index, Number: Integer;
begin
  Index := 0;
  Number := Length(pArray);
  while (Index < Number) and (pValue <> pArray[Index]) do
    Inc(Index);
  if Index <> Number then
    Result := Index
  else
    Result := -1;
end;

function StringToArray(const pString: string; const pDelimiter: Char = ','): TStringArray;
var
  Index, Number: Integer;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    Number := ExtractStrings([pDelimiter], [], PChar(pString), StringList);
    SetLength(Result, Number);
    for Index := 0 to Number - 1 do
      Result[Index] := StringList[Index];
  finally
    FreeAndNil(StringList);
  end;
end;

function FindInArray(const pArray: TStringArray; const pValue: string): Integer; overload;
var
  Index, Number: Integer;
begin
  Index := 0;
  Number := Length(pArray);
  while (Index < Number) and (pValue <> pArray[Index]) do
    Inc(Index);
  if Index <> Number then
    Result := Index
  else
    Result := -1;
end;

procedure AppendToArray(var pArray: TStringArray; const pValue: string);
var
  Index: Integer;
begin
  Index := Length(pArray);
  SetLength(pArray, Index + 1);
  pArray[Index] := pValue;
end;

procedure CloneArray(const pSrcArray: TDoubleArray; var pDstArray: TDoubleArray);
var
  Index, Count: Integer;
begin
  Count := Length(pSrcArray);
  SetLength(pDstArray, Count);
  for Index := 0 to Count - 1 do
    pDstArray[Index] := pSrcArray[Index];
end;

procedure CloneArray(const pSrcArray: TIntegerArray; var pDstArray: TIntegerArray);
var
  Index, Count: Integer;
begin
  Count := Length(pSrcArray);
  SetLength(pDstArray, Count);
  for Index := 0 to Count - 1 do
    pDstArray[Index] := pSrcArray[Index];
end;

procedure CloneArray(const pSrcArray: TVariantArray; var pDstArray: TVariantArray);
var
  Index, Count: Integer;
begin
  Count := Length(pSrcArray);
  SetLength(pDstArray, Count);
  for Index := 0 to Count - 1 do
    pDstArray[Index] := pSrcArray[Index];
end;

procedure CloneArray(const pSrcArray: TStringArray; var pDstArray: TStringArray);
var
  Index, Count: Integer;
begin
  Count := Length(pSrcArray);
  SetLength(pDstArray, Count);
  for Index := 0 to Count - 1 do
    pDstArray[Index] := pSrcArray[Index];
end;

procedure DistributeValueToArray(const pValue: Double; const pArray,
  pOutput: TDoubleArray; const pPrecision: Integer);
var
  Index, Count: Integer;
  Value, Rest, Sum: Double;
begin
  Count := Length(pArray);
  if Count = 0 then
    raise Exception.Create('DistributeValueToArray: массив пуст');
  if Count <> Length(pOutput) then
    raise Exception.Create('DistributeValueToArray: длины массивов различны');

  Sum := 0;
  for Index := 0 to Count - 1 do
  begin
    Sum := Sum + pArray[Index];
    pOutput[Index] := 0;
  end;
  { ≈сли сумма элементов первого массива равна 0, то возвращаем обнуленный
    массив (иначе будет деление на 0) }
  if Sum = 0 then
    Exit;

  { ƒл€ всех элементов кроме последнего скидываем значени€, вычисленные
    пропорционально }
  Rest := pValue;
  for Index := 0 to Count - 2 do
  begin
    Value := RoundTo(pValue * pArray[Index] / Sum, pPrecision * -1);
    Rest := Rest - Value;
    pOutput[Index] := Value;
  end;
  pOutput[Count - 1] := Rest;
end;

end.
