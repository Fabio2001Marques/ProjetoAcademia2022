/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 14-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class TestMilestoneTrigger {
    @TestSetup
    static void makeData(){
        List<Warship__c> w = TestDataFactory.createWarship(1);
        insert w;
    }

    @isTest
    static void milestoneTriggerTest(){
       
        List<Warship__c> w = [Select id From Warship__c];
        List<Milestone__c> milestones = new List<Milestone__c>();

        for (Integer i = 0; i < 5; i++) {
            Milestone__c ms = new Milestone__c();
            ms.Name = 'Teste 1'+i;
            ms.Warship__c = w[0].Id;
            if (i<2) {
                ms.Status__c = 'On Track';
            }else if(i<4){
                ms.Status__c = 'Behind Schedule';
            }else{
                ms.Status__c = 'Complete';
            }
            
            ms.Due_Date__c = System.today().addDays(i);          
            milestones.add(ms);
        }

        try {
            insert milestones;
            
        } catch (Exception e ) {
            System.debug('Exceçao: '+e.getMessage());
            Boolean expectedExceptionThrown =  e.getMessage().contains('A "Completed" Milestone cannot be created!!!') ? true : false;
            if (expectedExceptionThrown == false) {
                expectedExceptionThrown =  e.getMessage().contains('A "Behind Schedule" Milestone cannot be created!!!') ? true : false;
            }
            System.AssertEquals(expectedExceptionThrown, true);
        }

    }
}