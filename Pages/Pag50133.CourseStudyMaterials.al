page 50133 "Course Study Materials"
{
    Caption = 'Course Study Materials';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Course;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture or document uploaded for the course.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take Picture';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';

                trigger OnAction()
                begin
                    if Camera.IsAvailable() then
                        TakeNewPicture()
                    else
                        Message('Camera is not available on this device.');
                end;
            }

            action(ImportDocument)
            {
                ApplicationArea = All;
                Caption = 'Import Document';
                Image = Import;
                ToolTip = 'Import a picture or document file.';

                trigger OnAction()
                begin
                    ImportFromDevice();
                end;
            }
            action(ExportDocument)
            {
                ApplicationArea = all;
                Caption = 'Export Document';
                Image = Export;
                ToolTip = 'Export the uploaded picture or document to a file';
                Enabled = isvalue;

                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    filename: Text;
                    instr: InStream;
                    Outstr: OutStream;
                begin
                    rec.TestField("Course ID");
                    if rec.Picture.Count > 0 then
                        if not Confirm('Do you want to download?') then
                            exit;
                    TempBlob.CreateOutStream(Outstr);
                    //rec.Picture.ExportFile()

                end;
            }

            action(DeleteDocument)
            {
                ApplicationArea = All;
                Caption = 'Delete Document';
                Image = Delete;
                ToolTip = 'Delete the uploaded document or picture.';
                Enabled = isvalue;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to delete the document?', false) then
                        DeletePicture();
                end;
            }
        }
    }

    var
        Camera: Codeunit "Camera";
        isvalue: Boolean;
        OverrideImageQst: Label 'The existing picture or document will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture or document?';
        MustSpecifyDescriptionErr: Label 'You must specify a course ID before uploading a document.';

    trigger OnAfterGetCurrRecord()
    begin
        confirmation();
    end;

    local procedure confirmation()
    begin
        isvalue := rec.Picture.Count > 0;
    end;

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        ClientFileName: Text;
    begin
        // Ensure Course ID is specified before importing the document
        Rec.TestField(Rec."Course ID");

        // Confirm before overriding an existing document
        if Rec.Picture.Count > 0 then
            if not Confirm('The existing picture or document will be replaced. Do you want to continue?') then
                exit;

        // Use BLOBImport to import file to TempBlob
        ClientFileName := FileManagement.BLOBImport(TempBlob, 'Select a document to upload');

        if ClientFileName <> '' then begin
            Clear(rec.Picture);
            // Get InStream from TempBlob to import to MediaSet
            TempBlob.CreateInStream(Instr);

            // Import the file into the MediaSet field
            Rec.Picture.ImportStream(Instr, ClientFileName);
            Rec.Modify(true);

            // Notify user about the successful import
            Message('Document "%1" imported successfully.', ClientFileName);
        end else begin
            Message('Import operation was canceled or failed.');
        end;
    end;



    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField(Rec."Course ID");

        if Rec.Picture.Count > 0 then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            clear(Rec.Picture);
            Rec.Picture.ImportStream(PictureInstream, PictureDescription);
            Rec.Modify(true);
            Message('Picture taken and added successfully.');
        end;
    end;

    procedure ExportToClient()
    var
        FileName: Text;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        instr: InStream;
    begin
        // generating  a temporary file path
        Rec.TestField(Rec.Picture);
        TempBlob.CreateOutStream(OutStr);
        //Rec.Picture.ExportFile(OutStr);

        FileName := 'ExportedDocument_' + Format(Rec."Course ID") + '.jpg'; // Adjust the extension if needed
        DownloadFromStream(instr, '', '', '', FileName);
        Message('Document "%1" exported successfully.', FileName);
    end;

    procedure DeletePicture()
    begin
        Rec.TestField(Rec."Course ID");
        Rec.TestField(Rec.Picture);

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Picture);
        Rec.Modify(true);
        Message('Document deleted successfully.');
    end;
}
