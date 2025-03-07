codeunit 50111 "Bank Statement Import"
{
    procedure ProcessFile(FilePath: Text)
    var
        InStr: InStream;
        BankSTMTLine: Record "Bank Statement Line";
        tempblob: Codeunit "Temp Blob";
        filemgt: Codeunit "File Management";
        BankStatementLine: Record "Bank Statement Line";
        Line: Text;
        Fields: List of [Text];
    begin
        if UploadIntoStream('Import Bank Statement', '', 'CSV Files (*.csv)|*.csv', FilePath, InStr) then begin
            while not InStr.EOS do begin
                InStr.ReadText(Line);
                Fields := Line.Split(',');
                if Fields.Count >= 4 then begin
                    BankStatementLine.Init();
                    BankStatementLine."Bank Account No." := Fields.Get(1);
                    BankStatementLine."Transaction Date" := EvaluateDate(Fields.Get(2));
                    BankStatementLine."Description" := Fields.Get(3);
                    BankStatementLine."Amount" := EvaluateDecimal(Fields.Get(4));
                    BankStatementLine.Insert();
                end;
            end;
        end else
            Error('File upload failed');

    end;

    local procedure EvaluateDate(Value: Text): Date
    var
        MyDate: Date;
    begin
        Evaluate(MyDate, Value);
        exit(MyDate);
    end;

    local procedure EvaluateDecimal(Value: Text): Decimal
    var
        MyDecimal: Decimal;
    begin
        Evaluate(MyDecimal, Value);
        exit(MyDecimal);
    end;
}
