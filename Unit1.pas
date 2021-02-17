unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Advertising,//MX.FontGlyphs.Android
 //TL.Controls;
    {$IF Defined(IOS)}
  macapi.helpers, iOSapi.Foundation, FMX.helpers.iOS;
{$ELSEIF Defined(ANDROID)}
  //Network,
  Fmx.InterstitialAd.Android,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net,
  Androidapi.JNI.App,
  Androidapi.helpers;
{$ELSEIF Defined(MACOS)}
  Posix.Stdlib;
{$ELSEIF Defined(MSWINDOWS)}
  Winapi.ShellAPI, Winapi.Windows;
{$ENDIF}
type
  TForm1 = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Rectangle5: TRectangle;
    Label1: TLabel;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Label5: TLabel;
    Rectangle8: TRectangle;
    Label6: TLabel;
    BannerAd1: TBannerAd;
    Rectangle9: TRectangle;
    Label7: TLabel;
    Rectangle10: TRectangle;
    Label8: TLabel;
    Rectangle11: TRectangle;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Label9: TLabel;
    Timer1: TTimer;
    Label10: TLabel;
    procedure Rectangle1Click(Sender: TObject);
    procedure Rectangle10Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure Rectangle7Click(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
    procedure Rectangle9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rectangle12Click(Sender: TObject);
    procedure Rectangle13Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     {$IF Defined(ANDROID)}
    IAdvertisment : TInterstitialAdvertisment;
     {$ENDIF}
  end;
   procedure tUrlOpen(URL: string);
    procedure adinters();
    function load:integer;
function save:integer;
var
  Form1: TForm1;
  path_app:string;
  title:string='Amazons Game Board';
  i:integer=0;
implementation

{$R *.fmx}

uses Unit2, Unit3,IniFiles,System.IOUtils, Unit4;
//----------------------------------------
function load:integer;
var MyINI:TMemIniFile;
    begin
    MyINI:=TMemIniFile.Create(path_app+'settings.ini');
    form4.RadioButton1.IsChecked:=MyINI.ReadBool('RadioButton1','IsChecked',form4.RadioButton1.IsChecked);
    form4.RadioButton2.IsChecked:=MyINI.ReadBool('RadioButton2','IsChecked',form4.RadioButton2.IsChecked);
    form4.RadioButton3.IsChecked:=MyINI.ReadBool('RadioButton3','IsChecked',form4.RadioButton3.IsChecked);
    form4.Switch1.IsChecked:=MyINI.ReadBool('Switch1','IsChecked',form4.Switch1.IsChecked);
    if MyINI.ReadBool('Switch1','IsChecked',form4.Switch1.IsChecked) then sound:=true else sound:=false;

    //form2.edit1.text:=MyINI.ReadString('edit1','text',form2.edit1.Text);
    //form2.ComboEdithomepeg.text:=MyINI.ReadString('ComboEdithomepeg','text',form2.ComboEdithomepeg.Text);
    //form1.CheckBoxrate.IsChecked:=MyINI.ReadBool('CheckBoxrate','IsChecked',form1.CheckBoxrate.IsChecked);
      //CheckBoxrate
       MyINI.Free;
    end;
function save:integer;
    var MyINI:TMemIniFile;
    begin
    MyINI:=TMemIniFile.Create(path_app+'settings.ini');

       MyINI.WriteBool('RadioButton1','IsChecked',form4.RadioButton1.IsChecked);
       MyINI.UpdateFile;
       MyINI.WriteBool('RadioButton2','IsChecked',form4.RadioButton2.IsChecked);
       MyINI.UpdateFile;
       MyINI.WriteBool('RadioButton3','IsChecked',form4.RadioButton3.IsChecked);
       MyINI.UpdateFile;
       MyINI.WriteBool('Switch1','IsChecked',form4.Switch1.IsChecked);
       MyINI.UpdateFile;
       MyINI.Free;
    end;

//--------------adevent-------------------
procedure onAdClosedEvent(pszData:String);
begin
end;
procedure onAdFailedToLoadEvent(pszData:String);
begin
end;
procedure onAdLeftApplicationEvent(pszData:String);
begin
end;
procedure onAdOpenedEvent(pszData:String);
begin
end;
procedure onAdLoadedEvent(pszData:String);
begin
end;
 //---------------------------------
 procedure adinters();
begin
{$IF Defined(ANDROID)}
  form1.IAdvertisment := TInterstitialAdvertisment.Create;
  form1.IAdvertisment.SetOnCloseEvent(onAdClosedEvent);
  form1.IAdvertisment.SetOnAdFailedToLoad(onAdFailedToLoadEvent);
  form1.IAdvertisment.SetOnAdLeftApplication(onAdLeftApplicationEvent);
  form1.IAdvertisment.SetOnAdOpened(onAdOpenedEvent);
  form1.IAdvertisment.SetOnAdLoaded(onAdLoadedEvent);
  form1.IAdvertisment.TestMode := false;
  form1.IAdvertisment.SetAdUnitID('ca-app-pub-7742940681093129/6934859653');
  form1.IAdvertisment.InitAdvertisment;
{$ENDIF}
end;
//---------------------------------
procedure tUrlOpen(URL: string);
{$IF Defined(ANDROID)}
var
  Intent: JIntent;
{$ENDIF}
begin
{$IF Defined(ANDROID)}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI(URL));
  tandroidhelper.Activity.startActivity(Intent);
  // SharedActivity.startActivity(Intent);
{$ELSEIF Defined(MSWINDOWS)}
  ShellExecute(0, 'OPEN', PWideChar(URL), nil, nil, SW_SHOWNORMAL);
{$ELSEIF Defined(IOS)}
  SharedApplication.OpenURL(StrToNSUrl(URL));
{$ELSEIF Defined(MACOS)}
  _system(PAnsiChar('open ' + AnsiString(URL)));
{$ENDIF}
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
timer1.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

path_app:=TPath.GetHomePath()+TPath.DirectorySeparatorChar;
bannerad1.AdUnitID:=('ca-app-pub-7742940681093129/4343777417');
bannerad1.LoadAd;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
 timer1.Enabled:=false;
end;

procedure TForm1.FormFocusChanged(Sender: TObject);
begin
 timer1.Enabled:=false;
end;

procedure TForm1.Rectangle1Click(Sender: TObject);
begin
chattimer:=0;
  form2.show;
  form2.Timer4.Enabled:=false;
  unit2.v:=1;
  unit2.bot:=0;
  unit2.online:=0;
   unit2.fix2send:=0;
  unit2.user:='a';
   unit2.bignplay(1);
   form2.Rectangle3.Visible:=false;
   form2.MultiView1.Visible:=false;
end;

procedure TForm1.Rectangle9Click(Sender: TObject);
begin
chattimer:=0;
  form2.Timer4.Enabled:=false;
   form2.show;
   unit2.user:='a';
   unit2.v:=1;
    unit2.bot:=1;
     unit2.online:=0;
   unit2.fix2send:=0;
   unit2.bignplay(3);
      form2.Rectangle3.Visible:=false;
   form2.MultiView1.Visible:=false;


end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
i:=i+1;
if i=length(title) then begin i:=0; label10.Text:= ''; end else
label10.Text:= label10.Text+title[i];

end;

procedure TForm1.Rectangle7Click(Sender: TObject);
begin
tUrlOpen('https://play.google.com/store/search?q=pub:okba_ch&c=apps&hl=en');
end;

procedure TForm1.Rectangle13Click(Sender: TObject);
begin
form4.show;
end;

procedure TForm1.Rectangle8Click(Sender: TObject);
begin
tUrlOpen('https://play.google.com/store/apps/details?id=com.strdz.Amazons_Siege_ads&hl=ar&gl=US');
end;

procedure TForm1.FormHide(Sender: TObject);
begin
timer1.Enabled:=false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
load;
end;

procedure TForm1.Rectangle10Click(Sender: TObject);
begin
Rectangle11.Visible:=true;
end;


procedure TForm1.Rectangle12Click(Sender: TObject);
begin
Rectangle11.Visible:=false;
end;

procedure TForm1.Rectangle2Click(Sender: TObject);
begin

  form2.Timer4.Enabled:=false;
     form2.show;
     unit2.user:='a';
     unit2.v:=1;
     unit2.bot:=0;
       unit2.online:=0;
   unit2.fix2send:=0;
   unit2.bignplay(2);
      form2.Rectangle3.Visible:=false;
   form2.MultiView1.Visible:=false;
end;

procedure TForm1.Rectangle3Click(Sender: TObject);
begin
chattimer:=0;
  form2.Timer4.Enabled:=false;
   form2.show;
   unit2.user:='a';
   unit2.v:=1;
   unit2.bot:=0;
     unit2.online:=0;
   unit2.fix2send:=0;
   unit2.bignplay(3);
      form2.Rectangle3.Visible:=false;
   form2.MultiView1.Visible:=false;
end;

procedure TForm1.Rectangle4Click(Sender: TObject);
begin
form3.show;
end;

end.
