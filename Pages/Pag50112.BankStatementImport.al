page 50112 "Bank Statement Import"
{
    ApplicationArea = All;
    Caption = 'Bank Statement Import';
    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(importbankstatement)
            {
                Caption = 'Import Bank Statement';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    filemgt: Codeunit "File Management";
                    tempfile: Text;
                begin
                    
                end;

            }
        }
    }
}
