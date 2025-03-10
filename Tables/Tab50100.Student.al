table 50100 Student
{
    Caption = 'Student';
    DataClassification = ToBeClassified;
    DrillDownPageId = StudentListPage;
    LookupPageId = StudentListPage;

    fields
    {
        field(1; "Student ID"; Code[50])
        {
            Caption = 'Student ID';
            Editable = false;
        }
        field(333; "No. Series"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            trigger OnValidate()
            var
                CurrentDate: Date;
                MinimumAgeDate: Date;
                ErrorMessages: Label 'You must be 18 years and above to apply.';
            begin
                CurrentDate := Today();
                MinimumAgeDate := CalcDate('<-18Y>', MinimumAgeDate);
                if "Date of Birth" > MinimumAgeDate then
                    Error(ErrorMessages);
            end;
        }
        field(4; "Program"; Text[100])
        {
            Caption = 'Program';
        }
        field(5; "Enrollment Date"; Date)
        {
            Caption = 'Enrollment Date';
        }
        field(6; "Fees Due"; Decimal)
        {
            Caption = 'Fees Due';
            AutoFormatType = 1;
            DecimalPlaces = 2;
        }
        field(7; "Courses Enrolled"; Text[100])
        {
            Caption = 'Courses Enrolled';
            TableRelation = Course;
        }
        field(8; "Phone Number"; Code[20])
        {
            Caption = 'Phone Number';
            trigger OnValidate()
            var
                publisher: Codeunit OnPhoneNumberChange;
            begin
                publisher.OnPhoneNumberChangeProcedure(Rec."Phone Number");

            end;
        }
        field(9; Status; Enum AcademicProgressStatus)
        {
            Caption = 'Status';
            Editable = false;
        }
        field(10; Image; Media)
        {
            Caption = 'Student Image';
            DataClassification = ToBeClassified;
        }
        field(11; "Large Text"; Blob)
        {
            Caption = 'Large Text';
            DataClassification = ToBeClassified;
        }
        field(12; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var

                Regex: Codeunit Regex;
                IsMatch: Boolean;
                pattern: Text[100];
                ErrorMessage: Label 'The email %1 entered is not a valid email address.';
            begin
                pattern := '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                IsMatch := Regex.IsMatch(Email, pattern);

                if not IsMatch then
                    Error(StrSubstNo(ErrorMessage, Email));

            end;

        }
        field(13; CurrentStatus; Enum "Custom Approvals")
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Student ID", Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(dropdown; "Student ID", Name, "Date of Birth", Program, "Enrollment Date", "Fees Due", "Courses Enrolled", "Phone Number", Status)
        { }
    }
    trigger OnInsert()
    var
        noseries: Codeunit NoSeriesManagement;
    begin
        if rec."Student ID" = '' then begin
            noseries.InitSeries('BSSEC', xRec."No. Series", 0D, "Student ID", "No. Series");
        end;

    end;
}
