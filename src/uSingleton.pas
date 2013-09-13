unit uSingleton;

interface
uses
  System.SysUtils, System.Classes;
type
  TSingleton<T: class> = class
    strict private
      class var instance_: T;
      class destructor Destroy;
      class function GetInstance: T; static;
      class function CreateSingleton: T; static;
      class procedure FreeSingleton(var Instance: T); static;
  public
    constructor Create;
    destructor Destroy; override;
    class property Instance: T read GetInstance;
  end;
  
resourcestring
  InvalideSingletonCreate = 'please use TSingleton<T>.Instance';
  InvalideSingletonDestroy = 'no need to destory singleton instance';
  
implementation
uses
  Windows;

constructor TSingleton<T>.Create;
begin
  raise EInvalidOperation.Create(InvalideSingletonCreate);
end;

class function TSingleton<T>.CreateSingleton: T;
begin
  result := T(T.NewInstance);
  TSingleton<T>(result).AfterConstruction;
end;

destructor TSingleton<T>.Destroy;
begin
  if ExceptObject = nil then
    raise EInvalidOperation.Create(InvalideSingletonDestroy);
end;

class destructor TSingleton<T>.Destroy;
begin
  FreeSingleton(instance_);
end;

class procedure TSingleton<T>.FreeSingleton(var Instance: T);
begin
  if Instance <> nil then
  begin
    TSingleton<T>(Instance).BeforeDestruction;
    TSingleton<T>(Instance).FreeInstance;
    Instance := nil;
  end;
end;

class function TSingleton<T>.GetInstance: T;
var
  NewInstance: T;
begin
  if instance_ = nil then
  begin
    NewInstance := CreateSingleton;
    if InterlockedCompareExchangePointer(PPointer(@instance_)^, PPointer(@NewInstance)^, nil) <> nil then
      FreeSingleton(NewInstance);
  end;
  Result := instance_;
end;

end.
