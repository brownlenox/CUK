table 50103 Fee
{
    Caption = 'Fee';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student ID"; code[20])
        {
            Caption = 'Student ID';
            TableRelation = Student."Student ID";
        }
        field(2; "Fee Type"; Option)
        {
            OptionMembers = Tuition,Registration,LabFee,Other;
            Caption = 'Fee Type';
        }
        field(3; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(4; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(PK; "Student ID", "Fee Type", "Due Date")
        {
            Clustered = true;
        }
    }
}
