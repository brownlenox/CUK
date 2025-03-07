codeunit 50104 GradeCaculations
{
    procedure GradeComputations(): Text
    var
        Examination: Record Examination;
    begin
        Examination.Reset();
        if Examination.Get() then begin
            if Examination."Marks Obtained" > 40 then begin
                Examination.Grade := 'D';
                Examination.Insert(true);
                Examination.Modify()
            end;

        end;

    end;

}
