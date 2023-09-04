unit uOwnersNew;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseForm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.Menus, System.Actions, Vcl.ActnList, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxSplitter, Vcl.StdCtrls,
  cxButtons, cxGroupBox, cxLabel, cxTextEdit, cxCheckBox, Vcl.ExtCtrls;

type
  TfmOwnersNew = class(TfmBaseForm)
    Fam: TcxTextEdit;
    Name: TcxTextEdit;
    sName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxCheckClose: TcxCheckBox;
    Panel1: TPanel;
    cxLabel4: TcxLabel;
    phone: TcxTextEdit;
    procedure actSaveExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure loadOwner(id: integer);
  end;

var
  fmOwnersNew: TfmOwnersNew;

implementation

{$R *.dfm}

Uses uRes;

procedure TfmOwnersNew.actSaveExecute(Sender: TObject);
Const
  SQL:string='select main.owner_create(:pfam, :pname, :psname, :pphone);';
begin
  inherited;

  If MessageBox(handle, PChar('Создать владельца ['+Fam.Text+' '+Name.Text+' '+sName.Text+'] в базе?'), PChar('Создание владельца'), MB_YESNO+MB_ICONQUESTION)=idyes then Begin
      Res.ExecSQL(SQL,'pfam;pname;psname;pphone',
                      [Fam.Text, Name.Text, sName.Text, phone.Text]);

      //закрываем окно если стоит причка, если нет - очищаем параметры
      if cxCheckClose.Checked then Close
        Else Begin
          actEraser.Execute;
          //MakeColors(false);
        End;

    End;
end;

procedure TfmOwnersNew.FormShow(Sender: TObject);
begin
  //inherited;
  if RecivedID > 0 then
  Edit1.Text := IntToStr(RecivedID);
  
end;

procedure TfmOwnersNew.loadOwner(id: integer);
begin
  RecivedID := id;
  qBase.Close;
  qBase.SQL.Text := 'select * from main.owners where idowner = ' + IntToStr(id);
  qBase.Open;

  Fam.Text := qBase.Fields.FieldByName('Fam').AsString;
  Name.Text := qBase.Fields.FieldByName('Name').AsString;
  sName.Text := qBase.Fields.FieldByName('sName').AsString;
  phone.Text := qBase.Fields.FieldByName('phone').AsString;

end;

end.
