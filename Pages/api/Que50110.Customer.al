query 50110 Customer
{
    APIGroup = 'custom';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'MyCustomers';
    EntitySetName = 'OurCustomers';
    QueryType = API;

    elements
    {
        dataitem(customer; Customer)
        {
            column(systemId; SystemId)
            {
            }
            column(name; Name)
            {
            }
            column(address; Address)
            {
            }
            column(balance; Balance)
            {
            }
            column(image; Image)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
