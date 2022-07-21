/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
public class alterar_project_status implements Schedulable {
    private Integer count;
    
    public void execute(SchedulableContext sc){     
       List<warship__c> warship = [SELECT id, Name, Project_Status__c FROM warship__c];
       List<Milestone__c> milestones = [SELECT ID, name, Status__c, warship__c From Milestone__c where warship__c in :warship];
              
       for(warship__c ws : warship){
        count = 0;
        for (Milestone__c m : milestones) {
            if(m.warship__c == ws.Id){
                if(m.Status__c == 'Behind Schedule'){
                    count += 1;
                }
            }
        } 
        
        if(count > 3){
            ws.Project_Status__c = 'Red';
        }else if (count > 0){
            ws.Project_Status__c = 'Yellow';
        }else if(count == 0){
            ws.Project_Status__c = 'Green';
        } 
        update ws;
       }       
    }
}