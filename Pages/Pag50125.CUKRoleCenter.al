page 50125 CUKRolecenter
{
    PageType = RoleCenter;
    Caption = 'My Role Center';

    layout
    {
        area(RoleCenter)
        {
            part(Greeting; StudentRoleCenterHeadlinePart)
            {
                ApplicationArea = all;
            }
            group(MainGroup)
            {
                part(StudentListPart; "Student List Part")
                {
                    ApplicationArea = All;
                    Caption = 'Student List Overview';
                }

                part(StudentCuesPart; StudentCues)
                {
                    Caption = 'Cues Overview';
                    ApplicationArea = All;
                }
            }
            group(Charts)
            {
                part(Chart; "Help And Chart Wrapper")
                {
                    ApplicationArea = All;
                    Caption = 'Student Chart Overview';
                }


            }
        }


    }


    actions
    {
        area(Sections)
        {
            group(Examinations)
            {
                Caption = 'CUK Examinations';

                action(ExaminationsList)
                {
                    Caption = 'View Examinations';
                    RunObject = Page "Examination List page";
                    ApplicationArea = All;
                    Tooltip = 'View and manage examination records.';
                }
            }

            group(Reports)
            {
                Caption = 'CUK Reports';

                action(StudentListReport)
                {
                    Caption = 'Generate Student List Report';
                    RunObject = Report "Student List -- Report";
                    ApplicationArea = All;
                    Tooltip = 'Generate a report listing all students.';
                }
            }
            group(Fees)
            {
                Caption = 'CUK Fees';

                action(DueFeesList)
                {
                    Caption = 'View Due Fees';
                    RunObject = Page FeeListPage;
                    ApplicationArea = All;
                    Tooltip = 'View and manage fee records.';
                }
            }

        }

        area(Embedding)
        {
            action(ViewStudents)
            {
                Caption = 'Student Lists';
                RunObject = Page StudentListPage;
                ApplicationArea = All;
                Tooltip = 'View and manage student lists.';
            }

            action(ViewCourses)
            {
                Caption = 'Course Lists';
                RunObject = Page CourseListPage;
                ApplicationArea = All;
                Tooltip = 'View and manage available courses.';
            }
            action(ViewStaff)
            {
                Caption = 'Staff Lists';
                RunObject = Page "Staff List Page";
                ApplicationArea = All;
                Tooltip = 'View and manage available staff.';
            }
        }

        area(Processing)
        {
            group(StudentManagement)
            {
                Caption = 'Student Management';

                action(ViewAllStudents)
                {
                    Caption = 'See All Students';
                    RunObject = Page StudentListPage;
                    ApplicationArea = All;
                    Tooltip = 'View all registered students in the system.';
                }
            }
        }
    }

}

// Profile Creation for Role Center
profile CUKAdminProfile
{
    ProfileDescription = 'CUK Admin Profile';
    RoleCenter = CUKRolecenter;
    Caption = 'CUK Admin Profile';
}
