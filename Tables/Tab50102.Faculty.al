table 50102 Faculty
{
    Caption = 'Faculty';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Faculty ID"; Code[10])
        {
            Caption = 'Faculty ID';
        }
        field(2; Name; TableFilter)
        {
            Caption = 'Name';
        }
        field(3; Department; Text[50])
        {
            Caption = 'Department';
        }
        field(4; "Courses Assigned"; Text[100])
        {
            Caption = 'Courses Assigned';
        }
        field(5; Salary; Decimal)
        {
            Caption = 'Salary';
        }
        field(6; "Date of Hire"; Date)
        {
            Caption = 'Date of Hire';
        }
    }
    keys
    {
        key(PK; "Faculty ID")
        {
            Clustered = true;
        }
    }
}
