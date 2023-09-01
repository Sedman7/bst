unit uConversion;

{ ѕреобразовани€ данных различных типов м/д собой }

interface

{ ѕреобразование значений в string }
function ValueToString(const pValue: Double): string; {overload;}
{ ѕреобразование значений в Double }
function ValueToDouble(const pValue: Variant): Double; {overload;}
{ ѕреобразование значений в Integer }
function ValueToInteger(const pValue: Variant): Integer; {overload;}

implementation

uses
  SysUtils, Variants;

var
  FormatSettings: TFormatSettings;

{ »спользование FloatToStr из SysUtils не рекомендуетс€, т.к. существует баг во
  врем€ работы программы, который никак еще не воспроизведен, но встречаетс€
  часто, когда посреди работы программы разделитель целой и дробной частей
  внезапно мен€етс€ на ",", несмотр€ на то, что он был €вно установлен в "."
  пр и нициализации Resource. Ќе надо пытатьс€ обойти это через присвоение
  вариантных типов, т.к. при присвоении используетс€ та же функци€ FloatToStr,
  но вызов идет из через _VarCast модул€ Variants }

function ValueToString(const pValue: Double): string;
begin
  Result := FloatToStr(pValue, FormatSettings);
end;

function ValueToDouble(const pValue: Variant): Double;
begin
  if VarIsNumeric(pValue) then
    Result := pValue
  else
    Result := 0;
end;

function ValueToInteger(const pValue: Variant): Integer;
begin
  if VarIsNumeric(pValue) then
    Result := pValue
  else
    Result := 0;
end;

initialization
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ' ';
end.
