codeunit 50106 "Export to excel codeunit"
{
    procedure ExportCustomerDataToExcel(Customer: Record Customer)
    var
        TmpExcelBuf: Record "Excel Buffer" temporary;
        Sheetname: Label 'Customer Record';
        CustomerRec: Label 'customerRecord %1 %2';
        Base64: Text;
    begin
        TmpExcelBuf.Reset();
        TmpExcelBuf.DeleteAll();

        //Headers
        TmpExcelBuf.NewRow();
        TmpExcelBuf.AddColumn(Customer.FieldCaption("No."), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption("Location Code"), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Contact), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Balance), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);

        //column data
        if Customer.FindSet() then
            repeat
                Customer.CalcFields(Balance);
                TmpExcelBuf.NewRow();
                TmpExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer."Location Code", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Contact, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Balance, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Number);
            until Customer.Next() = 0;

        TmpExcelBuf.CreateNewBook(Sheetname);
        TmpExcelBuf.WriteSheet(Sheetname, CompanyName, UserId);
        TmpExcelBuf.CloseBook();
        TmpExcelBuf.SetFriendlyFilename(StrSubstNo(CustomerRec, CurrentDateTime, UserId));
        TmpExcelBuf.OpenExcel();


    end;
}


