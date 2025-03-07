page 50106 StudentCardPage
{
    ApplicationArea = All;
    Caption = 'StudentCardPage';
    PageType = Card;
    SourceTable = Student;

    layout
    {
        area(content)
        {
            group(General)
            {
                grid(MyGrid)
                {
                    group("General Info")
                    {
                        Caption = 'General';

                        field("Student ID"; Rec."Student ID")
                        {
                            ToolTip = 'Specifies the value of the Student ID field.';
                        }
                        field(Name; Rec.Name)
                        {
                            ToolTip = 'Specifies the value of the Name field.';
                        }
                        field("Large Text"; Rec."Large Text")
                        {
                            ToolTip = 'Specifies the value of the Large Text field.';

                            ShowCaption = false;
                            Caption = 'Large Text';
                            ApplicationArea = all;
                            MultiLine = true;
                            trigger OnValidate()
                            begin
                                SetLargeText(LargeText);
                            end;

                        }
                        field(CurrentStatus; Rec.CurrentStatus)
                        {
                            ToolTip = 'Specifies the value of the Status field.';
                        }
                    }
                }
                group("Other Details")
                {
                    grid(Grid2)
                    {
                        group(GridForm)
                        {
                            field("Date of Birth"; Rec."Date of Birth")
                            {
                                ToolTip = 'Specifies the value of the Date of Birth field.';
                            }
                            field("Program"; Rec."Program")
                            {
                                ToolTip = 'Specifies the value of the Program field.';
                            }
                            field("Enrollment Date"; Rec."Enrollment Date")
                            {
                                ToolTip = 'Specifies the value of the Enrollment Date field.';
                            }
                            field("Fees Due"; Rec."Fees Due")
                            {
                                ToolTip = 'Specifies the value of the Fees Due field.';
                            }
                            field("Courses Enrolled"; Rec."Courses Enrolled")
                            {
                                ToolTip = 'Specifies the value of the Courses Enrolled field.';
                            }
                            field("Phone Number"; Rec."Phone Number")
                            {
                                ToolTip = 'Specifies the value of the Phone Number field.';
                            }
                            field(email; Rec.Email)
                            {
                                ToolTip = 'Specifies the value of the Email field.';
                            }
                            field(Status; Rec.Status)
                            {
                                ToolTip = 'Specifies the value of the Status field.';
                            }

                        }
                    }
                }


            }
        }


        area(FactBoxes)
        {
            part(MyImage; "Student Image")
            {
                SubPageLink = "Student ID" = field("Student ID");
                ApplicationArea = all;
            }
            part(StudentId; StudentCues)
            {
                ApplicationArea = all;
            }
            systempart(Links; Links)
            {
                ApplicationArea = all;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
            }
        }


    }
    actions
    {
        area(Processing)
        {
            action(SaveReportAsEncodedText)
            {
                Caption = 'Save Student Report as Encoded Text';
                Image = Action;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    BaseConvert: Codeunit "Base64 Convert";
                    InStr: InStream;
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    FldRef: FieldRef;
                    TempBlob: Codeunit "Temp Blob";
                begin
                    if Rec.Get(Rec."Student ID", Rec.Name) then begin
                        RecRef.GetTable(Rec);
                        FldRef := RecRef.Field(Rec.FieldNo("Student ID"));
                        FldRef.SetRange(Rec."Student ID");
                        TempBlob.CreateOutStream(OutStr);
                        Report.SaveAs(Report::"Student List -- Report", '', ReportFormat::Pdf, OutStr, RecRef);
                        TempBlob.CreateInStream(InStr);
                        LargeText := BaseConvert.ToBase64(InStr, false);
                        SetLargeText(LargeText);

                    end else
                        Error('%1 of admission %2 does not exist.', rec.Name, rec."Student ID");

                end;
            }
            group("Approval Requests")
            {
                caption = 'Send Approval Requests';
                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Requests';
                    ApplicationArea = basic, suite;
                    Image = SendApprovalRequest;
                    Tooltip = 'Request approval for the student.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = Not OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        Conversion: Codeunit conversion;

                    begin
                        RecRef.GetTable(Rec);
                        if Conversion.CheckApprovalsWorkflowEnabled(RecRef) then
                            Conversion.OnSendForApproval(RecRef);
                        currpage.close

                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Re-Open';
                    ApplicationArea = basic, suite;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CanCancelApprovalForRecord;

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        Conversion: Codeunit conversion;

                    begin
                        RecRef.GetTable(Rec);
                        Conversion.OnCancelApproval(RecRef);

                    end;
                }
            }
        }
        area(Creation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;

                    PromotedCategory = New;


                    trigger OnAction()
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View approval requests.';
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }

    }
    var
        LargeText: Text;

    trigger OnAfterGetRecord()
    begin
        LargeText := GetLargeText();

    end;

    procedure SetLargeText(NewLargeText: Text)
    var
        OutStr: OutStream;
    begin
        Rec.Get(Rec.Name, Rec."Student ID");
        Rec."Large Text".CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(LargeText);
        Rec.Modify();

    end;

    procedure GetLargeText() NewLargeTetx: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStr: InStream;
    begin
        Rec.CalcFields("Large Text");
        Rec."Large Text".CreateInStream(InStr, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStr, TypeHelper.LFSeparator(), Rec.FieldName("Large Text")));

    end;


    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        HasApprovalEntries := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
    end;

    var
        OpenApprovalEntriesExistCurrUser, OpenApprovalEntriesExist, CanCancelApprovalForRecord
        , HasApprovalEntries : Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}
