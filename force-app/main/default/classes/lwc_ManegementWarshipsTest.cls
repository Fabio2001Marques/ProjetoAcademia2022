/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class lwc_ManegementWarshipsTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.createWarSup(5);
        TestDataFactory.createWarRes(5);
    } 

    @isTest
    static void testGetWarships(){     
        Test.startTest();
        List<Warship__c> warships = lwc_ManegementWarships.getWarships();
        Test.stopTest();
        System.assertEquals(2, warships.size());
    }

    @isTest
    static void testGetSupllies(){
        List<Warship_Supply__c> w_Id = [Select id, Ship_supply__c From Warship_Supply__c Limit 1];
        Test.startTest();
        List<Warship_Supply__c> supplies = lwc_ManegementWarships.getSupllies(w_Id[0].Ship_supply__c);
        List<Warship_Supply__c> suppliesNull = lwc_ManegementWarships.getSupllies(w_Id[0].Id);   
        Test.stopTest();
        System.assertEquals(null, suppliesNull);
        System.assertEquals(5, supplies.size());
    }

    @isTest
    static void testGetMilestones(){
        List<Warship__c> warships = [Select id from Warship__c limit 2];
        TestDataFactory.createMilestones(warships[0].Id, 5);
        Test.startTest();
        List<Milestone__c> milestonesNull = lwc_ManegementWarships.getMilestones(warships[1].Id);
        List<Milestone__c> milestones = lwc_ManegementWarships.getMilestones(warships[0].Id);   
        Test.stopTest();
        System.assertEquals(null, milestonesNull);
        System.assertEquals(5, milestones.size());
    }

    @isTest
    static void testGetAddSupply(){
        List<Warship_Supply__c> warSup = [Select Id,Supply_Name__c, Quantity__c, Available_Quantity__c FROM Warship_Supply__c limit 1 ];
        Test.startTest();
        Warship_Supply__c getWarsup = lwc_ManegementWarships.getAddSupply(warSup[0].Id); 
        Test.stopTest();
        System.assertEquals(warSup[0], getWarsup);
    }

    @isTest
    static void testUpdateWarSup(){
        List<Warship_Supply__c> warSup = [Select Id,Supply_Name__c, Quantity__c, Available_Quantity__c FROM Warship_Supply__c limit 1 ];
        
        Test.startTest();
        List<Warship_Supply__c> getWarsup = lwc_ManegementWarships.updateWarSup(warSup[0].Id, 5); 
        Test.stopTest();

        for (Warship_Supply__c ws : getWarsup) {
            if (ws.Id == warSup[0].id) {
                System.assertEquals(warSup[0].Quantity__c + 5, ws.Quantity__c);
            }
        }
    }

    @isTest
    static void testGetDataWarship(){
        List<Warship__c> warship = [SELECT Id, Name, ActiveMilestones__c, Project_Status__c, Weapons_Status__c, Owner.Name, Account__r.Name FROM Warship__c];
        
        Test.startTest();
        Warship__c getWarship = lwc_ManegementWarships.getDataWarship(warship[0].Id); 
        Warship__c getWarshipNull = lwc_ManegementWarships.getDataWarship('5324632487'); 
        Test.stopTest();

        System.assertEquals(warship[0], getWarship);
        System.assertEquals(null, getWarshipNull);
    }

    @isTest
    static void testGetResources(){
        List<Warship_Resource__c> w_Id = [SELECT Id, Resource_Name__c,Warship__c, Quantity__c FROM Warship_Resource__c limit 1];

        Test.startTest();
        List<Warship_Resource__c> resources = lwc_ManegementWarships.getResources(w_Id[0].Warship__c);
        List<Warship_Resource__c> resourcesNull = lwc_ManegementWarships.getResources(w_Id[0].Id);   
        Test.stopTest();

        System.assertEquals(null, resourcesNull);
        System.assertEquals(5, resources.size());
    }
}