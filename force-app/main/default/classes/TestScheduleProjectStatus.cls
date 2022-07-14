/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 14-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class TestScheduleProjectStatus {
    @TestSetup
    static void makeData(){
        TestDataFactory.createWarshipsWithMilestones();
    } 

    @isTest
    static void testUpdateProjectStatus() {
        Test.startTest();
        alterar_project_status scheduleClass = new alterar_project_status();
        String chron = '0 0 23 * * ?';        
        System.schedule('Test Sched', chron, scheduleClass);
        Test.stopTest();
        
        List<Warship__c> warship = [SELECT id, Name, Project_Status__c From Warship__c];
        List<Milestone__c> milestones = [SELECT id, Name,Status__c, Warship__c From Milestone__c];       

        for (Warship__c w : warship) {
            Integer count = 0;
            for(Milestone__c m : milestones){
                if(m.Warship__c == w.Id){
                    if(m.Status__c == 'Behind Schedule') count = count+1;
                }
            }
            if(count > 1){
                System.assertEquals('Red', w.Project_Status__c, 'Devia ter passado a RED');
            }else if (count == 1){
                System.assertEquals('Yellow', w.Project_Status__c, 'Devia ter passado a Yellow');
            }else if(count == 0){
                System.assertEquals('Green', w.Project_Status__c, 'Devia ter passado a Green');
            }
            
        }
    }
}