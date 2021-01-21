public with sharing class StringArrayTest 
{
  public static List<String> generateStringArray(Integer index)
  {
    List<String> lStrings = new List<String>();
    for(Integer i = 0; i < index; i++)
    {
      lStrings.add('Test '+i);
    }
    return lStrings;
  }
}