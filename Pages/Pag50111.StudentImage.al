page 50111 "Student Image"
{
    ApplicationArea = All;
    Caption = 'Student Image';
    PageType = CardPart;
    SourceTable = Student;

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;

                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the value of the Student Image field.';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(Import)
            {
                Image = Import;
                trigger OnAction()
                var
                    MyImage: Codeunit StudentImage;
                begin
                    MyImage.ImportNewPicture(Rec);
                end;
            }
            action(Delete)
            {
                Image = Delete;
                trigger OnAction()
                var
                    student: Record Student;

                begin
                    rec.TestField(Image);
                    rec.TestField("Student ID");
                    Clear(rec.Image);
                    rec.modify(true);
                end;
            }

            action(Export)
            {
                Image = Export;
                trigger OnAction()
                var
                    myInt: Integer;
                begin


                end;

            }
        }
    }
}
