page 50107 StudentListCues
{
    ApplicationArea = All;
    Caption = 'StudentListCues';
    PageType = CardPart;
    SourceTable = Student;

    layout
    {
        area(content)
        {


            field("Student ID"; Rec."Student ID")
            {
                trigger OnDrillDown()
                begin
                    Page.Run(Page::StudentCardPage);
                end;
            }
            cuegroup(Control1)
            {
                ShowCaption = false;
                field("Fees Due"; Rec."Fees Due")
                {
                    ToolTip = 'Specifies the value of the Fees Due field.';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::StudentCardPage);
                    end;

                }
            }

        }
    }
}
