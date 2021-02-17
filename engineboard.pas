//---------------------------------------------------------------------------
{
  Author : CHEDDAD OKBA
           GOKBAHACK@GMAIL.COM
           https://github.com/okbach/
           Engine board game STR --> engineboard.pas
 
}
// This software is Copyright (c) 2021 OKBA CHEDDAD "STR", 

//---------------------------------------------------------------------------

unit engineboard;



interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms,  FMX.Layouts,
  FMX.Objects, FMX.ImgList, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects,IdHTTP,System.IOUtils,AudioManager,math;

 {type
  TActions = class
  public
    class procedure clickmove(Sender: TObject);
  end;}


type
  Tarrayb = array of integer;
type
  timerx = class(Ttimer)
  private
  x: string;
  form:TFORM;
  name_grid:Tcontrol;
  item:integer;
  sprite:string;
  lghit:integer;
  //procedure SetValue (m, d, y: Integer);
  public
  class procedure goTimer(Sender: TObject);
  //
  end;

 type
  timerbot = class(Ttimer)
  private
  name_grid:Tcontrol;
  bestmove:integer;
  public
  class procedure goTimerbot(Sender: TObject);
  class procedure gominmax(Sender: TObject);
  end;

 { type
  timerminmax = class(Ttimer)
  private
  x: string;
  form:TFORM;
  name_grid:Tcontrol;
  bestmove:integer;
  public
  class procedure gominmax(Sender: TObject);
  end;}



function queensteps(id,x,y:integer;form:Tform):Tarrayb;
function color_bord(xx,yy:integer;name_t:string;colora,colorb:integer;form:Tform):string;
function creat_bord (x,y: integer; name_t:string;name_grid: Tcontrol;form:Tform;_fill,imagelist:string;mode:integer=0):string;
function gradient_bord(xx,yy:integer;name_t:string;colora,colorb:string;form:Tform):string;
function destroyall(name_grid: Tcontrol):string;
function getoutlines(x,y,p:integer):Tarrayb  ;
function move_ship(sprite:string;item:integer;name_grid:Tcontrol;form:Tform;lghit:integer=1):integer;
function creat_sprite(form:tform;name_grid: Tcontrol;imagelist:string):integer;
function color_array(xy:Tarrayb;color:integer;form:tform):integer;
function fire(sprite:string;item:integer;name_grid:Tcontrol;imagelist:string;form:Tform):integer;
function getpos_sprite(name_grid:Tcontrol;t:integer=0):Tarrayb;
function sortarray(ar:Tarrayb):Tarrayb;
function ifendgame(name_grid:Tcontrol;form:Tform):integer;
function Effect_array(xy:Tarrayb;color:integer;form:tform):integer;
function get(url:string):string;
function path_app():string;
function RegisterSound(Filename: String;form:Tform): Integer;
function difference(a,b:real):real;
function ex_array(const ANumber: integer;const AArray:Tarrayb): boolean;
function earlyendgame(name_grid:Tcontrol;tag_sprit:string):Tarrayb;
//-----------s--simlter------------------
function creatboard_s(x,y:integer):Tarrayb;
function creat_sprite_s(xy:Tarrayb):Tarrayb;
function queensteps_s(id:integer;board:Tarrayb):Tarrayb;
function earlyendgame_s(board:Tarrayb;ab:integer):Tarrayb;
function get_pos_sprit_s(board:Tarrayb;sprit:integer):Tarrayb ;
function score(board:Tarrayb):Tarrayb;
function moveai(board:tarrayb):tarrayb; //bestmove
function convertsim(name_grid:Tcontrol):Tarrayb;
function turnai(name_grid:Tcontrol):Tarrayb;
function move_fire(xy,toxy:integer;board:Tarrayb;mf:integer):Tarrayb;
var
t : timerx;
tbot:timerbot;
AudioManager: TAudioManager;

implementation

uses UNIT2,unit4;

function RegisterSound(Filename: String;form:Tform): Integer;
var
 AComponent : TComponent;
begin
    AComponent := TComponent(AudioManager);

  if  not  assigned(AComponent)  then   begin
  AudioManager := TAudioManager.Create;
  end;


  if FileExists(Filename) then
    Result := AudioManager.AddSound(Filename)
  else
    Result := -1;
end;

function path_app():string;
 begin
 result:=TPath.GetHomePath()+TPath.DirectorySeparatorChar;
 end;

class procedure timerx.goTimer(Sender: TObject);
var
  form :Tform;
  name_grid:Tcontrol;
  I:integer;
  item:integer;
  sprite:string;
  pointer1,pointer2:integer;
  //--------------
  xy:tarrayb;
  a,b:integer;
  //--------------
begin


  form:=(Sender as Timerx ).form ;
  name_grid:=(Sender as Timerx ).name_grid;
  item:= (Sender as Timerx ).item;
  sprite:=(Sender as Timerx ).sprite;



  for I := 0 to 10 do  begin

  if difference(TGlyph(form.FindComponent(sprite)).Position.x,name_grid.Controls.Items[item].Position.x)>2 then

  if TGlyph(form.FindComponent(sprite)).Position.x >
  name_grid.Controls.Items[item].Position.x  then
  TGlyph(form.FindComponent(sprite)).Position.x:=
  TGlyph(form.FindComponent(sprite)).Position.x-1
  else
  TGlyph(form.FindComponent(sprite)).Position.x:=
  TGlyph(form.FindComponent(sprite)).Position.x+1;

  if difference(TGlyph(form.FindComponent(sprite)).Position.Y,name_grid.Controls.Items[item].Position.y)>2 then
  if TGlyph(form.FindComponent(sprite)).Position.Y  >
  name_grid.Controls.Items[item].Position.y  then
  TGlyph(form.FindComponent(sprite)).Position.Y:=
  TGlyph(form.FindComponent(sprite)).Position.Y-1
  else
  TGlyph(form.FindComponent(sprite)).Position.Y:=
  TGlyph(form.FindComponent(sprite)).Position.Y+1 ;

  end;


  if ( difference(TGlyph(form.FindComponent(sprite)).Position.x,name_grid.Controls.Items[item].Position.x) < 2 )
  and
   (  difference(TGlyph(form.FindComponent(sprite)).Position.Y,name_grid.Controls.Items[item].Position.y)  < 2 )

  then  begin
   if unit4.sound then AudioManager.PlaySound(1);
    (Sender as Timerx).Enabled := false;
   // TGlyph(form.FindComponent(sprite)).Align:= TAlignLayout.Client;
    TGlyph(form.FindComponent(sprite)).Parent:=name_grid.Controls.Items[item];
   // form2.showscore();   //IF END GAME

   if t.lghit=1 then begin

   a:=name_grid.TagString.ToInteger;
   b:=name_grid.TagString.ToInteger;

      TThread.CreateAnonymousThread(
    procedure
    begin

        TThread.Synchronize(nil,
        procedure
        begin
        xy:=queensteps(item+1,a,b,form);
        //color_array(xy,$FFF9E746,form);
        Effect_array(xy,$FFF9E746,form);
        end);

    end
    ).Start;


   end else form2.earlyendgameab();
  EXIT;
  end;

end;

function move_ship(sprite:string;item:integer;name_grid:Tcontrol;form:Tform;lghit:integer=1):integer;
var
tag_c:integer;
    AComponent : TComponent;
begin

    AComponent := form.FindComponent('t');

  if  not  assigned(AComponent)  then   begin
  t := timerx.Create(form);
  t.Enabled:=false;
  end;
  if t.Enabled=true then exit;



  tag_c:= TGlyph(form.FindComponent(sprite)).Tag ;
  TGlyph(form.FindComponent(sprite)).Parent:=name_grid;

  TGlyph(form.FindComponent(sprite)).Position.X:=
  name_grid.Controls.Items[tag_c-1].Position.x;

    TGlyph(form.FindComponent(sprite)).Position.y:=
  name_grid.Controls.Items[tag_c-1].Position.y;

  TGlyph(form.FindComponent(sprite)).Tag:=item;


    { item:=item-1;
     AudioManager.PlaySound(0);
     movexy(item,sprite,form,name_grid,lghit); }
  t.Name:='t';
  t.item:=item-1;
  t.sprite:=sprite;
  t.Interval := 30;
  if unit4.sound then AudioManager.PlaySound(0);
  t.OnTimer := timerx.goTimer;
  t.form:=form;
  t.name_grid:=name_grid;
  t.Enabled := True;
  t.lghit:=lghit;
end;

function getoutlines(x,y,p:integer):Tarrayb  ;
var I:integer;
II:integer;
res:Tarrayb;
begin
II:=0;
result:=nil;

//---------TOP-----------------------
  if p=1 then  begin
    setlength(result,x);

    for I := 1 to x do begin
    result[I-1] := I;
    end;
  end;
//---------BOTTOM----------------------
  if p=3 then begin
    setlength(result,x);

    for I := ((x*y)-(x-1)) to (x*y) do begin
    result[II] := I;
    II:=II+1;
    end;

  end;
//------------RGHIT---------------------

  if p=2 then begin
    setlength(result,Y);
    II:=x;
    for I := 1 to Y do begin
    result[I-1] := II;
    II:=II+x;
    end;
  end;
//------------left---------------------

  if p=4 then begin
    setlength(result,Y);
    II:=1;
    for I := 1 to Y do begin
    result[I-1] := II;
    II:=II+x;
    end;
  end;

end;

function creat_bord (x,y: integer; name_t:string;name_grid: Tcontrol;form:Tform;_fill,imagelist:string;mode:integer=0):string;
var
  a, b, cont, i: integer;
  xx, zz: extended;
  name_c: Tcontrol;
begin
  xx := name_grid.Width - 0.1;
  zz := name_grid.Height - 0.1;
  // zz:=xx;
  TGridLayout(name_grid).ItemWidth := ((xx) / x);
  TGridLayout(name_grid).ItemHeight := ((zz) / y);
  name_grid.TagString:=x.ToString;
  cont := 0;
  for a := 0 to x - 1 do
    for b := 0 to y - 1 do
    begin
      cont := cont + 1;
      with TRectangle.Create(form) do
      begin
        name := name_t+'Rectangle'+inttostr(cont);
        tag:= cont;
        name_c := TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(cont)));
       // Width := ((form.ClientWidth) / 6);

        stroke.Thickness := 0;
        // stroke.Kind:=form5.Brush1.Brush.Kind.bkNone;
        Tag := cont;
        parent := name_grid;
       { margins.Bottom := 0.8;
        margins.Left := 0.8;
        margins.Right := 0.8;
        margins.Top := 0.8;
         XRadius:=3;
        YRadius:=3;
       }
        //Fill := TRectangle(form.FindComponent(_fill)).Fill;
        //form5.Rectangle_T.

        //OnClick:=TActions.clickmove;
        // SendToBack  ;
        // SendChildToBack(cont);
        // BringToFront;
        //ClipChildren:=true;
        // ClipParent:=true;
        // Fill.Kind:=form5.Brush1.Brush.Kind;
        // opacity:=0.7;
        Align := TAlignLayout.Client;
      end;
    if (mode=1) or (mode=0) then       //mode =1 just add img   0 both
      with TGlyph.Create(form) do begin
        name:=name_t+'glyph'+inttostr(cont);
        images:=Timagelist(form.FindComponent(imagelist));
        //imageindex:=0;
        parent:=name_c;
        align:=align.alClient;
        tag:=cont;
        //opacity:=0.9;
      end;


    if (mode=2) or (mode=0) then    //mode=2 just add text   0 both
      with TText.Create(form) do

      begin

        name := name_t+'text'+inttostr(cont);
        tag:= cont;
        TagString:='cha';
        //parent := form5;
        //OnClick := name_c.OnClick;
        //OnClick:=form5.clickmove;
        //images:=form5.imagelist1;
        //imageindex:=0;
       // OnClick:=
         SendToBack;
        font.Size:=22;
        font.Style:=font.Style+[TFontStyle.fsBold];
        //textsettings.FontColor:=$FFFFFAE5 ;
        //text := 'kjhjkhkj';
        textSettings.HorzAlign := TtextAlign(0); // taCenter
        parent := name_c;
        font.Size:=20;
        Align := Align.alClient;
        // DefaultTextSettings.Font.Size:=22;
        // Canvas.Font.Size:=22;
        // Canvas.SetSize(2,2);
        // opacity:=0.9;


      end;

    end;

end;

function color_bord(xx,yy:integer;name_t:string;colora,colorb:integer;form:Tform):string;
var
x,y:integer;
i:integer;
xname:string;
begin
i:=0;
 for y := 1 to yy do
   for x := 1 to xx do begin
     i:=i+1;
     if TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).TagString='1'
      then begin
        TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).TagString:='0';
         TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Children.Items[0].Destroy;
      end;



     if odd(y) then  begin

     if odd(x)  then
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill.Color:=TAlphaColor(colora)  //a $FF1C90EF
     else
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill.Color:=TAlphaColor(colorb); //b     $FF008000

     end else begin

     if odd(x)  then
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill.Color:=TAlphaColor(colorb)  //b
     else
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill.Color:=TAlphaColor(colora);  //a

     end;

   end;

end;

function gradient_bord(xx,yy:integer;name_t:string;colora,colorb:string;form:Tform):string;
var
x,y:integer;
i:integer;
begin
i:=0;
 for y := 1 to yy do
   for x := 1 to xx do begin
     i:=i+1;
     if odd(y) then  begin

     if odd(x)  then
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill:= TRectangle(form.FindComponent(colora)).Fill //a $FF1C90EF
     else
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill:= TRectangle(form.FindComponent(colorb)).Fill; //b     $FF008000

     end else begin

     if odd(x)  then
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill:= TRectangle(form.FindComponent(colorb)).Fill  //b
     else
     TRectangle(form.FindComponent(name_t+'Rectangle'+inttostr(i))).Fill:= TRectangle(form.FindComponent(colora)).Fill;  //a

     end;

   end;

end;

function destroyall(name_grid: Tcontrol):string;
 begin
   TGridLayout(name_grid).DeleteChildren;
    //GridLayout1.DeleteChildren;
 end;

function ex_array(const ANumber: integer;const AArray:Tarrayb): boolean;
var
  i: integer;
begin
  for i := 0 to high(AArray) do
    if ANumber = AArray[i] then
      Exit(true);
  result := false;
end;

function queensteps(id,x,y:integer;form:Tform):Tarrayb;
var
xy:Tarrayb;
copyid:integer;
begin
copyid:=id;
   xy:=nil;
while not( ex_array(id,getoutlines(x,y,4)) )
  do begin
    id:=id-1;
    if
    TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0
   then break;                                                       //to left
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;
  id:=copyid;
  while not( ex_array(id,getoutlines(x,y,2)) )
  do begin
    id:=id+1;
    if
    TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0
    then break;                                                       //to rghit
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;

  id:=copyid;
  while not( ex_array(id,getoutlines(x,y,1)) )
  do begin
    id:=id-x;
    if
    TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0
   then break;                                                       //to top
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;

  id:=copyid;
  while not( ex_array(id,getoutlines(x,y,3)) )
  do begin
    id:=id+x;
    if
    TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0
    then break;                                                       //to bootem
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,1))) and not(ex_array(id,getoutlines(x,y,4))) )
  do begin
    id:=id-(x+1);
    if
    TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0
    then break;                                                       //to 1*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,1))) and not(ex_array(id,getoutlines(x,y,2))) )
  do begin
    id:=id-(x-1);
    if
   TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0
    then break;                                                       //to 2*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,2))) and not(ex_array(id,getoutlines(x,y,3))) )
  do begin
    id:=id+(x+1);
    if
    TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0
    then break;                                                       //to 3*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,4))) and not(ex_array(id,getoutlines(x,y,3))) )
  do begin
    id:=id+(x-1);
    if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)

    then break;                                                       //to 4*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    //if one=1 then break;
  end;

if length(xy)>0 then result := xy ;
end;

function cls(name_grid: Tcontrol):boolean;
var
I:integer;
begin

for I := 0 to name_grid.ChildrenCount do
      TGlyph(name_grid.Children.Items[I]).ImageIndex:=-1
             //not yet need fix (rec)

end;

function startplay(sprite,player:integer;form:Tform):integer;

begin

end;

function creat_sprite(form:tform;name_grid: Tcontrol;imagelist:string):integer;
var
    name_t:string;
begin
name_t:='';
 if name_grid.ChildrenCount=25 then
  begin           //2vs2

    with TGlyph.Create(form) do begin
          name:=name_t+'a1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[1-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=3;
          tagstring:='a';
    end;
    {with TGlyph.Create(form) do begin
          name:=name_t+'a2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[34-1];
          align:=align.alClient;
          tag:=34;
          tagstring:='a';
    end;}
    //-------enemy-----------
    with TGlyph.Create(form) do begin
          name:=name_t+'b1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[25-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=13;
          tagstring:='b';
    end;
    {with TGlyph.Create(form) do begin
          name:=name_t+'b2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[24-1];
          align:=align.alClient;
          tag:=24;
          tagstring:='b';
    end;}

  end;
//-----------------
if name_grid.ChildrenCount=36 then
  begin           //2vs2

    with TGlyph.Create(form) do begin
          name:=name_t+'a1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[3-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=3;
          tagstring:='a';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'a2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[34-1];
          align:=align.alClient;
          tag:=34;
          tagstring:='a';
    end;
    //-------enemy-----------
    with TGlyph.Create(form) do begin
          name:=name_t+'b1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[13-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=13;
          tagstring:='b';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'b2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[24-1];
          align:=align.alClient;
          tag:=24;
          tagstring:='b';
    end;

  end;
//-----------------
if name_grid.ChildrenCount=64 then
  begin           //2vs2   8*8

    with TGlyph.Create(form) do begin
          name:=name_t+'a1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[4-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=4;
          tagstring:='a';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'a2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[61-1];
          align:=align.alClient;
          tag:=61;
          tagstring:='a';
    end;
    //-------enemy-----------
    with TGlyph.Create(form) do begin
          name:=name_t+'b1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[25-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=25;
          tagstring:='b';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'b2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[40-1];
          align:=align.alClient;
          tag:=40;
          tagstring:='b';
    end;

  end;
  //-------
if name_grid.ChildrenCount=100 then
  begin           //4vs4

    with TGlyph.Create(form) do begin
          name:=name_t+'a1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[4-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=4;
          tagstring:='a';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'a2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[7-1];
          align:=align.alClient;
          tag:=7;
          tagstring:='a';
    end;
     with TGlyph.Create(form) do begin
          name:=name_t+'a3';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[31-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=31;
          tagstring:='a';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'a4';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=1;
          parent:=name_grid.Children.Items[40-1];
          align:=align.alClient;
          tag:=40;
          tagstring:='a';
    end;
    //-------enemy-----------
    with TGlyph.Create(form) do begin
          name:=name_t+'b1';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[61-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=61;
          tagstring:='b';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'b2';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[70-1];
          align:=align.alClient;
          tag:=70;
          tagstring:='b';
    end;

      with TGlyph.Create(form) do begin
          name:=name_t+'b3';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[94-1]; //+1 pucase index start from 0
          align:=align.alClient;
          tag:=94;
          tagstring:='b';
    end;
    with TGlyph.Create(form) do begin
          name:=name_t+'b4';
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=2;
          parent:=name_grid.Children.Items[97-1];
          align:=align.alClient;
          tag:=97;
          tagstring:='b';
    end;

  end;


end;

function color_array(xy:Tarrayb;color:integer;form:tform):integer;
var i:integer;
begin
    for I := 0 to length(xy)-1 do
  begin
  TRectangle(form.FindComponent('bad'+'Rectangle'+inttostr(xy[I]))).Fill.Color
  :=TAlphaColor(color) ;
   TRectangle(form.FindComponent('bad'+'Rectangle'+inttostr(xy[I]))).TagString:='1';
  end;
end;

function fire(sprite:string;item:integer;name_grid:Tcontrol;imagelist:string;form:Tform):integer;
var name_f:string;
begin
      with TGlyph.Create(form) do begin
          name:='f'+inttostr(random(10000));
          name_f:=name;
          images:=Timagelist(form.FindComponent(imagelist));
          imageindex:=0;
          parent:=TGlyph(form.FindComponent(sprite));
          align:=align.alClient;
          tag:=TGlyph(form.FindComponent(sprite)).Tag;
    end;

move_ship(name_f,item,name_grid,form,0);
end;

function math_spec_sprit():Tarrayb;
begin

end;

function getpos_sprite(name_grid:Tcontrol;t:integer=0):Tarrayb;
var
  I,Ia,Ib: Integer;
  a_array,b_array:Tarrayb;
begin
 Ia:=0;
 Ib:=0;
  for I := 0 to name_grid.ChildrenCount-1 do  begin

    if name_grid.Children.Items[I].ChildrenCount>0 then begin

       If name_grid.Children.Items[I].Children.Items[0].TagString='a' then begin
            Ia:=Ia+1;
            setlength(a_array,length(a_array)+1);
            a_array[Ia-1]:=I+1;

       end else if  name_grid.Children.Items[I].Children.Items[0].TagString='b' then begin
            Ib:=Ib+1;
            setlength(b_array,length(b_array)+1);
            b_array[Ib-1]:=I+1;

       end;

    end;

  end;
    if t=0 then result := a_array + b_array
    else if t=1 then result := a_array
    else    result := b_array ;



end;

function ifendgame(name_grid:Tcontrol;form:Tform):integer;
var
ar:Tarrayb;
  I: Integer;
  x,y:integer;
  res:boolean;
  res_c:integer;                   // problem ? bad faunction
begin
   // x:=strtoint(name_grid.TagString.Split(['-'])[0]);
   // y:=strtoint(name_grid.TagString.Split(['-'])[1]);
     x:=strtoint(name_grid.TagString);
     y:=x;
     res_c:=0;
    ar:=getpos_sprite(name_grid);
    for I := 0 to round(length(ar)/2)-1 do
        if   (queensteps(ar[I],x,y,form)=nil) then res_c:=res_c+1;

   if res_c=round(length(ar)/2) then  exit(1);
      res_c:=0;

    for I := (round (length(ar)/2) ) to High(ar) do
        if  (queensteps(ar[I],x,y,form)=nil) then res_c:=res_c+1;


   if res_c=round(length(ar)/2) then  exit(2);
      res_c:=0;

result:=0;
end;

function sortarray(ar:Tarrayb):Tarrayb;
var i,j,hig:integer;
begin
hig:= High(ar);
    for I := 0 to hig do
      for J := 0 to hig do
        if  ar[I] < ar[J] then begin
                                 ar[I] := ar[I] + ar[J];
                                 ar[J] := ar[I] - ar[J];
                                 ar[I] := ar[I] - ar[J];
                                end;
result:=ar;
end;

function Effect_array(xy:Tarrayb;color:integer;form:tform):integer;
var i:integer;

begin

          for I := 0 to length(xy)-1 do begin
      with TInnerGlowEffect.Create(form) do
      begin
      name:='effect'+inttostr(xy[I]);
      parent:= TRectangle(form.FindComponent('bad'+'Rectangle'+inttostr(xy[I])));
      Opacity:=1;
      Softness:=2;
      glowcolor:=$FF09F9F9;
      end;
  TRectangle(form.FindComponent('bad'+'Rectangle'+inttostr(xy[I]))).TagString:='1';

  end;


end;

function get(url:string):string;
 var
  LHttp: TIdHttp;
begin
  LHttp := TIdHTTP.Create;
 // LHttp.Request.ContentType := 'application/x-www-form-urlencoded';
 // LHttp.Request.Charset := 'utf-8';
  try
    //LHttp.HandleRedirects := true;
    result := LHttp.Get(Url);
  finally
    LHttp.Free;
  end;
end;

function difference(a,b:real):real;
 begin

   result := abs(a - b);
   // double average = (a + b) / 2.0;
   // return difference * 100.0 / average;


 end;

function gethttp(url:string):string;

begin
     TThread.CreateAnonymousThread(
    procedure
    var
      LResult: string;
      LHttp: TIdHttp;
      res :string;
    begin
      TThread.Synchronize(nil,
      procedure
      begin
      try
        res :=LHttp.Get(Url);
        finally
        LHttp.Free;
        end;
      end );
    end
    ).Start;
   // result:= res;
    end;

function ex2_array(const AArray:Tarrayb;const BArray:Tarrayb): boolean;
var
  a,b: integer;
begin
  for a := 0 to High(AArray) do begin

     for b := 0 to High(BArray) do begin
            if AArray[a] = BArray[b] then Exit(true);
     end;

  end;
    result := false;

end;

function queensteps_out_array(id,x,y:integer;xy:Tarrayb;tag_sprit:string;form:Tform;one:integer):Tarrayb;
{
 this fun get old array and serch steps if exists step in the old array break
 if not add step to old array
 this fun to  eraly end game
}
var
//xy:Tarrayb;
copyid:integer;
//one:integer;
begin
//one:=0;
copyid:=id;
  // xy:=nil;
  
  
while not( ex_array(id,getoutlines(x,y,4)) )
  do begin
    id:=id-1;

    If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) and
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
     and    (xy<>nil)

    then
        begin
        xy:=[99];
        exit(xy);
        end;
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;

        //to left
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;
  
  id:=copyid;
  while not( ex_array(id,getoutlines(x,y,2)) )
  do begin
    id:=id+1;

   
    If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) and
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
     and    (xy<>nil)
    then
        begin
        xy:=[99];
        exit(xy);
        end;
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;
                                                      //to rghit
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;

  id:=copyid;
  while not( ex_array(id,getoutlines(x,y,1)) )
  do begin
    id:=id-x;

   
   If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) AND 
   (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
    and    (xy<>nil)
   then begin
        xy:=[99];
        exit(xy);
        end;   
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;                                                         //to top
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;

  id:=copyid;
  while not( ex_array(id,getoutlines(x,y,3)) )
  do begin
    id:=id+x;

   
   If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) AND 
   (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
    and    (xy<>nil)
   then begin
        xy:=[99];
        exit(xy);
        end; 
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;                                                            //to bootem
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,1))) and not(ex_array(id,getoutlines(x,y,4))) )
  do begin
    id:=id-(x+1);

      If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) AND 
   (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
    and    (xy<>nil)
   then begin
        xy:=[99];
        exit(xy);
        end;   
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;                                                          //to 1*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,1))) and not(ex_array(id,getoutlines(x,y,2))) )
  do begin
    id:=id-(x-1);

   
   If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) AND 
   (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
    and    (xy<>nil)
   then begin
        xy:=[99];
        exit(xy);
        end; 
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;
                                                              //to 2*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,2))) and not(ex_array(id,getoutlines(x,y,3))) )
  do begin
    id:=id+(x+1);

   
   If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) AND 
   (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
    and    (xy<>nil)
   then begin
        xy:=[99];
        exit(xy);
        end; 
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;                                                            //to 3*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;

  id:=copyid;
  while ( not(ex_array(id,getoutlines(x,y,4))) and not(ex_array(id,getoutlines(x,y,3))) )
  do begin
    id:=id+(x-1);

   
   If (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0) AND 
   (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).Children.Items[0].TagString=tag_sprit)
    and    (xy<>nil)
   then begin
        xy:=[99];
        exit(xy);
        end;  
      if
    (TRectangle(form.FindComponent('badrectangle'+IntToStr(id))).ChildrenCount>0)
    or
     (ex_array(id,xy))
   then break;                                                           //to 4*
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
    if one=1 then break;
  end;
     result := xy ;
//if length(xy)>0 then  result := xy else  result := nil;
 
end;

function earlyendgame(name_grid:Tcontrol;tag_sprit:string):Tarrayb;
{function to if game end early // see one side player enafe
use fun queensteps_out_array}
var
a:integer;
c,e:Tarrayb;
array_pos,res:Tarrayb;
I,j: Integer;
x,y:integer;
res0: Tarrayb;
begin
 res0:=[0];
  x:= strtoint(name_grid.TagString);                                                                                                            //if can_pos(xy_ghost,1)= nil then begin setlength(c,1); c[0]:=99; exit(c);  end;
  a:=0;
  c:=nil;
  e:=nil;
  res:=nil;
  if tag_sprit='a' then array_pos:=getpos_sprite(name_grid,1) else array_pos:=getpos_sprite(name_grid,2);
  if tag_sprit='a' then tag_sprit:='b' else tag_sprit:='a';

  for I := 0 to High(array_pos) do begin

    c:=queensteps_out_array(array_pos[I],x,x,res,tag_sprit,form2,0);
    a:=0;

   // if (length(c)>0) and (c[0]=99) and   (queensteps(array_pos[I],x,x,form2)=nil) then exit(res0);

    if (length(c)>0) and (c[0]=99) then  exit(nil);  //c:=[99]

    while (high(c)<>a-1) do begin

      e:=queensteps_out_array(c[a],x,x,c,tag_sprit,form2,1);
      if  (length(e)>0) and (e[0]=99)  then   exit(nil);  //e=[99]
      if (length(e)> 0 ) and (e[0] <> 99)  then  begin c:=e; e:=nil;
                                                    end;
    a:=a+1;
    end;

  //if ex2_array(res,c) then   res:=c else     res:=res+c ;
       res:=c

  end;
  //res:=  sortarray(res);
  if res=nil then  res:=[0];

  result:= res ;



end;

//-----------------------------
function get_pos_sprit_s(board:Tarrayb;sprit:integer):Tarrayb ;
var I:integer;
begin
for I := 0 to High(board) do

    if  board[I]=sprit then begin

        setlength(result,length(result)+1);
        result[high(result)]:= I;

    end;

end;

function getoutlines_s(x,y,p:integer):Tarrayb ;
var I:integer;
II:integer;
res:Tarrayb;
begin
II:=0;
result:=nil;

//---------TOP-----------------------
  if p=1 then  begin
    setlength(result,x);

    for I := 1 to x do begin
    result[I-1] := I-1;
    end;
  end;
//---------BOTTOM----------------------
  if p=3 then begin
    setlength(result,x);

    for I := ((x*y)-(x-1)) to (x*y) do begin
    result[II] := I-1;
    II:=II+1;
    end;

  end;
//------------RGHIT---------------------

  if p=2 then begin
    setlength(result,Y);
    II:=x;
    for I := 1 to Y do begin
    result[I-1] := II-1;
    II:=II+x;
    end;
  end;
//------------left---------------------

  if p=4 then begin
    setlength(result,Y);
    II:=1;
    for I := 1 to Y do begin
    result[I-1] := II-1;
    II:=II+x;
    end;
  end;

end;

function creatboard_s(x,y:integer):Tarrayb;
var
  xy,I:integer;
  res:Tarrayb;

begin
  xy:=x*y;
  setlength(res,xy);
  for I := 0 to High(res) do
      res[i]:=0;

  result:=res;
end;

function creat_sprite_s(xy:Tarrayb):Tarrayb;
begin
  if length(xy)=9 then begin
    xy[0]:=2;
    xy[8]:=1;

  end;
result:=xy;
end;

function queensteps_s(id:integer;board:Tarrayb):Tarrayb;
var
  copyid,x,y:integer;
  res:Tarrayb;

begin
  //id:=id-1;
  copyid:=id;
  x:=Trunc(Sqrt(length(board)));   //round 1.5=2  Trunc 1.5=1
  y:=x;

  while not( ex_array(id,getoutlines_s(x,y,4)) )
  do begin
    id:=id-1;
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

  id:=copyid;

  while not( ex_array(id,getoutlines_s(x,y,2)) )
  do begin
    id:=id+1;
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

  id:=copyid;

  while not( ex_array(id,getoutlines_s(x,y,1)) )
  do begin
    id:=id-x;
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

  id:=copyid;

  while not( ex_array(id,getoutlines_s(x,y,3)) )
  do begin
    id:=id+x;
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

  id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,1))) and not(ex_array(id,getoutlines_s(x,y,4))) )
  do begin
    id:=id-(x+1);
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

  id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,1))) and not(ex_array(id,getoutlines_s(x,y,2))) )
  do begin
    id:=id-(x-1);
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

  id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,2))) and not(ex_array(id,getoutlines_s(x,y,3))) )
  do begin
    id:=id+(x+1);
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,4))) and not(ex_array(id,getoutlines_s(x,y,3))) )
  do begin
    id:=id+(x-1);
    if (board[id]<>0)
    then break;
    setlength(res,length(res)+1);
    res[High(res)] := id;
  end;

if length(res)>0 then result := res ;

end;

function queensteps_end_s(id:integer;board:Tarrayb;xy:Tarrayb;anti_sprit:integer;step:integer=0):Tarrayb;
var
  copyid,x,y:integer;
  //res:Tarrayb;

begin
  //id:=id-1;
  copyid:=id;
  x:=Trunc(Sqrt(length(board)));   //round 1.5=2  Trunc 1.5=1
  y:=x;

  while not( ex_array(id,getoutlines_s(x,y,4)) )
  do begin
    id:=id-1;
    if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;

    if (board[id]<>0) or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;

    if step=1 then break;

  end;

  id:=copyid;

  while not( ex_array(id,getoutlines_s(x,y,2)) )
  do begin
    id:=id+1;
        if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;
    if (board[id]<>0) or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
  end;

  id:=copyid;

  while not( ex_array(id,getoutlines_s(x,y,1)) )
  do begin
    id:=id-x;
        if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;
    if (board[id]<>0) or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
  end;

  id:=copyid;

  while not( ex_array(id,getoutlines_s(x,y,3)) )
  do begin
    id:=id+x;
        if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;
    if (board[id]<>0)  or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
  end;

  id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,1))) and not(ex_array(id,getoutlines_s(x,y,4))) )
  do begin
    id:=id-(x+1);
        if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;
    if (board[id]<>0)  or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
  end;

  id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,1))) and not(ex_array(id,getoutlines_s(x,y,2))) )
  do begin
    id:=id-(x-1);
        if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;
    if (board[id]<>0)  or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
  end;

  id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,2))) and not(ex_array(id,getoutlines_s(x,y,3))) )
  do begin
    id:=id+(x+1);
        if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;
    if (board[id]<>0) or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
  end;

id:=copyid;

  while ( not(ex_array(id,getoutlines_s(x,y,4))) and not(ex_array(id,getoutlines_s(x,y,3))) )
  do begin
    id:=id+(x-1);
        if (board[id]=anti_sprit) then
    begin
          xy:=[101];
          exit(xy);
    end;
    if (board[id]<>0) or (ex_array(id,xy))
    then break;
    setlength(xy,length(xy)+1);
    xy[High(xy)] := id;
  end;

 result := xy ;

end;

function earlyendgame_s(board:Tarrayb;ab:integer):tarrayb; //if 101 not yet END GAME if 0 null if >0 win if <0 los *AI*
var
  I,a,anti_sprit:integer;
  pos_sprit,c,e,res,notyet:Tarrayb;
begin
  notyet:=[-1001];

  a:=0;
  c:=nil;
  e:=nil;
  res:=nil;
 if ab=1 then begin
    pos_sprit := get_pos_sprit_s(board,1);      //multi sprit num??   to playe1
    anti_sprit:=2;
  end else begin
    pos_sprit := get_pos_sprit_s(board,2);      //multi sprit num??   to player2
    anti_sprit:=1;
  end;


  for I := 0 to High(pos_sprit) do begin

    a:=0;
    c:=queensteps_end_s(pos_sprit[I],board,res,anti_sprit,0);

    if (length(c)>0) and (c[0]=101) then  exit(notyet);   //not yet end game

    while  (high(c)>a-1) do begin

      e:=queensteps_end_s(c[a],board,c,anti_sprit,0);
      if  (length(e)>0) and (e[0]=101)  then   exit(notyet);
      if (length(e)> 0 ) and (e[0] <> 101)  then  begin c:=e; e:=nil;
                                                    end;
    a:=a+1;
    end;

    res:=c;

  end;

    //if res=nil then  res:=[0];

     result:= sortarray(res) ;


end;

function score(board:Tarrayb):Tarrayb;   //[0or1,score] //0 not yet end game
                                        //else 1 / and score
var a,b,score:integer;
    a_arr,barr:Tarrayb;
begin
a_arr:=earlyendgame_s(board,1);
a:= length(a_arr);

if (a>0) and (a_arr[0]=-1001) then begin result:=[0,0]; exit();    end;


      b:= length(earlyendgame_s(board,2));
      score:= a-b;
      result:=[1,score];

end;

function static_evaluation(board:Tarrayb):integer;
var I:integer;
    pos_sprit:tarrayb;
    score_a,score_b:integer;
begin

  pos_sprit := get_pos_sprit_s(board,1);
  for I := 0 to High(pos_sprit) do
    score_a := score_a + length(queensteps_s(pos_sprit[I],board)) ;

  pos_sprit := get_pos_sprit_s(board,2);
  for I := 0 to High(pos_sprit) do
    score_b := score_b + length(queensteps_s(pos_sprit[I],board)) ;

result:=score_a-score_b;


end;

function move_fire(xy,toxy:integer;board:Tarrayb;mf:integer):Tarrayb;
begin

if mf=1 then   begin
board[toxy]:=board[xy];
board[xy]:=0;
end else board[toxy]:=-1;

result:=board;

end;

function minmax(board:tarrayb;depth:integer;alpha,beta:integer;Playerturn:boolean):integer;
var
score_v:tarrayb;
eval,maxeval,mineval,I,II,III:integer;
steps,steps2:tarrayb;
pos_sprit:tarrayb;
begin
score_v:=score(board);
if (score_v[0]=1) then   exit(score_v[1]);          //if endgame result score
if (depth=0) then exit( static_evaluation(board) ); //result static eval

 if Playerturn then begin

    maxeval:= -1000 ;
    pos_sprit:=get_pos_sprit_s(board,1);
    for I := 0 to High(pos_sprit) do  begin
      steps:= queensteps_s(pos_sprit[I],board);
      for II := 0 to High(steps) do begin
          board:=move_fire(pos_sprit[I],steps[II],board,1);
          steps2:= queensteps_s(steps[II],board);
          for III := 0 to High(steps2) do begin
            board:=move_fire(steps[II],steps2[III],board,2);
            eval:=minmax(board,depth-1,alpha,beta,false);
            board[steps2[III]]:=0;
            maxeval:=max(maxeval,eval);
            alpha:=max(alpha,eval);
            //result:=maxeval;
            if beta<=alpha then break;//exit(alpha);//

          end;
          board:=move_fire(steps[II],pos_sprit[I],board,1);
      end;

    end;
    result:=maxeval;
 end else begin

    mineval:= 1000 ;            //Infinity
    pos_sprit:=get_pos_sprit_s(board,2);
    for I := 0 to High(pos_sprit) do begin
      steps:= queensteps_s(pos_sprit[I],board);
      for II := 0 to High(steps) do  begin
          board:=move_fire(pos_sprit[I],steps[II],board,1); //MOVE
          steps2:= queensteps_s(steps[II],board);
          for III := 0 to High(steps2) do begin
            board:=move_fire(steps[II],steps2[III],board,2); //FIRE
            eval:=minmax(board,depth-1,alpha,beta,true);
            board[steps2[III]]:=0;
            mineval:=min(mineval,eval);
            beta:=min(beta,eval);
            //result:=mineval;
            if beta<=alpha then break;//exit(alpha);//

          end;
          board:=move_fire(steps[II],pos_sprit[I],board,1);
      end;
    end;
    result:=mineval;
 end;

end;

function printr(arr:tarrayb):integer;
var i:integer;
begin
for I := 0 to High(arr) do
       form2.Memo2.Lines.Add(inttostr(i)+' : '+inttostr(arr[i]));

end;

function moveai(board:tarrayb):tarrayb;
var I,II,III:integer;
    pos_sprit,steps,steps2:tarrayb;
    eval,maxeval:integer;
    bestmove:tarrayb;
begin

    maxeval:= -1000 ;
    pos_sprit:=get_pos_sprit_s(board,1);
    for I := 0 to High(pos_sprit) do  begin
      steps:= queensteps_s(pos_sprit[I],board);
      for II := 0 to High(steps) do begin
          board:=move_fire(pos_sprit[I],steps[II],board,1);
          steps2:= queensteps_s(steps[II],board);

          for III := 0 to High(steps2) do begin
            board:=move_fire(steps[II],steps2[III],board,2);
            eval:=minmax(board,0,-1,1,false);
             //printr(board);
            board[steps2[III]]:=0;

            //bestmove:=[pos_sprit[I],steps[II],steps2[III]];
            //form2.Memo2.Lines.Add(inttostr(bestmove[0])+'-'+inttostr(bestmove[1])+'-'+inttostr(bestmove[2])  );
            if eval>maxeval then begin
              maxeval:=eval;
              bestmove:=[pos_sprit[I],steps[II],steps2[III]];
            end;
          end;
          board:=move_fire(steps[II],pos_sprit[I],board,1);
      end;
    end;
    result:= bestmove;


end;

function convertsim(name_grid:Tcontrol):Tarrayb;
var
res:Tarrayb;
i:integer;
begin

  for I := 0 to name_grid.ChildrenCount-1 do  begin

    if name_grid.Children.Items[I].ChildrenCount>0 then begin

       If name_grid.Children.Items[I].Children.Items[0].TagString='a' then begin

            setlength(res,length(res)+1);
            res[high(res)]:=2;

       end else if  name_grid.Children.Items[I].Children.Items[0].TagString='b' then begin

            setlength(res,length(res)+1);
            res[high(res)]:=1;

       end else begin

            setlength(res,length(res)+1);
            res[high(res)]:=-1;

       end;

    end else begin
            setlength(res,length(res)+1);
            res[high(res)]:=0;

    end;

  end;
  result:=res;
end;

function turnai(name_grid:Tcontrol):Tarrayb;
var
arr,bestmove:tarrayb;
//------------
tag_c:integer;
AComponent : TComponent;
begin







          arr:= convertsim(name_grid);
          bestmove:=moveai(arr);
          form2.clickmove(TRectangle(form2.FindComponent('badRectangle'+inttostr(bestmove[0]+1))));
          form2.clickmove(TRectangle(form2.FindComponent('badRectangle'+inttostr(bestmove[1]+1))));
          //form2.clickmove(TRectangle(form2.FindComponent('badRectangle'+inttostr(bestmove[2]+1))));


    AComponent := form2.FindComponent('tbot');

  if  not  assigned(AComponent)  then   begin
  tbot := timerbot.Create(form2);
  tbot.Enabled:=false;
  end;
  if tbot.Enabled=true then exit;
  tbot.Name:='tbot';
  tbot.bestmove:=bestmove[2]+1;
  tbot.Interval := 2000;
  tbot.OnTimer := timerbot.goTimerbot;
  tbot.Enabled := True;

end;

class procedure timerbot.goTimerbot(Sender: TObject);
var
  //--------------
  bestmove:integer;
  //--------------
begin

  bestmove:=(Sender as Timerbot ).bestmove;

  form2.clickmove(TRectangle(form2.FindComponent('badRectangle'+inttostr(bestmove))));
  (Sender as Timerbot).Enabled := false;
end;

class procedure timerbot.gominmax(Sender: TObject);
//var
begin
turnai(form2.GridLayout1);
(Sender as Timerbot).Enabled := false;
end;

end.
