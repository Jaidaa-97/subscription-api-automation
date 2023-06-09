package inc.fabric.api.automation.runner;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        glue = {"inc.fabric.api.automation.steps"},
        features = {"src/test/resources/features"},
        plugin = {"json:target/cucumber-report/cucumber.json","pretty","html:target/cucumber-html",
                "io.qameta.allure.cucumber5jvm.AllureCucumber5Jvm"},
        tags = {"@regression_"},
        monochrome = true
)
public class TestRunner {
}
