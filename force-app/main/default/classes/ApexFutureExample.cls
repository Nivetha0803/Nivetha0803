public class ApexFutureExample {
    public ApexFutureExample()
    {
        takebath();
        takebreakfast();
        carservice();
        gotooffice();
        
    }
      
    public void takebath()
      {
          system.debug('takebath==>' );
      }
    public void takebreakfast()
      {
          system.debug('takebreakfast==>' );
      }
    
    @future
    public static void carservice()
      {
          system.debug('carservice==>' );
      }
     public void gotooffice()
      {
          system.debug('carservice==>' );
      }
}