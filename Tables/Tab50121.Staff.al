table 50121 Staff
{
    Caption = 'Staff';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Staff List Page";
    LookupPageId = "Staff List Page";

    fields
    {
        field(1; "Staff ID"; Code[20])
        {
            Caption = 'Staff ID';
            Editable = false;
        }
        field(333; "No series"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Department; enum "Department Enums")
        {
            Caption = 'Department';
        }
        field(4; Designation; Option)
        {
            Caption = 'Designation';
            OptionMembers = DR,Professor,Mr;
        }
        field(5; Phone; Code[100])
        {
            Caption = 'Phone';
            trigger OnValidate()
            var
                OnPhoneNoChg: Codeunit OnPhoneNumberChange;
            begin
                OnPhoneNoChg.OnPhoneNumberChangeProcedure(Rec.Phone);
            end;
        }
        field(6; StaffImage; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Email; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Regex: Codeunit Regex;
                ismatch: Boolean;
                pattern: Text;
                myInt: Integer;
                errorMessage: label 'The %1 email entered is not a a valid email address';
            begin
                pattern := '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                ismatch := Regex.IsMatch(Email, pattern);

                if not ismatch then
                    Error(StrSubstNo(errorMessage, Email));



            end;
        }
    }

    keys
    {
        key(PK; "Staff ID", Name)
        {
        }

    }
    fieldgroups
    {
        fieldgroup(dropdown; "Staff ID", Name, Department, Designation, Phone)
        {
        }
        fieldgroup(brick; "Staff ID", Name, Department, Designation, Phone)
        {
        }
    }
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if rec."Staff ID" = '' then
            NoSeriesMgt.InitSeries('STAFF', xRec."No series", 0D, "Staff ID", "No series");

    end;
}
