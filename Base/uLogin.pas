unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, cxLabel;

type
  TfmLogin = class(TForm)
    cxLogin: TcxTextEdit;
    cxPass: TcxTextEdit;
    cxButEnter0: TcxButton;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxServer: TEdit;
    cxLabel3: TcxLabel;
    cxPort: TEdit;
    cxLabel4: TcxLabel;
    cxButton1: TcxButton;
    procedure cxButEnter0Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

{$R *.dfm}

uses uRes, uMain;

procedure TfmLogin.cxButEnter0Click(Sender: TObject);
Var
  ok:byte;
begin
  Try
    Res.ZConnection1.User:=cxLogin.Text;
    Res.ZConnection1.Password:=cxPass.Text;
    Res.ZConnection1.Connect;
    ok:=1;
  Except
    ShowMessage('Ќеверное им€ пользовател€ или пароль.');
    ok:=0;
  End;

  if ok=1 then Begin
    // сохран€ем конфигурацию
    Res.IniUserSave(cxLogin.Text,cxServer.Text,cxPort.Text);

    // установка флага - начало сессии
    uRes.SESSION.ISCONNECT:=true;

    // устанавливаем пользовател€ на сессию
    uRes.SESSION.USERNAME:=cxLogin.Text;

    // устанавливаем роли
    uRes.SESSION.bst_Admin:=Res.CheckRole(uRes.SESSION.USERNAME,'bst_admin');
    uRes.SESSION.bst_User:=Res.CheckRole(uRes.SESSION.USERNAME,'bst_user');
    uRes.SESSION.bst_Guest:=Res.CheckRole(uRes.SESSION.USERNAME,'bst_guest');

    fmMain.show;
{    fmMain:= TfmMain.Create(Application);
    fmMain.FormStyle:=fsMDIForm;
    fmMain.Caption:= 'Ќовое сообщение';
    fmMain.Show;}
    Close;
  End

end;

procedure TfmLogin.cxButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmLogin.FormCreate(Sender: TObject);
begin
  //загружаем настройки окна
  Res.IniWindowLoad(Self,320,180);

  //загружаем параметры входа
  cxLogin.Text:=Res.IniUserLoginLoad;
  cxServer.Text:=Res.IniUserServerLoad;
  cxPort.Text:=Res.IniUserPortLoad;

  fmMain.Visible:=false;
  Res.ZConnection1.Disconnect;
  Res.Visible:=false;
end;

procedure TfmLogin.FormDestroy(Sender: TObject);
begin
  Res.IniWindowSave(Self);
end;

procedure TfmLogin.FormShow(Sender: TObject);
begin
  //fmMain.Visible:=false;
  //Res.IniWindowLoad(Self,320,180);
end;

end.
