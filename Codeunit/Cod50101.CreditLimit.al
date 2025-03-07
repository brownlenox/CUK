codeunit 50101 CreditLimit
{
    //[InherentPermissions(PermissionObjectType::TableData, Database::Student, 'r', InherentPermissionsScope::Both)]
    procedure AdjustCustomerCreditLimit(Customer: Record Customer)
    var
        NewCreditLimit: Decimal;
        EXistancrOfSalesHistory: Boolean;
    begin
        //Calc new credit limit
        NewCreditLimit := CalculateCreditLimit(Customer);

        //Checking if credit limit is same as the current
        if NewCreditLimit = Customer."Credit Limit (LCY)" then begin
            Message('The new credit limit is same as the current credit limit.');
            exit;
        end;

        //user dialog (confirm)
        if NewCreditLimit > Customer."Credit Limit (LCY)" then begin
            if not Confirm('The new credit limit is higher. Do you want to proceed?') then
                exit;
        end;

        //updating credit limit
        UpdateCreditLimit(Customer, NewCreditLimit);
    end;

    procedure CalculateCreditLimit(Customer: Record Customer): Decimal
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TotalSales: Decimal;
        NewCreditLimit: Decimal;
        IsRoundingNeeded: Boolean;
    begin
        //Finding the sales for the last 12 months
        SalesInvoiceHeader.SetRange("Bill-to Customer No.", Customer."No.");
        SalesInvoiceHeader.SetRange("Posting Date", CalcDate('<-1Y>', Today), Today);

        if SalesInvoiceHeader.FindSet then begin
            TotalSales := 0;
            repeat
                TotalSales += SalesInvoiceHeader."Amount Including VAT";
            until SalesInvoiceHeader.Next = 0;

            NewCreditLimit := TotalSales * 0.5;
        end else begin
            //Resetting to zero
            NewCreditLimit := 0;
        end;

        //To the nearest 10,000
        if NewCreditLimit <> ROUND(NewCreditLimit, 10000, '>') then begin
            NewCreditLimit := ROUND(NewCreditLimit, 10000, '>');
            IsRoundingNeeded := true;
        end;

        //Notify if credt limit was rounded
        if IsRoundingNeeded then
            Message('The credit limit as been rounded to the nearest 10,000.');
        exit(NewCreditLimit);

    end;

    procedure UpdateCreditLimit(Customer: Record Customer; NewCreditLimit: Decimal)
    begin
        Customer."Credit Limit (LCY)" := NewCreditLimit;
        Customer.Modify(true);
        Message('The credit limit for %1 has been updated to %2', Customer.Name, Format(NewCreditLimit, 0, 2));
    end;
}
