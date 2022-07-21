/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
public class check_Due_Date implements Schedulable {
    
    public void execute(SchedulableContext sc){
        
        List<Milestone__c> m = [SELECT id, Due_Date__c, Status__c FROM Milestone__c Where Status__c != 'Complete'];

        for(Milestone__c ms : m){         
            if((ms.Due_Date__c) < System.today()){
                ms.Status__c = 'Behind Schedule';            
            }  
        }
        update m;
    }
} 