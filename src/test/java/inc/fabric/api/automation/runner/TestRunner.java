package inc.fabric.api.automation.runner;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        glue = {"inc.fabric.api.automation.steps"},
        features = {"src/test/resources/features"},
        plugin = {"json:target/cucumber-report/cucumber.json","html:target/cucumber-html"},
        tags = "@a",
        monochrome = true
)
public class TestRunner {
}
