namespace tests;

public class UnitTest1
{
    [Fact]
    public void TestSanity()
    {
        var result = false;
        Assert.False(result, "value should not be true");
    }
}
