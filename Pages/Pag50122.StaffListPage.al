page 50122 "Staff List Page"
{
    ApplicationArea = All;
    Caption = 'Staff List Page';
    PageType = List;
    SourceTable = staff;
    UsageCategory = Lists;
    CardPageId = "Staff Card Page";
    Editable = false;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Phone; Rec.Phone)
                {

                }

            }
        }
    }
}
