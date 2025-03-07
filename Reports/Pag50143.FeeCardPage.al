page 50143 "Fee Card Page"
{
    ApplicationArea = All;
    Caption = 'Fee Card Page';
    PageType = Card;
    SourceTable = Fee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Student ID"; Rec."Student ID")
                {
                    ToolTip = 'Specifies the value of the Student ID field.';
                }
                field("Fee Type"; Rec."Fee Type")
                {
                    ToolTip = 'Specifies the value of the Fee Type field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
