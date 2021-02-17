{
  Author : Ersan YAKIT
           ersanyakit@yahoo.com.tr
           www.ersanyakit.com
           Admob Interstitials Snippet Code Using The Android JNI In Delphi XE7 Firemonkey

}
unit FMX.InterstitialAd.Android;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  Androidapi.JNI.AdMob,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Widget,
  Androidapi.JNI.Location,
  Androidapi.JNI.App,
  Androidapi.JNI.Util,
  Androidapi.helpers,
  FMX.helpers.android,
  FMX.Platform.Android,
  Androidapi.JNI.Embarcadero,
  Androidapi.JNI.GraphicsContentViewText,
  FMX.Advertising,
  FMX.StdCtrls ;

type
  TInterstitialAdListener = class(TJavaLocal, JIAdListener)
  private
    FAd : JInterstitialAd;
  public
    procedure onAdClosed; cdecl;
    procedure onAdFailedToLoad(errorCode: Integer); cdecl;
    procedure onAdLeftApplication; cdecl;
    procedure onAdOpened; cdecl;
    procedure onAdLoaded; cdecl;
  end;


  TEventProc          = procedure(pszData : string);

 type
  TInterstitialAdvertisment = class
  private
      FTestMode : Boolean;
      procedure SetTestMode(AMode:Boolean);
  public
      FJAdRequest      : JAdRequest;
      FJInterstitialAd : JInterstitialAd;
      RequestBuilder   : JAdRequest_Builder;
      FAdUnitID        : string;
      FInterstitialAdListener : TInterstitialAdListener;

      FEventOnAdClosed          : TEventProc;
      FEventonAdFailedToLoad    : TEventProc;
      FEventonAdLeftApplication : TEventProc;
      FEventonAdOpened          : TEventProc;
      FEventononAdLoaded        : TEventProc;

      constructor Create;
      procedure SetOnCloseEvent(AProc : TEventProc);
      procedure SetOnAdFailedToLoad(AProc : TEventProc);
      procedure SetOnAdLeftApplication(AProc : TEventProc);
      procedure SetOnAdOpened(AProc : TEventProc);
      procedure SetOnAdLoaded(AProc : TEventProc);
      procedure InitAdvertisment;
      procedure setAdUnitId(AUnitID : string);

  property  TestMode : Boolean read FTestMode write SetTestMode;


  end;

 var
  AInterstitialAdvertisment : TInterstitialAdvertisment;


implementation


// Listener;
procedure TInterstitialAdListener.onAdClosed;
begin
  AInterstitialAdvertisment.FEventOnAdClosed('onAdClosed:Ok');
end;

procedure TInterstitialAdListener.onAdFailedToLoad(errorCode: Integer);
begin
  AInterstitialAdvertisment.FEventonAdOpened('onAdFailedToLoad:OK:ErrorCode:'+IntToStr(errorCode));
end;

procedure TInterstitialAdListener.onAdLeftApplication;
begin
  AInterstitialAdvertisment.FEventonAdOpened('onAdLeftApplication:OK');
end;

procedure TInterstitialAdListener.onAdOpened;
begin
  AInterstitialAdvertisment.FEventonAdOpened('onAdOpened:OK');
end;

procedure TInterstitialAdListener.onAdLoaded;
begin
  AInterstitialAdvertisment.FEventononAdLoaded('onAdLoaded:OK');
  AInterstitialAdvertisment.FJInterstitialAd.show;
end;


//Component;
constructor TInterstitialAdvertisment.Create;
begin
    inherited Create;
    FTestMode := True;
    AInterstitialAdvertisment:=Self;
end;

procedure TInterstitialAdvertisment.setAdUnitId(AUnitID : string);
begin
  if AUnitID<>FAdUnitID then FAdUnitID := AUnitID;
end;

procedure TInterstitialAdvertisment.InitAdvertisment;
begin

 CallInUIThread(procedure
                  begin
                      FJInterstitialAd := TJInterstitialAd.JavaClass.init(MainActivity);


                      FJInterstitialAd.setAdUnitId(StringToJString(FAdUnitID));
                      RequestBuilder := TJAdRequest_Builder.JavaClass.init();

                      if FTestMode = true
                        then begin
                              RequestBuilder.addTestDevice(TJAdRequest.JavaClass.DEVICE_ID_EMULATOR);
                              RequestBuilder.addTestDevice(MainActivity.getDeviceID);
                             end;

                      FJAdRequest := RequestBuilder.build;
                      FInterstitialAdListener := TInterstitialAdListener.Create();

                      FJInterstitialAd.setAdListener(TJAdListenerAdapter.JavaClass.init(FInterstitialAdListener));
                      FJInterstitialAd.loadAd(FJAdRequest);

                  end);

end;

procedure TInterstitialAdvertisment.SetTestMode(AMode:Boolean);
begin
  FTestMode := AMode;
end;

procedure TInterstitialAdvertisment.SetOnCloseEvent(AProc : TEventProc);
begin
    FEventOnAdClosed := AProc;
end;

procedure TInterstitialAdvertisment.SetOnAdFailedToLoad(AProc : TEventProc);
begin
    FEventonAdFailedToLoad := AProc;
end;

procedure TInterstitialAdvertisment.SetOnAdLeftApplication(AProc : TEventProc);
begin
    FEventonAdLeftApplication := AProc;
end;

procedure TInterstitialAdvertisment.SetOnAdOpened(AProc : TEventProc);
begin
    FEventonAdOpened := AProc;
end;

procedure TInterstitialAdvertisment.SetOnAdLoaded(AProc : TEventProc);
begin
    FEventononAdLoaded := AProc;
end;

end.

