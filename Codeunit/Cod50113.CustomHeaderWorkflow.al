codeunit 50113 "Custom Header Workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var recref: RecordRef): Boolean
    var
        myInt: Integer;
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        exit(true);

    end;

    procedure RunWorkflowRecordForApprovalCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ''));

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendRecordForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelApprovalRecord(var RecRef: RecordRef)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorlflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::Student);
        WorlflowEventHandling.AddEventToLibrary(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::Student
        , GetDecriptionText(WorkflowSendForApprovalEventDescTxt), 0, false);

        WorlflowEventHandling.AddEventToLibrary(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), Database::Student
        , GetDecriptionText(WorkflowCancelForApprEventDescTxt), 0, false);

    end;

    local procedure GetDecriptionText(DescriptionTxt: Text[50]): Text
    begin
        exit(DescriptionTxt);
    end;

    //subscribing ot the event

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Header Workflow", 'OnSendRecordForApproval', '', false, false)]
    local procedure SendRecordForApproval(var RecRef: RecordRef)

    begin
        WorkflowMgt.HandleEvent(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Header Workflow", 'OnCancelApprovalRecord', '', false, false)]
    local procedure CancelApprovalRequest()
    var
        RecRef: RecordRef;
    begin
        WorkflowMgt.HandleEvent(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), Database::Student);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        student: record Student;
    begin
        case RecRef.Number of
            database::student:
                begin
                    RecRef.SetTable(student);
                    student.Validate(Status, student.Status::Open);
                    student.Modify(true);
                    Handled := true;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        student: record Student;
    begin
        case RecRef.number of
            database::Student:
                begin
                    RecRef.SetTable(student);
                    Variant := student;
                    student.Validate(Status, student.Status::"Pending approval");
                    student.Modify(true);
                    Variant := student;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        student: record Student;
    begin
        case RecRef.number of
            database::Student:
                begin
                    RecRef.SetTable(student);
                    ApprovalEntryArgument."Document No." := student."Student ID";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        student: record Student;
    begin
        case RecRef.Number of
            database::Student:
                begin
                    RecRef.SetTable(student);
                    student.Validate(Status, student.Status::Approved);
                    student.Modify(true);
                    Handled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        student: record Student;
    begin
        case ApprovalEntry."Table ID" of
            database::Student:
                begin
                    if student.Get(ApprovalEntry."Document No.") then begin
                        student.Validate(Status, student.Status::Rejected);
                        student.Modify(true);
                    end;
                end;

        end;
    end;

    var

        WorkflowMgt: Codeunit "Workflow Management";

        RUNWORKFLOWONSENDFORAPPROVALCODE:
                Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE:
                Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr:
                Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt:
                Label ' An Approval of %1 is requested.';
        WorkflowCancelForApprEventDescTxt:
        Label ' An Approval of %1 is cancelled.';




}
