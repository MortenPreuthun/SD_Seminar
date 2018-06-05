codeunit 123456739 EventSubscriptions
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-1
{
  [EventSubscriber(ObjectType::Codeunit, 212,'OnBeforeResLedgEntryInsert', '', true, true)]
  local procedure PostResJnlLineOnBeforeResLedgEntryInsert(var ResLedgerEntry : Record "Res. Ledger Entry";ResJournalLine : Record "Res. Journal Line");
  var
    c : Codeunit "Res. Jnl.-Post Line";
  begin   
      ResLedgerEntry."CSD_Seminar No.":=ResJournalLine."CSD_Seminar No.";
      ResLedgerEntry."CSD_Seminar Registration No.":=ResJournalLine."CSD_Seminar Registration No."; 
  end;

  [EventSubscriber(ObjectType::Page,344,'OnAfterNavigateFindRecords','',true,true)]
  local procedure ExtendNavigateWithSeminarLedgers(var DocumentEntry:Record "Document Entry" ; DocNoFilter : text; PostingdateFilter:text);
  
  var
    SeminarLedgerEntry : Record "Seminar Ledger Entry";
    PostedSeminarRegHeader : Record "Posted Seminar Reg. Header";
    DocNoOfrecords: Integer;
    NextEntryNo:Integer;
    begin
      IF PostedSeminarRegHeader.ReadPermission then begin
        PostedSeminarRegHeader.reset;
        PostedSeminarRegHeader.setfilter("No.",DocNoFilter);
        PostedSeminarRegHeader.setfilter("Posting Date",PostingdateFilter);
        DocNoOfrecords := PostedSeminarRegHeader.Count;
        with DocumentEntry do begin
          if DocNoOfrecords=0 then 
            exit;
          if findlast then 
            NextEntryNo+=1
          else
            nextentryno := 1;
          init;
          "Entry No.":= NextEntryNo;
          "Table ID":=database::"Posted Seminar Reg. Header";
          "Document Type":= 0;
          "Table Name":=CopyStr(PostedSeminarRegHeader.TableCaption,1,maxstrlen("Table Name"));
          "No. of Records":=DocNoOfrecords;
          insert;  
        end;
      end;

    end;
}
