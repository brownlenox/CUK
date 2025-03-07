report 50107 "Student List -- Report"
{
    ApplicationArea = All;
    AllowScheduling = true;
    Caption = 'Student List -- Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/Students.rdl';
    PaperSourceDefaultPage = Upper;
    
    dataset
    {
        dataitem(Student; Student)
        {
            RequestFilterFields = "Student ID", "Date of Birth";
            column(StudentID; "Student ID")
            {
            }
            column(Name; Name)
            {
            }
            column(PhoneNumber; "Phone Number")
            {
            }
            column(Status; Status)
            {
            }
            column(companyName; companyInfo.Name)
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(Student_Report_Title; Student_Report_Title)
            {
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        AboutTitle = 'This is a student report';
        AboutText = 'The report contains details about the students';
        layout
        {
            area(content)
            {
                group(StudentName)
                {
                    Caption = 'Options';
                    field(Name; Student.Name)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Student';
                        ToolTip = 'Specifies the student(s)';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)

    end;

    var
        CompanyInfo: Record "Company Information";
        Student_Report_Title: Label 'Student List Report';

}
