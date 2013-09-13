unit uCustomerBindingConverter;

// Bind Engine Extensions

interface

uses System.Classes, System.SysUtils, Data.DB, Data.Bind.Components, System.Bindings.Helper, System.Generics.Collections, uModel, SynCommons, mORMot, System.MaskUtils;

implementation

uses System.Bindings.EvalProtocol, System.Rtti, System.Bindings.Outputs, Vcl.Graphics, Vcl.Bind.Consts, VCL.Controls;



const
  sThisUnit = 'uCustomerBindingConverter';
  
  sIDTGenderToInteger = 'TGenderToInteger';
  sTGenderToInteger = 'TGenderToInteger';
  sTGenderToIntegerDesc = 'TGenderToInteger';

  sIDIntegerToTGender = 'IntegerToTGender';
  sIntegerToTGender = 'IntegerToTGender';
  sIntegerToTGenderDesc = 'IntegerToTGender';
  
  sIDTTimeLogToTDate = 'TTimeLogToTDate';
  sTTimeLogToTDate = 'TTimeLogToTDate';
  sTTimeLogToTDateDesc = 'TTimeLogToTDate';
  
  sIDTDateToTTimeLog = 'TDateToTTimeLog';
  sTDateToTTimeLog = 'TDateToTTimeLog';
  sTDateToTTimeLogDesc = 'TDateToTTimeLog';
  

  procedure RegisterOutputConversions;
  begin

    // Register global conversion
    // Assign nil to TPicture clears picture
    TValueRefConverterFactory.RegisterConversion(
      TypeInfo(TGender), TypeInfo(Integer),
      TConverterDescription.Create(
        procedure(const InValue: TValue; var OutValue: TValue)
        begin
          Assert(InValue.IsType<TGender>);
          OutValue := TValue.From<Integer>(Ord(InValue.AsType<TGender>));
        end,
        sIDTGenderToInteger,
        sTGenderToInteger,
        sThisUnit, True, sTGenderToIntegerDesc, VCL.Controls.TControl{vcl only})); 

    TValueRefConverterFactory.RegisterConversion(
      TypeInfo(Integer), TypeInfo(TGender),
      TConverterDescription.Create(
        procedure(const InValue: TValue; var OutValue: TValue)
        begin
          Assert(InValue.IsType<Integer>);
          OutValue := TValue.From<TGender>(TGender(InValue.AsType<Integer>));
        end,
        sIDIntegerToTGender,
        sIntegerToTGender,
        sThisUnit, True, sIntegerToTGenderDesc, VCL.Controls.TControl{vcl only}));
    
    
    TValueRefConverterFactory.RegisterConversion(
      TypeInfo(TTimeLog), TypeInfo(TDate),
      TConverterDescription.Create(
        procedure(const InValue: TValue; var OutValue: TValue)
        var
          date: TDate;
          t: TTimeLog;
        begin
          Assert(InValue.IsType<TTimeLog>);
          t := InValue.AsType<TTimeLog>;
          date := Iso8601(t).ToDate;
          OutValue := TValue.From<TDate>(date);
        end,
        sIDTTimeLogToTDate,
        sTTimeLogToTDate,
        sThisUnit, True, sTTimeLogToTDateDesc, VCL.Controls.TControl{vcl only}));

    TValueRefConverterFactory.RegisterConversion(
      TypeInfo(TDate), TypeInfo(TTimeLog),
      TConverterDescription.Create(
        procedure(const InValue: TValue; var OutValue: TValue)
        var
          t: TTimeLog;
        begin
          Assert(InValue.IsType<TDate>);
          Iso8601(t).From(InValue.AsType<TDate>, True);
          OutValue := TValue.From<TTimeLog>(t);
        end,
        sIDTDateToTTimeLog,
        sTDateToTTimeLog,
        sThisUnit, True, sTDateToTTimeLogDesc, VCL.Controls.TControl{vcl only}));
    
    TValueRefConverterFactory.RegisterConversion(
      TypeInfo(Boolean), TypeInfo(Integer),
      TConverterDescription.Create(
        procedure(const InValue: TValue; var OutValue: TValue)
        var
          t: Boolean;
        begin
          Assert(InValue.IsType<Boolean>);
          t := InValue.AsType<Boolean>;
          if t then
            OutValue := TValue.From<Integer>(1)
          else
            Outvalue := TValue.From<Integer>(0);
        end,
        'BooleanToInteger',
        'BooleanToInteger',
        sThisUnit, True, 'BooleanToInteger', VCL.Controls.TControl{vcl only}));
    
    TValueRefConverterFactory.RegisterConversion(
      TypeInfo(Integer), TypeInfo(Boolean),
      TConverterDescription.Create(
        procedure(const InValue: TValue; var OutValue: TValue)
        var
          t: Integer;
        begin
          Assert(InValue.IsType<Integer>);
          t := InValue.AsType<Integer>;
          if t = 0 then
            OutValue := TValue.From<Boolean>(False)
          else
            Outvalue := TValue.From<Boolean>(True);
        end,
        'IntegerToBoolean',
        'IntegerToBoolean',
        sThisUnit, True, 'IntegerToBoolean', VCL.Controls.TControl{vcl only}));
  end;

  procedure UnregisterOutputConversions;
  begin
    TValueRefConverterFactory.UnRegisterConversion(
      TypeInfo(TGender), TypeInfo(Integer));
    TValueRefConverterFactory.UnRegisterConversion(
      TypeInfo(Integer), TypeInfo(TGender));
    
    TValueRefConverterFactory.UnRegisterConversion(
      TypeInfo(TTimeLog), TypeInfo(TDate));
    TValueRefConverterFactory.UnRegisterConversion(
      TypeInfo(TDate), TypeInfo(TTimeLog));
    
    TValueRefConverterFactory.UnRegisterConversion(
      TypeInfo(Boolean), TypeInfo(Integer));
    TValueRefConverterFactory.UnRegisterConversion(
      TypeInfo(Integer), TypeInfo(Boolean));  
  end;


initialization
  RegisterOutputConversions;
finalization
  UnregisterOutputConversions;
end.
