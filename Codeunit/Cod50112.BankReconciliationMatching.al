codeunit 50112 "Bank Reconciliation Automation"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        AutoMatchBankTransactions();
    end;

    local procedure AutoMatchBankTransactions()
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankStatementLine: Record "Bank Statement Line";
        BankAccLedgerEntry: Record "Bank Account Ledger Entry";
        MatchTolerance: Decimal;
    begin
        MatchTolerance := 1.00; // Set a tolerance value for matching

        BankAccReconciliation.Reset();
        if BankAccReconciliation.FindSet() then
            repeat
                BankStatementLine.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
                if BankStatementLine.FindSet() then
                    repeat
                        if BankAccLedgerEntry.FindFirst() then begin
                            BankAccLedgerEntry.SetRange("Bank Account No.", BankStatementLine."Bank Account No.");
                            BankAccLedgerEntry.SetRange("Amount", BankStatementLine.Amount, BankStatementLine.Amount + MatchTolerance);

                            if BankAccLedgerEntry.FindFirst() then begin
                                BankStatementLine."Matched" := true;
                                BankStatementLine.Modify();
                            end;
                        end;
                    until BankStatementLine.Next() = 0;
            until BankAccReconciliation.Next() = 0;
    end;
}

