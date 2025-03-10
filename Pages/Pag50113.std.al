page 50113 std
{
    ApplicationArea = All;
    Caption = 'std';
    PageType = List;
    SourceTable = Student;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Courses Enrolled"; Rec."Courses Enrolled")
                {
                    ToolTip = 'Specifies the value of the Courses Enrolled field.';
                }
                field(CurrentStatus; Rec.CurrentStatus)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    
}
