page 50102 ExaminationCardPage
{
    ApplicationArea = All;
    Caption = 'ExaminationCardPage';
    PageType = Card;
    SourceTable = Examination;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
            }
            group(marks)
            {
                field("Total Marks"; Rec."Total Marks")
                {
                    ToolTip = 'Specifies the value of the Total Marks field.';
                }
                field("Marks Obtained"; Rec."Marks Obtained")
                {
                    ToolTip = 'Specifies the value of the Marks Obtained field.';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
            }
            group("exam time")
            {
                field("Exam Type"; Rec."Exam Type")
                {
                    ToolTip = 'Specifies the value of the Exam Type field.';
                }
                field("Exam Term"; Rec."Exam Term")
                {
                    ToolTip = 'Specifies the value of the Exam Term field.';
                }
                field("Exam Year"; Rec."Exam Year")
                {
                    ToolTip = 'Specifies the value of the Exam Year field.';
                }
            }



        }
    }
}
