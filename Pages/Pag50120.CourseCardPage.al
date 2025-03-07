page 50120 "Course Card  Page"
{
    Caption = 'Course Card  Page';
    PageType = Card;
    SourceTable = Course;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group("Course Name Section")
            {
                Caption = 'General';
                field("Course ID"; Rec."Course ID")
                {
                    ToolTip = 'Specifies the value of the Course ID field.';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ToolTip = 'Specifies the value of the Course Name field.';
                }

            }
            group("Course Details")
            {
                field(Credits; Rec.Credits)
                {
                    ToolTip = 'Specifies the value of the Credits field.';
                }
                field(Instructor; Rec.Instructor)
                {
                    ToolTip = 'Specifies the value of the Instructor field.';
                }
            }

            part(Line; "Student List Part")
            {
                ApplicationArea = all;
            }
        }
        area(FactBoxes)
        {
            part(StudyMateraials; "Course Study Materials")
            {
                ApplicationArea = all;
                SubPageLink = "Course ID" = field("Course ID");

            }

            systempart(Links; Links)
            {
                ApplicationArea = all;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
            }
        }
    }
}
