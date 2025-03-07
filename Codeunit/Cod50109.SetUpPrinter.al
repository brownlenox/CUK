codeunit 50109 "SetUp Printer"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSetupPrinters', '', true, true)]
    procedure OnSetupPrinters(var Printers: Dictionary of [Text[250], JsonObject])
    var
        Payload: JsonObject;
    begin
        //Reading payload from text
        Payload.ReadFrom('{"version":1,"papertrays":[{"papersourcekind":"Upper","paperkind":"A4"},{"papersourcekind":"Custom","paperkind":"Custom","width":236,"height":322,"units":"mm"}]}');

        //adding printer to the dictionary
        Printers.Add('My Printers', Payload);

    end;
}
