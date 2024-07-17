@isTest
public class testOnLeadCls {
    @isTest
    static void testDrPrepLeadName() {
        // Arrange
        Lead testLead = new Lead(LastName = 'Test', Company = 'Test Co', FirstName = 'Bob');
        insert testLead;

        List<Lead> leads = new List<Lead>{ testLead };

        // Act
        triggeronLead.drprepleadname(leads);

        // Assert
        Lead updatedLead = [SELECT FirstName FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals('Dr Bob', updatedLead.FirstName);
    }
}
