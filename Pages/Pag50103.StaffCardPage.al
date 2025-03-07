page 50103 "Staff Card Page"
{
    ApplicationArea = All;
    Caption = 'Staff Card Page';
    PageType = Card;
    SourceTable = Staff;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';

                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(Phone; Rec.Phone)
                {
                    ToolTip = 'Specifies the value of the Phone field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the email field.';
                }
            }
        }
    }
}
