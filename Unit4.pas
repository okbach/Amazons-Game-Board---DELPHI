unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TForm4 = class(TForm)
    Rectangle1: TRectangle;
    Fi: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Rectangle5: TRectangle;
    Label1: TLabel;
    Switch1: TSwitch;
    Rectangle6: TRectangle;
    procedure FiClick(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form4: TForm4;
  color1,color2:integer;
  sound:boolean;
implementation

{$R *.fmx}

uses Unit1;

procedure TForm4.FormHide(Sender: TObject);
begin
unit1.save;
end;

procedure TForm4.RadioButton1Change(Sender: TObject);
begin
 color1:= $FF000000 ;
  color2 := $FFFFF8DF ;
end;

procedure TForm4.RadioButton2Change(Sender: TObject);
begin
  color1:=$FF584b5d; color2 :=$FFd9d2cc;
end;

procedure TForm4.RadioButton3Change(Sender: TObject);
begin
color1:=$FFffe0a7 ;color2 :=$FFc48248 ;
end;

procedure TForm4.FiClick(Sender: TObject);
begin
RadioButton1.IsChecked:=true;
  color1:= $FF000000 ;
  color2 := $FFFFF8DF ;
end;

procedure TForm4.Rectangle3Click(Sender: TObject);
begin
RadioButton2.IsChecked:=true;
color1:=$FF584b5d; color2 :=$FFd9d2cc;
end;

procedure TForm4.Rectangle4Click(Sender: TObject);
begin
RadioButton3.IsChecked:=true;
color1:=$FFffe0a7 ;color2 :=$FFc48248 ;
end;

procedure TForm4.Rectangle6Click(Sender: TObject);
begin
form1.show;
end;

procedure TForm4.Switch1Switch(Sender: TObject);
begin
if Switch1.IsChecked then   sound:=true else sound:=false;
end;

end.
