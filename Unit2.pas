unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs
  ,engineboard, FMX.Layouts, System.ImageList, FMX.ImgList, FMX.Objects,
  FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.MultiView,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Edit, IdHTTP, FMX.WebBrowser,
  FMX.Advertising; //IdBaseComponent

type
  TForm2 = class(TForm)
    ImageList1: TImageList;
    GridLayout1: TGridLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Timer1: TTimer;
    Timer2: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Timer3: TTimer;
    MultiView1: TMultiView;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    StyleBook1: TStyleBook;
    Rectangle7: TRectangle;
    Label3: TLabel;
    Glyph1: TGlyph;
    Glyph2: TGlyph;
    nameb: TLabel;
    namea: TLabel;
    winlosa: TLabel;
    winlosb: TLabel;
    scorea: TLabel;
    scoreb: TLabel;
    Rectangle8: TRectangle;
    WebBrowser1: TWebBrowser;
    timer4: TTimer;
    Timer5: TTimer;
    Button1: TButton;
    Memo1: TMemo;
    BannerAd1: TBannerAd;
    Button2: TButton;
    Memo2: TMemo;
    Button5: TButton;
    Timer6: TTimer;
    procedure clickmove(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
    procedure showscore();
    procedure Timer5Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure earlyendgameab();
    procedure WebBrowser1DidFinishLoad(ASender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;


  function bignplay(bor: integer):integer;

  var
  Form2: TForm2;
  v:integer=1;
  user,session_name,info,info_old:string; //a or b
  wsprit_f:string;//f=full name
  fix2send:integer;
  online:integer;
  bot:integer;
  chattimer:integer;
  twouser:string;
 Listt: tstringlist;
implementation

{$R *.fmx}

uses Unit3, Unit1,unit4;




procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;


procedure TForm2.Button1Click(Sender: TObject);
var r:Tarrayb;
  I: Integer;

begin
   { r:=getpos_sprite(gridlayout1,1);
            for I := 0 to High(r) do
         memo1.Lines.Add(inttostr(I)+' : '  + inttostr(r[I]) );   }

      r:= earlyendgame(gridlayout1,'b');
      for I := 0 to High(r) do
      memo1.Lines.Add(INTTOSTR(r[I]));
end;

procedure TForm2.earlyendgameab();
var
    aarray,barray:Tarrayb;
    alength,blength:integer;
    List: TStringList;
    resendgame:INTEGER;
    res99:Tarrayb;
begin
res99:=[99];
      aarray:= earlyendgame(gridlayout1,'a');
      alength:=length(aarray);

      if aarray<>nil then begin



        barray:= earlyendgame(gridlayout1,'b');
        blength :=length(barray);
      //-------------
      if (alength>0) and (aarray[0]=0) then alength:=0;
      if (blength>0)and (barray[0]=0) then blength:=0;
      //-------------

begin


        if  unit2.online>0 then begin

        List := TStringList.Create;
          try
            ExtractStrings(['#'], [], PChar(twouser), List);
            nameb.Text:=List[0];   //a
            namea.Text:=List[1]; //b
            finally
            List.Free;
          end;
        end else begin
            namea.Text:='a';   //a
            nameb.Text:='b'; //b
        end;


        if alength>blength then begin
          winlosb.Text:='Loser';
          winlosa.Text:='winner';
        end else begin
          winlosb.Text:='winner';
          winlosa.Text:='Loser';
        end;
        scorea.text:=inttostr(alength);
        scoreb.text:= inttostr(blength);

      rectangle7.Visible:=true;
      exit;
      end;
      //-------------
      end;

end;

procedure TForm2.Button2Click(Sender: TObject);
var board: Tarrayb;
stepsq:Tarrayb;
I:integer;
begin



 //board:= creatboard_s(3,3);
 //board:= creat_sprite_s(board);
 //setlength(board,9);
 //board:=[1,0,0,0,-1,-1,0,-1,2];
 //board:=[1,-1,0,0,-1,0,1,0,1,0,-1,-1,0,0,-1,2];
 board:=[ 1,-1,0,0,
          0,0,-1,-1,
          0,-1,0,0,
          0,-1,0,2];
           board:=[ 1,-1,0,0,
                    0,0,0,-1,
                    0,0,-1,0,
                    0,2,-1,0];
                 //   board:=move_fire(13,15,board,1);
                    {  board:=[ 1,-1,0,0,0,
           0,0,-1,-1,0,
           0,-1,0,0,0,
           0,-1,0,0,0,
           0,-1,0,2,0];  }
 { board:=[ 2,0,0,0,
          0,0,0,0,
          0,0,0,0,
          0,0,0,1];}
 //board:=[1,1,0,0,1,0,0,1,2];
 //stepsq:= queensteps_s(0,board);
 //showmessage( inttostr(earlyendgame_s(board)) );
  //board:= earlyendgame_s(board,1);
  //board:=get_pos_sprit_s(board,1);

  //board:= score(board);

// for I := 0 to High(board) do
  //  memo2.Lines.Add(inttostr(i)+' : '+INTTOSTR(board[I]));

 //stepsq:=getoutlines(3,3,1);

 //for I := 0 to High(stepsq) do
 //memo2.Lines.Add(INTTOSTR(stepsq[I]));
    moveai(board);

end;

procedure TForm2.Button5Click(Sender: TObject);
var board:tarrayb;
begin
board:=convertsim(GridLayout1);
if score(board)[0]=1 then showmessage(inttostr(score(board)[1]));
end;

procedure TForm2.clickmove(Sender: TObject);
var

SenderButton : TRectangle;
xy,copyxy:tarrayb;
a,b:integer;
z:integer;
sprit:string;
sprit_f:string;
List: TStringList;
begin


a:=gridlayout1.TagString.ToInteger;
b:=gridlayout1.TagString.ToInteger;
SenderButton := (Sender as TRectangle );
 if SenderButton <> nil then begin


        if (SenderButton.ChildrenCount>0)   then begin
            sprit_f:= SenderButton.Children.Items[0].Name;
            sprit  := SenderButton.Children.Items[0].TagString ;
        end else begin
            sprit_f:='';
            sprit:='';
        end;

        z:=SenderButton.Tag;


  if (v=1) and (user='a') then begin
     if   sprit='a' then begin
          color_bord(a,b,'bad',color1,color2,form2);
          xy:=queensteps(z,a,b,form2);     //color
          Effect_array(xy,$FFF9E746,form2);
          wsprit_f:=sprit_f;
          exit;
     end;

     if SenderButton.TagString='1' then   begin
        move_ship(wsprit_f,z,form2.gridlayout1,form2);
        color_bord(a,b,'bad',color1,color2,form2);
        v:=2;
     if fix2send=1 then begin
        TThread.CreateAnonymousThread(
        procedure
        begin
          TThread.Synchronize(nil,
          procedure
          begin
            get('http://wifidjelfa.aba.vg/game.php?state=play&user=a1&session_name='+session_name+'&move='+wsprit_f+'-'+inttostr(z));
          end
        );

        end
        ).Start;
     end;

     end;

  end;

  if (v=2) and (user='a') and (SenderButton.TagString='1') then begin

    fire(wsprit_f,z,gridlayout1,'ImageList1',form2);
    color_bord(a,b,'bad',color1,color2,form2);
    v:=3;
    if fix2send=1 then begin
      TThread.CreateAnonymousThread(
      procedure
      begin

        TThread.Synchronize(nil,
        procedure
        begin
          get('http://wifidjelfa.aba.vg/game.php?state=play&user=a2&session_name='+session_name+'&move='+wsprit_f+'-'+inttostr(z));
        end
        );

      end
      ).Start;

      timer1.Enabled:=true;
    end;

    if online=0 then user:='b';

    if bot=1 then Timer6.Enabled:=true;
  //timer6.Enabled:=true;
  end;

//------------------------------------------------------------
  if (v=3) and (user='b') then begin
     if sprit='b' then begin
        color_bord(a,b,'bad',color1,color2,form2);
        xy:=queensteps(z,a,b,form2);     //color
        Effect_array(xy,$FFF9E746,form2);
        wsprit_f:=sprit_f;
        exit;
     end;

     if SenderButton.TagString='1' then   begin
        move_ship(wsprit_f,z,form2.gridlayout1,form2);
        color_bord(a,b,'bad',color1,color2,form2);
        v:=4;
     if fix2send=1 then begin
        TThread.CreateAnonymousThread(
        procedure
        begin
          TThread.Synchronize(nil,
          procedure
          begin
            get('http://wifidjelfa.aba.vg/game.php?state=play&user=b1&session_name='+session_name+'&move='+wsprit_f+'-'+inttostr(z));
          end
        );

        end
        ).Start;
     end;
     end;
  end;

  if (v=4) and (user='b') and (SenderButton.TagString='1') then  begin

        fire(wsprit_f,z,gridlayout1,'ImageList1',form2);
        color_bord(a,b,'bad',color1,color2,form2);
        v:=1;
    if fix2send=1 then begin
        TThread.CreateAnonymousThread(
        procedure
        begin
          TThread.Synchronize(nil,
          procedure
          begin
            get('http://wifidjelfa.aba.vg/game.php?state=play&user=b2&session_name='+session_name+'&move='+wsprit_f+'-'+inttostr(z));
          end
        );
        end
        ).Start;
        timer1.Enabled:=true;
    end;
    if online=0 then user:='a';
  end;

 end;

end;
procedure Tform2.showscore();
 var List: TStringList;
 resendgame:INTEGER;
begin
    resendgame:= ifendgame(gridlayout1,form2);
    if resendgame >0 then begin
     if  unit2.online>0 then BEGIN

    List := TStringList.Create;
      try
        ExtractStrings(['#'], [], PChar(twouser), List);
            nameb.Text:=List[0];   //a
            namea.Text:=List[1]; //b
        finally
        List.Free;
      end;
      END ELSE BEGIN

            namea.Text:='';   //a
            nameb.Text:=''; //b
      END;


        if resendgame=1 then begin
          winlosb.Text:='Loser';
          winlosa.Text:='winner';
        end else begin
          winlosa.Text:='Loser';
          winlosb.Text:='winner';
        end;
        scorea.text:='';
        scoreb.text:= '';
    rectangle7.Visible:=true;
    exit;
    end;
end;

function addClick(name_grid: Tcontrol):integer;
 var I:integer;
 begin
 for I := 1 to name_grid.ChildrenCount do  begin
 TRectangle(form2.FindComponent('bad'+'Rectangle'+inttostr(I))).OnClick:=form2.clickmove;
 end;
 end;

function bignplay(bor: integer):integer;

 begin

   if bor=0 then begin
  form2.Rectangle2.Padding.Top:=0;
  form2.Rectangle2.Padding.Left:=0;
  form2.Rectangle2.Padding.Right:=0;
  form2.Rectangle2.Padding.Bottom:=0;
  engineboard.destroyall(form2.GridLayout1);
  creat_bord(5,5,'bad',form2.GridLayout1,form2,'Rectanglex','imagelist1',3);
  color_bord(5,5,'bad',color1,color2,form2);
  creat_sprite(form2,form2.gridlayout1,'imagelist1');
  addClick(form2.GridLayout1);

  end;
  if bor=1 then begin
  form2.Rectangle2.Padding.Top:=20;
  form2.Rectangle2.Padding.Left:=20;
  form2.Rectangle2.Padding.Right:=20;
  form2.Rectangle2.Padding.Bottom:=20;
  engineboard.destroyall(form2.GridLayout1);
  creat_bord(6,6,'bad',form2.GridLayout1,form2,'Rectanglex','imagelist1',3);
  color_bord(6,6,'bad',color1,color2,form2);
  creat_sprite(form2,form2.gridlayout1,'imagelist1');
  addClick(form2.GridLayout1);

  end;
  if bor=2 then begin
  form2.Rectangle2.Padding.Top:=5;
  form2.Rectangle2.Padding.Left:=5;
  form2.Rectangle2.Padding.Right:=5;
  form2.Rectangle2.Padding.Bottom:=5;

  engineboard.destroyall(form2.GridLayout1);
  creat_bord(8,8,'bad',form2.GridLayout1,form2,'Rectanglex','imagelist1',3);
  color_bord(8,8,'bad',color1,color2,form2);
  creat_sprite(form2,form2.gridlayout1,'imagelist1');
  addClick(form2.GridLayout1);
  end;
  if bor=3 then begin
  form2.Rectangle2.Padding.Top:=0;
  form2.Rectangle2.Padding.Left:=0;
  form2.Rectangle2.Padding.Right:=0;
  form2.Rectangle2.Padding.Bottom:=0;
  engineboard.destroyall(form2.GridLayout1);
  creat_bord(10,10,'bad',form2.GridLayout1,form2,'Rectanglex','imagelist1',3);
  color_bord(10,10,'bad',color1,color2,form2);  //$FF6f4f47,$FFbca583
  creat_sprite(form2,form2.gridlayout1,'imagelist1');
  addClick(form2.GridLayout1);
  end;
 end;
procedure TForm2.FormActivate(Sender: TObject);
begin
adinters;
Rectangle2.Width:=form2.Width-5;
Rectangle2.Height:=form2.Width-5;
Rectangle7.Visible:=FALSE;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
{$IFDEF ANDROID}
StyleBook1.FileName:=path_app+'edit memo';
{$ENDIF}
bannerad1.AdUnitID:=('ca-app-pub-7742940681093129/4343777417');
bannerad1.LoadAd;

RegisterSound(path_app+'piece_pickup2.wav',form2);
RegisterSound(path_app+'piece_place2.wav',form2);

Rectangle2.Width:=form2.Width-5;
Rectangle2.Height:=form2.Width-5;
end;

procedure TForm2.Rectangle6Click(Sender: TObject);
var
msg:string;
//----------
  server: TIdHttp;
  Parameters: TStringList;
  Response: TStringStream;
//-----------
begin
{ if (edit1.text<>'') then begin
msg:=edit1.Text;
memo1.Lines.Add(form3.Edit3.Text+' : '+edit1.Text);




  response := TStringStream.Create;
  Parameters := TStringList.Create;
   Server := Tidhttp.Create;
  Parameters.Add('user_name='+form3.Edit3.Text);
  Parameters.Add('msg='+msg);
  Parameters.Add('session_name='+session_name);
  Server.Post('http://wifidjelfa.aba.vg/game.php?state=chat',Parameters,response);
//--------------------------------------

edit1.Text:='';
end;            }
end;

procedure TForm2.Rectangle8Click(Sender: TObject);
begin
rectangle7.Visible:=false;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
x,y,name_p:string;
List: TStringList;
begin
    fix2send:=0;
    TThread.CreateAnonymousThread(
    procedure
    var
      LResult: string;
    begin
      TThread.Synchronize(nil,
      procedure
      begin
        info:=Get('http://wifidjelfa.aba.vg/game.php?state=info1&user='+user+'&session_name='+session_name);






    if (info=info_old) and (info<>'notyet') then

    else if not (info='notyet') then begin
      timer1.Enabled:=false;
      info_old:=info;
      List := TStringList.Create;
      try
        ExtractStrings(['-'], [], PChar(info), List);
        x:=List[0];
        y:=List[1];
        finally
        List.Free;
      end;

      if user ='a' then user:='b' else user:='a';
      name_p:=TGlyph(form2.FindComponent(x)).ParentControl.Name;
      form2.clickmove(TRectangle(form2.FindComponent(name_p)));
      form2.clickmove(TRectangle(form2.FindComponent('badRectangle'+y)));
      if user ='a' then user:='b' else user:='a';
      timer2.Enabled:=true;
      timer1.Enabled:=false;

    end;

            end );
    end
    ).Start;

end;

procedure TForm2.Timer2Timer(Sender: TObject);
var
x,y,name_p:string;
List: TStringList;
 begin
    TThread.CreateAnonymousThread(
    procedure
    begin

        TThread.Synchronize(nil,
        procedure
        begin
            info:=get('http://wifidjelfa.aba.vg/game.php?state=info2&user='+user+'&session_name='+session_name);
        end);

    end
    ).Start;

    if (info=info_old) and (info<>'notyet') then

    else if not (info='notyet') then begin
        timer2.Enabled:=false;
        info_old:=info;
        List := TStringList.Create;
        try
          ExtractStrings(['-'], [], PChar(info), List);
          x:=List[0];
          y:=List[1];
          finally
          List.Free;
        end;
        if user ='a' then user:='b' else user:='a';
        name_p:=TGlyph(form2.FindComponent(x)).ParentControl.Name;
        form2.clickmove(TRectangle(form2.FindComponent(name_p)));
        form2.clickmove(TRectangle(form2.FindComponent('badRectangle'+y)));
        if user ='a' then user:='b' else user:='a';
    fix2send:=1;
    timer2.Enabled:=false;
    end;

 end;
procedure TForm2.Timer3Timer(Sender: TObject);
begin
 if timer1.Enabled then label1.Text:='run' else  label1.Text:='stop';
 if timer2.Enabled then label2.Text:='run' else  label2.Text:='stop';
end;

procedure TForm2.Timer4Timer(Sender: TObject);
begin

    webbrowser1.EvaluateJavaScript('sesion_name("'+unit2.session_name+'");' );
    if  org_user='b' then
        webbrowser1.EvaluateJavaScript(' rname("b","a"); ')
    else
        webbrowser1.EvaluateJavaScript(' rname("a","b"); ');



  timer4.Enabled:=false;
end;










procedure TForm2.Timer5Timer(Sender: TObject);
begin
    TThread.CreateAnonymousThread(
    procedure
    begin

        TThread.Synchronize(nil,
        procedure
        begin



try
twouser:=get('http://wifidjelfa.aba.vg/'+session_name+'_chat.txt');
form2.Timer5.Enabled:=false;
finally
if twouser>'' then form2.Timer5.Enabled:=true else
  form2.Timer5.Enabled:=false;
end;

           end);

    end
    ).Start;
end;

procedure TForm2.Timer6Timer(Sender: TObject);
begin
 turnai(GridLayout1);
 Timer6.Enabled:=false;
end;

procedure TForm2.WebBrowser1DidFinishLoad(ASender: TObject);
begin
timer4.Enabled:=true;
end;

end.
