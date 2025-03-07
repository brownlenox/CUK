table 50104 "Bank Statement Line"
{
    Caption = 'Bank Statement Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
        }
        field(3; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; Matched; Boolean)
        {
            Caption = 'Matched';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
