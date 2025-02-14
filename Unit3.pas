unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdFTP, Vcl.StdCtrls, JPEG;

type
  TForm3 = class(TForm)
    IdFTP1: TIdFTP;
    Image1: TImage;
    Timer1: TTimer;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure DownloadLatestImage;
    procedure Displayimage(FileName: string);

  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Displayimage(FileName: string);
var
  JPG: TJPEGImage;
  BMP: TBitmap;
begin
  if not FileExists(FileName) then
    begin
      showMessage('plik nie istnieje:'+FileName);
      Exit;
    end;

  JPG := TJPEGImage.Create;
  BMP := TBitmap.Create;

  try
    JPG.LoadFromFile(FileName);
    BMP.Assign(JPG);
    Image1.Picture.Bitmap.Assign(BMP);
  except
    on E: Exception do
      ShowMessage('B��d wy�wietlania obrazu:' + E.Message);
    end;

  JPG.Free;
  BMP.Free;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Timer1.Interval := 30000;
  Timer1.Enabled := True;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  DownloadLatestImage;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
     DownloadLatestImage;
end;

procedure TForm3.DownloadLatestImage;
var
  FileList: TStringList;
  NewestFile: string;
  LastFileName: string;
  i: Integer;
  FileDate: TDateTime;
  NewestDate: TDateTime;
begin

  IdFTP1.Host := 'ftp_host_name';
  idFTP1.Username := 'ftp_user_name';
  idFTP1.Password := 'ftp_password';

  FileList := TStringList.Create;

  try
      idFTP1.Connect;
      try
//        ShowMessage('Connected to FTP!');
        idFTP1.List(FileList, '', False);

        NewestFile := '';
        Newestdate := 0;



        for i:=0 to FileList.Count - 1 do
          begin

            if (FileList[i] = '.') or (FileList[i] = '..') then
              continue;

            FileDate := idFTP1.FileDate(FileList[i]);

            if FileDate > NewestDate then
              begin
                NewestDate := FileDate;
                NewestFile := FileList[i];
              end;
          end;

          if (NewestFile <> '') and (NewestFile <> LastFileName) then
          begin
            LastFileName := NewestFile;
            idFTP1.Get(NewestFile, 'H:\PobraneZdjecia\'+ NewestFile, True);
//            Image1.Picture.LoadFromFile('H:\PobraneZdjecia\'+ NewestFile);
            DisplayImage('H:\PobraneZdjecia\'+newestFile);
          end;
        finally
          FileList.Free;
      end;
  finally
    idFTP1.Disconnect;
  end;
end;



end.
