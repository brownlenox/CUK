pageextension 50101 "Customer List Extension" extends "Customer List"
{
    actions
    {
        addfirst("&Customer")
        {
            action(ExportExcelData)
            {
                Caption = 'Customer list encoded in base64';
                Image = Export;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ConvertToBaese: Codeunit ConvertToBaese64;
                begin
                    ConvertToBaese.ConvertExcelToBase64();

                end;

            }
        }
    }
}
