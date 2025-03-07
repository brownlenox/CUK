permissionset 50100 "Cooperative Uni"
{
    Assignable = true;
    Caption = 'Cooperative Uni', MaxLength = 30;
    Permissions =
        table Fee = X,
        tabledata Fee = RMID,
        table Faculty = X,
        tabledata Faculty = RMID,
        table Course = X,
        tabledata Course = RMID,
        table Student = X,
        tabledata Student = RMID,
        codeunit SegmentComputation = X,
        codeunit OnPhoneNumberChange = X,
        codeunit CreditLimit = X,
        page StudentListPage = X,
        page StudentCardPage = X,
        report "Student List -- Report" = X;
}
