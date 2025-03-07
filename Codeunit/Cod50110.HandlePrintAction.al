// codeunit 50110 HandlePrintAction
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterDocumentPrintReady', '', true, true)]
//     procedure OnDocumentPrintReady(ObjectType: Option "Report","Page"; ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var Success: Boolean)
//     var
//         SMTPMail: Codeunit "SMTP Mail";
//         PrinterNameToken: JsonToken;
//         PrinterName: Text;
//         ObjectNameToken: JsonToken;
//         ObjectName: Text;
//         DocumentTypeToken: JsonToken;
//         DocumentTypeParts: List of [Text];
//         FileExtension: Text;
//         MailManagement: Codeunit "Mail Management";
//         SendFrom: Text;
//         FileName: Text;
//         Recipients: List of [Text];
//     begin
//         begin
//             // Step 1: Before doing anything, it is important to check the current Success value
//             if Success then
//                 exit;

//             // Step 2: Make sure code only runs for reports
//             if ObjectType = ObjectType::Report then begin

//                 // Step 3: Get report object payload information
//                 ObjectPayload.Get('printername', PrinterNameToken);
//                 PrinterName := PrinterNameToken.AsValue().AsText();
//                 if PrinterName = 'My Printer' then begin
//                     ObjectPayload.Get('objectname', ObjectNameToken);
//                     ObjectName := ObjectNameToken.AsValue().AsText();
//                     ObjectPayload.Get('documenttype', DocumentTypeToken);

//                     // Step 4: Build the email message
//                     DocumentTypeParts := DocumentTypeToken.AsValue().AsText().Split('/');
//                     FileExtension := DocumentTypeParts.Get(DocumentTypeParts.Count);
//                     Recipients.Add('myprinterb@businesscentral.onmicrosoft.com');
//                     SendFrom := MailManagement.GetSenderEmailAddress("Email Scenario"::"Customer Statement");
//                     SMTPMail.CreateMessage('Sender', SendFrom, Recipients, 'Hello this is your report', 'Please take a look');
//                     SMTPMail.AddAttachmentStream(DocumentStream, ObjectName + '.' + FileExtension);

//                     // Step 5: Send the email for print
//                     SMTPMail.Send;
//                     Success := true;
//                     exit;
//                 end;
//             end;
//         end;
//     end;

// }
