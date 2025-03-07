codeunit 50110 ConvertToBaese64
{
    procedure ConvertExcelToBase64()
    var
        Cust: Record Customer;
        TmpExcelBuf: Record "Excel Buffer" temporary;
        SheetName: Text;
        Base64String: Text;
        BaseConvert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        Outstrm: OutStream;
        Instr: InStream;
    begin
        Clear(TmpExcelBuf);
        TmpExcelBuf.DeleteAll();
        TmpExcelBuf.NewRow();
        // add columns 
        TmpExcelBuf.AddColumn(Cust.FieldCaption("No."), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Cust.FieldCaption(Name), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Cust.FieldCaption(Contact), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Cust.FieldCaption(Balance), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Cust.FieldCaption(City), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        // excel data
        if Cust.FindSet() then
            repeat
                TmpExcelBuf.NewRow();
                Cust.CalcFields(Balance);
                TmpExcelBuf.AddColumn(Cust."No.", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Cust.Name, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Cust.Contact, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Cust.Balance, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Number);
                TmpExcelBuf.AddColumn(Cust.City, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);

            until Cust.Next() = 0;
        TempBlob.CreateOutStream(Outstrm);
        SheetName := 'Customer';
        TmpExcelBuf.CreateNewBook(SheetName);
        TmpExcelBuf.WriteSheet(SheetName, CompanyName, UserId);
        TmpExcelBuf.CloseBook();
        TmpExcelBuf.SaveToStream(Outstrm, false);

        TempBlob.CreateInStream(Instr);
        Base64String := BaseConvert.ToBase64(Instr);
        Message(Base64String);





    end;

}
