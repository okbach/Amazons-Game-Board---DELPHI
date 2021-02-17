unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Objects,
   IdHTTP, FMX.Edit, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  FMX.Advertising,
  {$IF Defined(IOS)}
  macapi.helpers, iOSapi.Foundation, FMX.helpers.iOS;
  {$ELSEIF Defined(ANDROID)}
  Network,
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
  TForm3 = class(TForm)
    Edit1: TEdit;
    IdHTTP1: TIdHTTP;
    Edit2: TEdit;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Rectangle3: TRectangle;
    Label2: TLabel;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Edit3: TEdit;
    BannerAd1: TBannerAd;
    Label3: TLabel;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;

    procedure Rectangle2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  org_user:string;
implementation

{$R *.fmx}

uses Unit1,Unit2;







 function get(url:string):string;
 var
  LHttp: TIdHttp;
begin
  LHttp := TIdHTTP.Create;
  try
    //LHttp.HandleRedirects := true;
    result := LHttp.Get(Url);
  finally
    LHttp.Free;
  end;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin

   TThread.CreateAnonymousThread(
    procedure
    var
      LResult: string;
     // LUrl: string;
    begin

        LResult := get('http://wifidjelfa.aba.vg/game.php?state=join&session_name='+edit2.Text);
        TThread.Synchronize(nil,
          procedure
          begin
           // LResult;
           if LResult='a' then
           begin
           unit2.fix2send:=1;
           unit2.v:=1;
           form2.timer1.Enabled:=false;
           form2.timer2.Enabled:=false;
           unit2.user:='a';
           org_user:='a';
           unit2.session_name:= edit2.Text;
           unit2.bignplay(1); form2.show;

           end;
          end
        );

    end
  ).Start;



end;
procedure TForm3.Button5Click(Sender: TObject);
begin
   TThread.CreateAnonymousThread(
    procedure
    var
      LResult: string;
     // LUrl: string;
    begin

        LResult := get('http://wifidjelfa.aba.vg/game.php?state=creat&session_name='+edit1.Text);
        TThread.Synchronize(nil,
          procedure
          begin
           // LResult;
           if LResult='b' then
           begin
           unit2.fix2send:=0;
           unit2.v:=1;
           unit2.user:='b';
           unit2.session_name:= edit1.Text;
           unit2.bignplay(1); form2.show;
           form2.Timer1.Enabled:=true;
           end;
          end
        );

    end
  ).Start;

  end;

procedure TForm3.FormActivate(Sender: TObject);
begin
adinters;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
bannerad1.AdUnitID:=('ca-app-pub-7742940681093129/4343777417');
bannerad1.LoadAd;
end;

procedure TForm3.Rectangle2Click(Sender: TObject);
begin
//{$IF Defined(ANDROID)}
//if  not IsConnected then
//showmessge('You are not connected to the Internet') else
//{$ENDIF}
   TThread.CreateAnonymousThread(
    procedure
    var
      LResult: string;
     // LUrl: string;
    begin

        LResult := get('http://wifidjelfa.aba.vg/game.php?state=creat&session_name='+edit1.Text+'&user_name='+edit3.Text);
        TThread.Synchronize(nil,
          procedure
          begin
           // LResult;
           if LResult='b' then
           begin
           form2.Timer1.Enabled:=true;
           chattimer:=1;
           unit2.fix2send:=0;
           unit2.v:=1;
           unit2.bot:=0;
           unit2.user:='b';
           org_user:='b';
           unit2.online:=1;
           unit2.session_name:= edit1.Text;
           unit2.bignplay(1); form2.show;
           form2.Timer4.Enabled:=true;
           form2.webbrowser1.Navigate('http://wifidj.aba.vg/box_chat.html');
           form2.Timer5.Enabled:=true;
           form2.Rectangle3.Visible:=true;
           form2.MultiView1.Visible:=true ;
           end;
          end
        );

    end
  ).Start;

  end;

procedure TForm3.Rectangle3Click(Sender: TObject);
begin

   TThread.CreateAnonymousThread(
    procedure
    var
      LResult: string;
     // LUrl: string;
    begin

        LResult := get('http://wifidjelfa.aba.vg/game.php?state=join&session_name='+edit2.Text+'&user_name='+edit3.Text);
        TThread.Synchronize(nil,
          procedure
          begin
           // LResult;
           if LResult='a' then
           begin
           chattimer:=1;
           form2.timer1.Enabled:=false;
           form2.timer2.Enabled:=false;
           unit2.fix2send:=1;
           unit2.v:=1;
           unit2.online:=1;
           unit2.user:='a';
           org_user:='a';
           unit2.bot:=0;
           unit2.session_name:= edit2.Text;
           unit2.bignplay(1);
           form2.show;
           form2.webbrowser1.Navigate('http://wifidj.aba.vg/box_chat.html');
           form2.Timer5.Enabled:=true;
           form2.Rectangle3.Visible:=true;
           form2.MultiView1.Visible:=true ;
           end;
          end
        );

    end
  ).Start;



end;

procedure TForm3.Rectangle8Click(Sender: TObject);
begin
form1.Show;
end;

function therd(url:string):string;
begin
   TThread.CreateAnonymousThread(
    procedure
    var
      LResult: string;
     // LUrl: string;
    begin

        LResult := get(url);
        TThread.Synchronize(nil,
          procedure
          begin
           //exit(LResult);

          end
        );

    end
  ).Start;

 // Result:= LResult;
end;
end.
