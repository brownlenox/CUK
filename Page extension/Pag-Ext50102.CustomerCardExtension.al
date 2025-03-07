pageextension 50102 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(Segment; Rec.Segment)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast("Request Approval")
        {
            action(AdjustCreditLimit)
            {
                ApplicationArea = All;
                Caption = 'Adjust Credit Limit';
                Image = CreditMemo;

                trigger OnAction()
                var
                    AdjustCreditLimitCodeUnit: Codeunit CreditLimit;
                begin
                    AdjustCreditLimitCodeUnit.AdjustCustomerCreditLimit(Rec);
                end;
            }

        }
        addlast(processing)
        {
            action(json)
            {
                ApplicationArea = All;
                Caption = 'json';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ConfirmMessage: Label 'Do you want to download?';
                    ConfirmElseMsg: Label 'No problem';
                begin
                    if Confirm(ConfirmMessage) then
                        jsonconvert(Rec)
                    else
                        Message(ConfirmElseMsg);

                end;
            }
        }
    }
    
    local procedure jsonconvert(Cust: Record Customer)
    var
        myInt: Integer;
        CustObj: JsonObject;
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustObjArray: JsonArray;
        LedgerEntr: JsonObject;
        LocationArr: JsonArray;
        LocationObj: JsonObject;
        TempBlob: Codeunit "Temp Blob";
        OutStr: Outstream;
        InStr: InStream;
        Result: Text;
        ToFileName: Text;
    begin
        ToFileName := 'My Data';
        Clear(CustObj);
        CustObj.Add('CustomerNo', Cust."No.");
        CustObj.Add('CustomerName', Cust.Name);
        CustObj.Add('Email', Cust."E-Mail");
        CustObj.Add('SecondName', Cust."Search Name");

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer Name", Cust."No.");
        if CustLedgEntry.FindSet() then
            repeat
                Clear(LedgerEntr);
                CustLedgEntry.CalcFields(Amount);
                LedgerEntr.Add('DocumentNo', CustLedgEntry."Document No.");
                LedgerEntr.Add('postingdate', CustLedgEntry."Posting Date");
                LedgerEntr.Add('Description', CustLedgEntry.Description);
                LedgerEntr.Add('Amount', CustLedgEntry.Amount);

                CustObjArray.Add(LedgerEntr);

                Clear(LocationObj);
                LocationObj.Add('Adress', Cust.Address);
                LocationObj.Add('Adress2', cust."Address 2");
                LocationObj.Add('City', Cust.City);
                LocationObj.Add('Country', Cust."Country/Region Code");
                LocationArr.Add(LocationObj);
                CustObj.Add('Location', LocationArr);
            until CustLedgEntry.Next() = 0;

        CustObj.Add('Ledger Entry', CustObjArray);


        //downloading
        TempBlob.CreateOutStream(OutStr);
        TempBlob.CreateInStream(InStr);
        CustObj.WriteTo(OutStr);
        OutStr.WriteText(Result);
        InStr.ReadText(Result);

        DownloadFromStream(InStr, 'Download json file', '', 'All files(*.*)|*.*', ToFileName)

    end;

}