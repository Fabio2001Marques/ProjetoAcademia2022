/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class TestBatchDueDate {
    @TestSetup
    static void makeData(){
        TestDataFactory.createWarshipsWithMilestones();
    }

    @isTest
    static void checkStatusMilestone(){
        Test.startTest();
        BatchDueDate batchable = new BatchDueDate();     
        Database.executeBatch(batchable);
        Test.stopTest();

        List<Milestone__c> milestones = [SELECT id, Name,Due_Date__c, Status__c From Milestone__c];

        for (Milestone__c m : milestones) {
            if((m.Due_Date__c) < System.today()){
                System.assertEquals('Behind Schedule', m.Status__c, 'Should have changed it to Behind Schedule');
            }
        } 
    }
}