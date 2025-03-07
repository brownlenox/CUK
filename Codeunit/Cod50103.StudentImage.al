codeunit 50103 StudentImage
{
    procedure ImportNewPicture(Student: Record Student)
    var
        File_Pic: Text;
        Inst_Pic: InStream;
        OverrideImageLabel: Label 'Do you wish to override?';
    begin
        if Student.Image.HasValue then begin
            if not Confirm(OverrideImageLabel) then
                exit;
        end;
        if File.UploadIntoStream('Import Picture', '', 'All files(*.*)|*.*', File_Pic, Inst_Pic) then begin
            Student.Image.ImportStream(Inst_Pic, File_Pic);
            Student.Modify(true)
        end;

    end;

}
