@IsTest
public class AccountWrapperTests {

    @TestSetup
    static void setupData() {

        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Amount = 150000
        );

        insert opp;
    }

    @IsTest
    static void testIsHighPriority() {

        Account acc = [SELECT Id FROM Account LIMIT 1];

        AccountWrapper wrapper = new AccountWrapper(acc);

        Test.startTest();

        Decimal avg = wrapper.getRoundedAvgPriceOfOpps();
        Boolean result = wrapper.isHighPriority();

        Test.stopTest();

        System.assert(avg > 100000);
        System.assertEquals(true, result);
    }

    @IsTest
    static void testException() {

        Account acc = new Account(Name = 'No Opportunity');
        insert acc;

        AccountWrapper wrapper = new AccountWrapper(acc);

        Test.startTest();

        try {
            wrapper.getRoundedAvgPriceOfOpps();
            System.assert(false);
        } catch (AccountWrapper.AWException e) {
            System.assertEquals('No won Opportunities', e.getMessage());
        }

        Test.stopTest();
    }
}
