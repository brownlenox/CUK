codeunit 50108 Conversion
{
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowMgt: Codeunit "Workflow Management";
        WorkflowRspHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        RUNWORKFLOWONSENDFORAPPROVALCODE:
                Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE:
                Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr:
                Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt:
                Label 'Approval of %1 is requested.';
        WorkflowCancelForApprovalEventDescTxt:
                Label 'Approval of %1 is canceled.';

    procedure CheckApprovalsWorkflowEnabled(RecRef: RecordRef): Boolean
    var
        myInt: Integer;
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, RunWorkflowForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, Recref)) then begin
            Error(NoWorkflowEnabledErr);
            exit(true);
        end

    end;

    Procedure RunWorkflowForApprovalCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ''))
    end;



    [IntegrationEvent(false, false)]
    procedure OnSendForApproval(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelApproval(RecRef: RecordRef)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        Student: record Student;
    begin
        recref.Open(Database::Student);
        //RecRef.SetTable(student);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, recref), Database::Student,
        WorkflowDescription(WorkflowSendForApprovalEventDescTxt, Recref), 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, recref), Database::Student,
        WorkflowDescription(WorkflowCancelForApprovalEventDescTxt, Recref), 0, false);

    end;

    procedure WorkflowDescription(workflowDesc: text; RecRef: recordref): Text
    var
        myInt: Integer;
    begin
        exit(StrSubstNo(workflowDesc, RecRef.Name))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Conversion, 'OnSendForApproval', '', false, false)]
    local procedure RunWorkflowOnSendForApproval(RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Conversion, 'OnCancelApproval', '', false, false)]
    local procedure RunWorkflowOnCancelForApproval(RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Student: Record student;
    begin
        case
            RecRef.Number of
            Database::Student:
                begin
                    RecRef.SetTable(Student);
                    Student.Validate(CurrentStatus, Student.CurrentStatus::Open);
                    Student.Modify(true);
                    Handled := true;
                end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Student: Record student;
    begin
        case
            RecRef.Number of
            Database::Student:
                begin
                    RecRef.SetTable(Student);
                    Student.Validate(CurrentStatus, Student.CurrentStatus::"Pending Approvals");
                    Student.Modify(true);
                    Variant := Student;
                    Ishandled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Student: Record Student;
    begin
        case
            RecRef.Number of
            Database::Student:
                begin
                    RecRef.SetTable(Student);
                    ApprovalEntryArgument."Document No." := Student."Student ID";
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Student: Record Student;
    begin
        case
            RecRef.Number of
            Database::Student:
                begin
                    RecRef.SetTable(Student);
                    Student.Validate(CurrentStatus, Student.CurrentStatus::Released);
                    Student.modify(true);
                    Handled := true;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        Student: Record Student;
        RecRef: RecordRef;
    begin
        case
            RecRef.Number of
            Database::Student:
                begin
                    if student.Get(ApprovalEntry."Document No.") then begin
                        Student.Validate(CurrentStatus, Student.CurrentStatus::Rejected);
                        Student.modify(true);
                    end;
                end;
        end;

    end;


}
