page 50131 StudentCues
{
    ApplicationArea = All;
    Caption = 'StudentCues';
    PageType = CardPart;
    SourceTable = Student;

    layout
    {
        area(content)
        {
            cuegroup(MyFavourites)
            {
                ShowCaption = false;
                field("Fees Due"; Rec."Fees Due")
                {
                    DrillDownPageId = StudentCardPage;
                }
                field(PortfolioName; PortfolioName)
                {
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        Hyperlink('https://lenoxbrown-portfolio.netlify.app/');
                    end;
                }

            }
        }
    }

    var
        PortfolioName: Text;
}
