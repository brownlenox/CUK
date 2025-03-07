page 50101 CourseListPage
{
    ApplicationArea = All;
    Caption = 'CourseListPage';
    PageType = List;
    SourceTable = Course;
    UsageCategory = Lists;
    CardPageId = "Course Card  Page";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Course ID"; Rec."Course ID")
                {
                    ToolTip = 'Specifies the value of the Course ID field.';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ToolTip = 'Specifies the value of the Course Name field.';
                }
                field(Credits; Rec.Credits)
                {
                    ToolTip = 'Specifies the value of the Credits field.';
                }
                field(Instructor; Rec.Instructor)
                {
                    TableRelation = Staff.Name;
                    ToolTip = 'Specifies the value of the Instructor field.';
                }
            }
        }
    }
}
