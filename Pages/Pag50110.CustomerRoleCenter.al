
page 50110 "Customer Role Center"
{
    PageType = RoleCenter;
    Caption = 'Customer Role Center';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; StudentRoleCenterHeadlinePart)
            {
                ApplicationArea = Basic, Suite;
            }
            // part(Activities; "AppName Activities")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part("Help And Chart Wrapper"; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("CustomerCard")
            {
                RunPageMode = Create;
                Caption = 'CustomerCard';
                ToolTip = 'CustomerCard';
                Image = New;
                RunObject = page "Customer Card";
                ApplicationArea = Basic, Suite;
            }
        }
        area(Processing)
        {
            group(New)
            {
                action("General Ledger Entries")
                {
                    RunPageMode = Create;
                    Caption = 'General Ledger Entries';
                    ToolTip = 'General Ledger Entries';
                    RunObject = page "General Ledger Entries";
                    Image = DataEntry;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Item Jnl.-Posting")
            {
                action("Item Jnl.-Post")
                {
                    Caption = 'AppNameSomeProcess';
                    ToolTip = 'AppNameSomeProcess description';
                    Image = Process;
                    RunObject = Codeunit "Item Jnl.-Post";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Customer Reports")
            {
                action("Customer - List")
                {
                    Caption = 'AppNameSomeReport';
                    ToolTip = 'AppNameSomeReport description';
                    Image = Report;
                    RunObject = report "Customer - List";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(Reporting)
        {
            action("Item Price List")
            {
                Caption = 'AppNameSomeReport';
                ToolTip = 'AppNameSomeReport description';
                Image = Report;
                RunObject = report "Item Price List";

                ApplicationArea = Basic, Suite;
            }

        }
        area(Embedding)
        {
            action("Chart of Accounts")
            {
                RunObject = page "Chart of Accounts";
                ApplicationArea = Basic, Suite;
            }

        }
        area(Sections)
        {
            group(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Setup;

                action("Sales Order")
                {
                    ToolTip = 'Setup AppName';
                    RunObject = Page "Sales Order";
                    ApplicationArea = Basic, Suite;

                }

                action("Assisted Setup")
                {
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    RunObject = Page "Assisted Setup";
                    ApplicationArea = Basic, Suite;
                }
                action("Vendor Card")
                {
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                    RunObject = Page "Vendor Card";
                    ApplicationArea = Basic, Suite;
                }
                action("Service Connections")
                {
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    RunObject = Page "Service Connections";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

}


