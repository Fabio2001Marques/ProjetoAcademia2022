/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
public class BatchDueDate implements Database.Batchable<SObject>, Database.Stateful{
    private Integer processes = 0;

    public Database.QueryLocator start(Database.BatchableContext context){
        String query = 'SELECT id, Due_Date__c, Status__c FROM Milestone__c Where Status__c != \'Complete\'';
        System.debug(query);
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext context, List<Milestone__c> scope){
        for(Milestone__c ms : scope){         
            if((ms.Due_Date__c) < System.today()){
                ms.Status__c = 'Behind Schedule';            
            }  
        }
        update scope;
    }

    public void finish(Database.BatchableContext context){
        System.debug(processes +' records processed on job with id : '+ context.getJobId() + '.');
        
    }
}