unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet,
  IBX.IBTable, IBX.IBDatabase, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, IBX.IBSQL;

type
  TForm1 = class(TForm)
    IBDatabase1: TIBDatabase;
    IBTable1: TIBTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    IBTransaction1: TIBTransaction;
    ToolBar1: TToolBar;
    ujBT: TButton;
    torlBT: TButton;
    renBT: TButton;
    megsBT: TButton;
    refBT: TButton;
    kilBT: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NevEdit: TEdit;
    SulEdit: TEdit;
    AnyNevEdit: TEdit;
    IBSQL1: TIBSQL;

    procedure IBTable1BeforePost(DataSet: TDataSet);
    procedure ujBTClick(Sender: TObject);
    procedure refBTClick(Sender: TObject);
    procedure kilBTClick(Sender: TObject);
    procedure torlBTClick(Sender: TObject);
    procedure renBTClick(Sender: TObject);
    procedure megsBTClick(Sender: TObject);
    procedure clear();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.IBTable1BeforePost(DataSet: TDataSet);
begin

  if (mrNo = MessageDlg('biztos', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0)) then
  begin
    if DataSet.State in [dsEdit, dsInsert] then
      DataSet.Cancel();
    Abort;
  end;
end;

procedure TForm1.kilBTClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.megsBTClick(Sender: TObject);
begin
if (mrYes = MessageDlg('biztos nem menti?', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0)) then
  begin
    clear();
  end;

end;

procedure TForm1.refBTClick(Sender: TObject);
begin
DBGrid1.DataSource.DataSet.DisableControls;
try
  IBTable1.Close;
  IBTable1.Open;
finally
  DBGrid1.DataSource.DataSet.EnableControls;
end;
end;

procedure TForm1.renBTClick(Sender: TObject);
begin
  if (mrYes = MessageDlg('biztos menti?', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0)) then
  begin
    IBSQL1.ParamByName('NEV').AsString := NevEdit.Text;
    IBSQL1.ParamByName('SZDAT').AsDate := StrToDate(SulEdit.Text);
    IBSQL1.ParamByName('ANYJA').AsString := AnyNevEdit.Text;
    IBSQL1.ExecQuery();
    IBSQL1.Close();
     IBTransaction1.CommitRetaining;
    clear();
  end;

end;

procedure TForm1.torlBTClick(Sender: TObject);
begin

  if (mrYes = MessageDlg('biztos törli?', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0)) then
  begin
    IBTable1.Delete();
  end;
end;

procedure TForm1.ujBTClick(Sender: TObject);
begin
  Label1.Enabled := true;
  Label2.Enabled := true;
  Label3.Enabled := true;
  NevEdit.Enabled := true;
  SulEdit.Enabled := true;
  AnyNevEdit.Enabled := true;
  renBT.Enabled := true;
  megsBT.Enabled := true;
  ujBT.Enabled := false;
  kilBT.Enabled := false;
  refBT.Enabled := false;
  torlBT.Enabled := false;
end;

procedure TForm1.clear();
begin
  Label1.Enabled := false;
  Label2.Enabled := false;
  Label3.Enabled := false;
  NevEdit.Text := '';
  SulEdit.Text := '';
  AnyNevEdit.Text := '';
  NevEdit.Enabled := true;
  SulEdit.Enabled := false;
  AnyNevEdit.Enabled := false;
  renBT.Enabled := false;
  megsBT.Enabled := false;
  ujBT.Enabled := true;
  kilBT.Enabled := true;
  refBT.Enabled := true;
  torlBT.Enabled := true;
end;

end.
