table 50101 Course
{
    Caption = 'Course';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Course ID"; Code[10])
        {
            Caption = 'Course ID';
            TableRelation = Student."Student ID";
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(333; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(2; "Course Name"; Text[100])
        {
            Caption = 'Course Name';

        }
        field(3; Credits; Decimal)
        {
            Caption = 'Credits';
        }
        field(4; Instructor; Text[50])
        {
            Caption = 'Instructor';
            TableRelation = Staff.Name;
        }
        field(5; Schedule; Text[50])
        {
            Caption = 'Schedule';
        }
        field(6; "Enrollment Cap"; Integer)
        {
            Caption = 'Enrollment Cap';
        }
        field(7; Department; Text[50])
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
        }
        field(8; Picture; MediaSet)
        {
            Caption = 'documents';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Course ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if rec."Course ID" = '' then begin
            NoSeriesMgt.InitSeries('BUCU', xRec."No. Series", 0D, "Course ID", "No. Series");
        end;

    end;
}