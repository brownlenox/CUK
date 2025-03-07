page 50130 "Student List Part"
{
    ApplicationArea = All;
    Caption = 'Student List Part';
    PageType = ListPart;
    SourceTable = Student;
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student ID"; Rec."Student ID")
                {
                    ToolTip = 'Specifies the value of the Student ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                }
                field("Program"; Rec."Program")
                {
                    ToolTip = 'Specifies the value of the Program field.';
                }
                field("Enrollment Date"; Rec."Enrollment Date")
                {
                    ToolTip = 'Specifies the value of the Enrollment Date field.';
                }
                field("Fees Due"; Rec."Fees Due")
                {
                    ToolTip = 'Specifies the value of the Fees Due field.';
                }
                field("Courses Enrolled"; Rec."Courses Enrolled")
                {
                    ToolTip = 'Specifies the value of the Courses Enrolled field.';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
