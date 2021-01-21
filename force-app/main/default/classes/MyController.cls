public class MyController {
  public transient Integer someValue { get; set; }
  public MyController() {
    someValue = 1;
  }
  public void incrementCounter() {
    someValue++;
  }
}