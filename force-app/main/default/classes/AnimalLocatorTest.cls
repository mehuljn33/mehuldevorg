@isTest
public class AnimalLocatorTest{
    @isTest
    static void testGet() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String str = AnimalLocator.getAnimalNameById(45);
        Test.stopTest();
    }

}