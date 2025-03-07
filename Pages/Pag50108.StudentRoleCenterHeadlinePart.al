page 50108 StudentRoleCenterHeadlinePart
{
    ApplicationArea = All;
    Caption = 'StudentRoleCenterHeadlinePart';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(greetings)
            {
                ShowCaption = false;
                field(greeting; RCHeadlinesPageCommon.GetGreetingText())
                {

                    Editable = false;


                }
                field(fee; StrSubstNo(HighestFee, HighestFeePaid()))
                {
                    DrillDown = true;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Fee: Record Fee;
                    begin
                        fee.Reset();
                        fee.SetCurrentKey(Amount);
                        fee.Ascending(false);
                        if fee.FindFirst() then
                            page.Run(page::FeeListPage, Fee);
                    end;
                }
                field(users; StrSubstNo(CurrentUsers, ActiveUsers()))
                {
                    DrillDown = true;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin
                        page.Run(page::"Concurrent Session List");

                    end;

                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Isgreeting := RCHeadlinesPageCommon.IsUserGreetingVisible();
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::StudentRoleCenterHeadlinePart);

    end;

    var
        Isgreeting: Boolean;
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
        HighestFee: Label '<qualifier>Highest fee paid was </qualifier><payload>The highest fee <emphasize>%1</emphasize></payload>';
        CurrentUsers: Label '<qualifier>Current active users </qualifier><payload>Current users <emphasize>%1</emphasize></payload>';


    local procedure HighestFeePaid(): Decimal
    var
        Fee: Record Fee;
    begin
        fee.Reset();
        fee.SetCurrentKey(Amount);
        fee.Ascending(false);
        if fee.FindFirst() then
            exit(Fee.Amount);


    end;

    local procedure ActiveUsers(): Integer
    var
        ActiveSession: Record "Active Session";
    begin
        ActiveSession.Reset();
        ActiveSession.SetRange("Client Type", ActiveSession."Client Type"::"Web Client");
        exit(ActiveSession.Count);
    end;



}
