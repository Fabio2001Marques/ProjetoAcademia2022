/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 22-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class TestScheduleBatchDueDate {

    @TestSetup
    static void makeData(){
        TestDataFactory.createWarshipsWithMilestones();
    }

    @isTest
    static void testScheduleBatchDueDate(){
        Test.startTest();
        BatchDueDateSchedule scheduleClass = new BatchDueDateSchedule();
        String chron = '0 0 23 * * ?';        
        System.schedule('Test Sched', chron, scheduleClass);
        Test.stopTest();

        List<Milestone__c> milestones = [SELECT id, Name,Due_Date__c, Status__c From Milestone__c];
        System.debug(milestones);
        for (Milestone__c m : milestones) {
            if((m.Due_Date__c) < System.today()){
                //System.assertEquals('Behind Schedule', m.Status__c, 'Should have changed it to Behind Schedule');
            }
        } 
    }
}