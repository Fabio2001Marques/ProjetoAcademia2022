/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 11-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class TestCheckDueDate {
    @TestSetup
    static void makeData(){
        TestDataFactory.createMilestones(3);
    }

    @isTest
    static void checkStatusMilestone(){
        Test.startTest();
        check_Due_Date scheduleClass = new check_Due_Date();
        String chron = '0 0 23 * * ?';        
        System.schedule('Test Sched', chron, scheduleClass);
        Test.stopTest();

        List<Milestone__c> milestones = [SELECT id, Name,Due_Date__c, Status__c From Milestone__c];

        for (Milestone__c m : milestones) {
            if((m.Due_Date__c) < System.today()){
                System.assertEquals('Behind Schedule', m.Status__c, 'Devia ter alterado para Behind Schedule');
            }
        }

    }

}