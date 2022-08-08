/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 05-08-2022
 * @last modified by  : Fábio Marques
**/
public class ControllerListSupply {

    public Boolean displayPopup {get;set;}
    static string paramValue;

    public ControllerListSupply() {
        init();
    }

    public List<Supply__c> supply{ get; set; }
    public List <Supply__c> newSupplies{ get; set; } 

    public void addSupplies(){
        Supply__c s = new Supply__c();
        newSupplies.add(s); 
    }
    
    public void saveSupplies(){
        try{
            insert newSupplies;
            init();
        }
        catch(Exception e){
            Apexpages.addMessage(new Apexpages.message(ApexPages.Severity.Error,e.getMessage()));
        } 
    }

    private void init(){
        newSupplies = new List <Supply__c>();            
        supply = [Select id, Name, Quantity__c, Total_Quantity__c, Utilization__c from Supply__c Order By Utilization__c DESC];
    }

    public void showPopup()
    {
    System.debug(paramValue);
    displayPopup = true;

    
    }
    
    public void closePopup() {
        displayPopup = false;
        
    }
    
    public PageReference redirectPopup()
    {
    displayPopup = false;
        //Please uncomment below 3 statements and replace YourObjectId
        PageReference p=new Pagereference('/a007Q000008DB4OQAW');
         p.setRedirect(true);
         return p;
        
    }
}