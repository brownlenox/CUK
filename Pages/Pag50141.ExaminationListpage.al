page 50141 "Examination List page"
{
    ApplicationArea = All;
    Caption = 'Examination List page';
    PageType = List;
    SourceTable = Examination;
    UsageCategory = Lists;
    CardPageId=ExaminationCardPage;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Subject No."; Rec."Subject No.")
                {
                    ToolTip = 'Specifies the value of the Subject No. field.';
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ToolTip = 'Specifies the value of the Exam Date field.';
                }
                field("Total Marks"; Rec."Total Marks")
                {
                    ToolTip = 'Specifies the value of the Total Marks field.';
                }
            }
        }
        
    }
}
