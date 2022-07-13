/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 12-07-2022
 * @last modified by  : Fábio Marques
**/
public class ManagingWarshipController{
    
    public Warship__c warship{ get; set; }
    public Supply__c supply{ get; set; }
    
    public List <Warship_Supply__c> newSupplies{ get; set; } 
    public List <Milestone__c> newMilestones{ get; set; } 

    private Id wId;
    
    public ManagingWarshipController(ApexPages.StandardController controller) {
        wId = controller.getId();
        
        init();
        
    }
    
    public void addSupplies(){
        Warship_Supply__c s = new Warship_Supply__c(Ship_supply__c = warship.Id);
        newSupplies.add(s);
    }
    
    public void saveSupplies(){
        insert newSupplies;
        init();
    }
    
    public void addMilestones(){
        Milestone__c m = new Milestone__c(warship__c = warship.Id);
        newMilestones.add(m);
    }
    
    public void saveMilestones(){
        insert newMilestones;
        init();
    } 
    
    private void init(){
        newSupplies = new List <Warship_Supply__c>();
        newMilestones = new List<Milestone__c>();
        
        warship = [SELECT id, name,(SELECT id,Name, Supply_Name__c, Quantity__c From Warship_Supplies__r),
                   (SELECT id, Name, Due_Date__c,Status__c  FROM Milestones__r)
                   FROM Warship__c WHERE ID = :wId]; 
    
    }
}