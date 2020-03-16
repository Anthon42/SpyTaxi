unit uHttpDownloader;

interface

uses IdHTTP, IdSSLOpenSSL, System.SysUtils, Vcl.Dialogs, System.Classes, IdCookieManager
  // User moduls
    , uExUtils, uAuthorizationBearerGenerator;

type
  THTTPDownloader = class(TObject)
  strict private
    hpHtmlDownloader: TIdHTTP;
    sslSocket: TIdSSLIOHandlerSocketOpenSSL;
    FCookieManager: TIdCookieManager;

    FAuthorizationBearerGenerator: TAuthorizationBearerGenerator;
    procedure ReplaseAuthorizationBearer;
  public
    function Get(const AUrl: string; out AResponseText: string; out AErrorStr: string): Boolean;

    function Post(const AUrl: string; const APostData: TStringStream; out AResponseText: string; out AErrorStr: string): Boolean;

    procedure ClearCookies;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

const
  constUserAgent =
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36 OPR/50.0.2762.58';
  constConnectTimeOut = 10000;
  constReadTimeOut = 10000;
  // constAuthorizationHeader = 'Bearer CGU2tWGE7CSBtJnNpNye';
  consFullFileName = 'BearerList.txt';

implementation

{ THTTPuploader }

procedure THTTPDownloader.AfterConstruction;
begin
  inherited;

  FAuthorizationBearerGenerator := TAuthorizationBearerGenerator.Create(consFullFileName);

  FCookieManager := TIdCookieManager.Create;

  sslSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  sslSocket.SSLOptions.Method := sslvTLSv1_2;

  hpHtmlDownloader := TIdHTTP.Create;

  hpHtmlDownloader.CookieManager := FCookieManager;
  hpHtmlDownloader.AllowCookies := True;
  hpHtmlDownloader.Request.UserAgent := constUserAgent;

  hpHtmlDownloader.Request.AcceptLanguage := 'ru-RU';
  // hpHtmlDownloader.Request.CustomHeaders.AddValue('Authorization', constAuthorizationHeader);

  hpHtmlDownloader.IOHandler := sslSocket;
  hpHtmlDownloader.ConnectTimeout := constConnectTimeOut;
  hpHtmlDownloader.ReadTimeout := constReadTimeOut;
end;

procedure THTTPDownloader.BeforeDestruction;
begin
  inherited;
  FreeAndNilEx(FCookieManager);
  FreeAndNilEx(hpHtmlDownloader);
  FreeAndNilEx(sslSocket);
end;

procedure THTTPDownloader.ClearCookies;
begin
  hpHtmlDownloader.CookieManager.CookieCollection.Clear;
  hpHtmlDownloader.Response.CustomHeaders.Clear;
end;

function THTTPDownloader.Get(const AUrl: string; out AResponseText: string; out AErrorStr: string): Boolean;
begin
  try
    ClearCookies;
    ReplaseAuthorizationBearer;
    AResponseText := hpHtmlDownloader.Get(AUrl);

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      AErrorStr := E.ClassName + E.Message;
    end;
  end;
end;

function THTTPDownloader.Post(const AUrl: string; const APostData: TStringStream; out AResponseText: string;
  out AErrorStr: string): Boolean;
begin
  Result := False;
  try
    if not Assigned(APostData) then
    begin
      AErrorStr := 'Пустые данные для отправки';
      Exit;
    end;
    AResponseText := hpHtmlDownloader.Post(AUrl, APostData);

    Result := True;
  except
    on E: Exception do
    begin
      AErrorStr := E.ClassName + E.Message;
    end;
  end;

end;

procedure THTTPDownloader.ReplaseAuthorizationBearer;
begin
  hpHtmlDownloader.Request.CustomHeaders.Clear;
  hpHtmlDownloader.Request.CustomHeaders.AddValue('Authorization', FAuthorizationBearerGenerator.ReturnBearer);
end;

end.
