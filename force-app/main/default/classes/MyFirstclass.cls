public class MyFirstclass {
    Boolean boolvar = true;
    Integer intvar = 10;
    String name = 'Test Name';
    Decimal decivar = 11.5;
    Double dbvar = 12345;
    Date datevar = system.today();
    DateTime dttimvar = system.now();
    public MyFirstclass(){
      System.debug('boolean value is ::::' +boolvar);
      System.debug('integer value is ::::' +intvar);
      System.debug('string ::::' +name);
      System.debug('decimal value is ::::' +decivar);
      System.debug('double ::::' +dbvar);
      System.debug('date is ::::' +datevar);
      System.debug('datetime ::::' +dttimvar);
      System.debug('testing deployment');
      System.debug('testing2 deployment2');
    }   
}