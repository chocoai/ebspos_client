unit uIEventFrame;

interface

type
  IEventFrame = interface
    procedure DoOnHide(Sender: TObject);
    procedure DoOnShow(Sender: TObject);
    procedure DoOnResize(Sender: TObject);
  end;

implementation

end.
