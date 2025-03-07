pageextension 50103 BankRecExt extends "Bank Acc. Reconciliation"
{
    actions
    {
        addfirst(processing)
        {
            action(AutoMatch)
            {
                Caption = 'Auto Match Transactions';
                Image = Match;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    BankRecCodeunit: Codeunit "Bank Reconciliation Automation";
                begin
                    BankRecCodeunit.Run();
                    Message('Bank Transactions matched successfully!');
                end;
            }
        }
    }
}
