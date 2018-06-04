pageextension 123456700 CSD_ResourceCardExt extends "Resource Card"
{
    layout
    {
        addlast(General)
        {
            field("CSD_Resource Type";"CSD_Resource Type")
            {

            }
            field("CSD_Quantity per Day";"CSD_Quantity per Day")
            {
                

            }
            
            

        }
        addafter("Personal Data")
        {
            group("Room")
            {
                field("CSD_MAximum Participants";"CSD_MAximum Participants")
                {

                }
            }
        }
            
        
    }

    actions
    {
        
    }
    trigger OnOpenPage();
    var
        
    begin
        ShowMaxField:= (type=type::Machine);
        CurrPage.Update(false);
    end;
    
    var
        
        [InDataSet]
        ShowMaxField: Boolean;


}