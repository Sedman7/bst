unit uMain;//

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxButtons, cxControls,
  dxSkinsdxStatusBarPainter, dxStatusBar, dxSkinsdxBarPainter, cxClasses, dxBar;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    dxMainStatus: TdxStatusBar;
    dxBarManager1: TdxBarManager;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    procedure N4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
  private
    { Private declarations }
    procedure initAll;       //обнуляем все меню
   // procedure initAdmin;  //инициализируем права админа
   // procedure initUser;   //инициализируем права пользователя
   // procedure initGuest;  //инициализируем права гостя
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses uBaseForm, uRes, uObjects, uOwners, uUsers, uLogin, uBaseGrid, uScaleType,
  uSprStatus, uScales;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Res.IniWindowLoad(Self,800,600);
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Res.IniWindowSave(Self);
end;

procedure TfmMain.initAll;
Begin

  fmBaseForm:= TfmBaseForm.Create(Application);
  fmBaseGrid:= TfmBaseGrid.Create(Application);

  fmMain.N6.Visible:=false; //скрыть меню администрирование
End;

procedure TfmMain.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOW);

  initAll;

  If uRes.SESSION.bst_Admin then fmMain.N6.Visible:=true; //показать меню администрирование для админа
end;

procedure TfmMain.N10Click(Sender: TObject);
begin
  fmSprStatus:=TfmSprStatus.Create(Application);
  fmSprStatus.Show;
end;

procedure TfmMain.N15Click(Sender: TObject);
begin
  fmSprScaleType:=TfmSprScaleType.Create(Application);
  fmSprScaleType.Show;
end;

procedure TfmMain.N18Click(Sender: TObject);
begin
  Cascade;
end;

procedure TfmMain.N19Click(Sender: TObject);
begin
  Tile;
  TileMode := tbVertical; //tbHorizontal
end;

procedure TfmMain.N20Click(Sender: TObject);
begin
  fmScales:=TfmScales.Create(Application);
  fmScales.Caption:='Приборы учета';
  fmScales.Show;
end;

procedure TfmMain.N2Click(Sender: TObject);
begin
  Close;
end;

//показать объекты
procedure TfmMain.N4Click(Sender: TObject);
begin
 // ShowMessage('obj');
  fmObjects:=TfmObjects.Create(Application);
  fmObjects.Caption:='Объекты';
  fmObjects.Show;
end;


procedure TfmMain.N5Click(Sender: TObject);
begin
 // ShowMessage('obj');
  fmOwners:=TfmOwners.Create(Application);
  fmOwners.Caption:='Собственники';
  fmOwners.Show;
end;

procedure TfmMain.N7Click(Sender: TObject);
begin
  fmUsers:=TfmUsers.Create(Application);
  fmUsers.Caption:='Пользователи';
  fmUsers.Show;
end;

//CREATE ROLE aaa NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN PASSWORD '111';

end.
