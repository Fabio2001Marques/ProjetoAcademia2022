/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 20-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class TestWarSupTrigger {
    @TestSetup
    static void makeData(){
        TestDataFactory.createWarSup(5);
    }

    @isTest
    static void insertWarSupTriggerTest(){
        
        List<Supply__c> supplies = [Select id, Name, Quantity__c From Supply__c];
        List<Warship__c> warships = [Select id, Name From Warship__c];
        List<Warship_Supply__c> ws = [Select id From Warship_Supply__c];
        delete ws;

        List<Warship_Supply__c> warshipSuplly = new List<Warship_Supply__c>();

        for (Warship__c w : warships) {
            for (Integer i = 0; i < 5; i++) {
                Warship_Supply__c warSup = new Warship_Supply__c();
                warSup.Ship_supply__c = w.Id;
                warSup.Supply__c = supplies[i].Id;
                warSup.Quantity__c = i;                                     
                if (i== 1) {                   
                    warSup.Supply__c = supplies[i-1].Id;
                }if (i == 2) {
                    warSup.Quantity__c = 1000;  
                }
                warshipSuplly.add(warSup);
            }
        }
        try {
            insert warshipSuplly;
            
        } catch (Exception e ) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('Quantity must be greater than zero') ? true : false;
            if (expectedExceptionThrown == false) {
                expectedExceptionThrown =  e.getMessage().contains('There are not enough supplies.') ? true : false;
            }
            System.AssertEquals(expectedExceptionThrown, true);
        }

        Warship_Supply__c warSup = new Warship_Supply__c();
        warSup.Ship_supply__c = warships[0].Id;
        warSup.Supply__c = supplies[0].Id;
        warSup.Quantity__c = 1;

        insert warSup;

        Warship_Supply__c warSup2 = new Warship_Supply__c();
        warSup2.Ship_supply__c = warships[0].Id;
        warSup2.Supply__c = supplies[0].Id;
        warSup2.Quantity__c = 1;

        try {
            insert warSup2;
            
        } catch (Exception e ) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This suplly already exists in this Warship.') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }

    @isTest
    static void updateWarSupTriggerTest(){

        List<Supply__c> supplies = [Select id, Name, Quantity__c From Supply__c];
        List<Warship__c> warships = [Select id, Name From Warship__c];
        List<Warship_Supply__c> warshipSupply = [Select id, Ship_supply__c, Supply__c From Warship_Supply__c];

        warshipSupply[0].Quantity__c = 1000;
        warshipSupply[1].Quantity__c = 0;    

        try {
            update warshipSupply;
            
        } catch (Exception e ) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('Quantity must be greater than zero') ? true : false;
            if (expectedExceptionThrown == false) {
                expectedExceptionThrown =  e.getMessage().contains('There are not enough supplies.') ? true : false;
            }
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }

    @isTest
    static void deleteWarSupTriggerTest(){
        List<Warship_Supply__c> warshipSupply = [Select id, Supply__c, Quantity__c From Warship_Supply__c];

        List<Id> suppliesIdList = new List<Id>();          
        for(Warship_Supply__c oldWarSup : warshipSupply){           
            suppliesIdList.add(oldWarSup.Supply__c);
        }

        List<Supply__c> oldsupplies = [Select id, Name, Quantity__c From Supply__c Where id in :suppliesIdList];        
        delete warshipSupply;
        List<Supply__c> newsupplies = [Select id, Name, Quantity__c From Supply__c Where id in :suppliesIdList];

        for (Supply__c oldS : oldsupplies) {
            for (Supply__c newS : newSupplies) {
                if(oldS.Id == newS.Id){
                    for (Warship_Supply__c ws : warshipSupply) {
                        if(oldS.Id == ws.Supply__c){
                            System.AssertEquals(9,ws.Quantity__c + oldS.Quantity__c, 'Do not update Quantity field');
                        }
                    }
                }            
            }
            
        }
    }
}