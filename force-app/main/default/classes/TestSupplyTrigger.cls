/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 13-07-2022
 * @last modified by  : Fábio Marques
**/
@isTest
public class TestSupplyTrigger {

    @isTest
    static void suppliesTest() {      

        List<Supply__c> supplies = new List<Supply__c>();

        for (Integer i = 0; i < 10; i++) {
            Supply__c s = new Supply__c();
            if (math.mod(i,2) == 0) {
                s.Name = 'Teste'+i;
            }else{
                s.Name = 'Teste';
            }
            s.Quantity__c = i+1;
            s.Unit_Cost__c = i+1;
            supplies.add(s);
        }

        try {
            insert supplies; 
            
        } catch (Exception e ) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('A supply with this name already exists') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }

        supplies = new List<Supply__c>(); 
        for (Integer i = 0; i < 10; i++) {
            Supply__c s = new Supply__c();
            s.Name = 'Test'+i;
            s.Quantity__c = i+1;
            s.Unit_Cost__c = i+1;
            supplies.add(s);
        }

        insert supplies;
    
        supplies[0].Name = 'Test1';
        
        try {
            update supplies;
            
        } catch (Exception e ) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('A supply with this name already exists') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }

    }
}