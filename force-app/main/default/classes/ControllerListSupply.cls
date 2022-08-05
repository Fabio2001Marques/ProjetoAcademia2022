/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 05-08-2022
 * @last modified by  : Fábio Marques
**/
public class ControllerListSupply {

    public ControllerListSupply() {}
    
    public List<Supply__c> getSupply(){
        String query='Select id, Name, Quantity__c, Total_Quantity__c, Utilization__c from Supply__c Order By Utilization__c DESC';
        List<Supply__c> supplies = Database.query(query);
        return supplies;
    }
}