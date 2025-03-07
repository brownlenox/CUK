table 50140 Examination
{
    Caption = 'Examination';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Student;
        }
        field(3; "Subject No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Course."Course ID";
        }
        field(4; "Exam Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Total Marks"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Marks Obtained"; Integer)
        {

            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Marks Obtained" > 100 then
                    Error('Marks cannot be greater than 100')
                else
                    if "Marks Obtained" >= 80 then
                        Grade := Grade::A
                    else
                        if "Marks Obtained" >= 70 then
                            Grade := Grade::B
                        else
                            if "Marks Obtained" >= 60 then
                                Grade := Grade::C
                            else
                                if "Marks Obtained" >= 50 then
                                    Grade := Grade::D
                                else
                                    if "Marks Obtained" < 0 then
                                        Error('Marks cannot be less than 0')
                                    else
                                        Grade := Grade::Supplementary

            end;

        }
        field(7; "Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            //CalcFormula = Round((Marks Obtained / Total Marks) * 100, 1);

        }
        field(8; "Grade"; option)
        {
            OptionMembers = ,A,B,C,D,Supplementary;
            Editable = false;
            // You can use a lookup table or a calculated field based on the percentage to determine the grade.
        }
        field(9; "Exam Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Midterm,Final,Quiz';
            OptionMembers = Midterm,Final,Quiz;
        }
        field(10; "Exam Term"; Code[20])
        {
            DataClassification = CustomerContent;
            //TableRelation = "Exam Term"."Code";
        }
        field(11; "Exam Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        { }
    }
    trigger OnModify()
    var
        GradeCaculations: Codeunit GradeCaculations;
    begin
        GradeCaculations.GradeComputations();
    end;
}