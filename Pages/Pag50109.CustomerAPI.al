page 50109 CustomerAPI
{
    APIGroup = 'custom';
    APIPublisher = 'lenox';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'customerAPI';
    DelayedInsert = true;
    EntityName = 'LocalCustomer';
    EntitySetName = 'LocalCustomers';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
            }
        }
    }
}
