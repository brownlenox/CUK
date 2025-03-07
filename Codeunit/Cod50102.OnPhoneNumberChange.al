codeunit 50102 OnPhoneNumberChange
{
    [IntegrationEvent(false, false)]
    procedure OnPhoneNumberChangeProcedure(phone: Code[50])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::OnPhoneNumberChange, 'OnPhoneNumberChangeProcedure', '', true, true)]
    procedure OnPhoneNumberChangeEvent(phone: Code[50])
    var
        ErrorMessage: Label 'The phone number is invalid. It must start with a + and contain only numbers.';
    begin
        if not CheckIfPhoneNumberIsValid(phone) then
            Error(ErrorMessage);

    end;


    local procedure CheckIfPhoneNumberIsValid(phone: code[20]): Boolean
    var
        myInt: Integer;
    begin
        if phone[1] <> '+' then
            exit(false);

        for myInt := 2 to StrLen(phone) do begin
            if not (phone[myInt] in ['0' .. '9']) then
                exit(false);
        end;

        if StrLen(phone) <> 13 then
            exit(false);

        exit(true);

    end;

}
