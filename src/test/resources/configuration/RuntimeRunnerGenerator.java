package inc.fabric.api.automation.runner;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        glue = {"setup","inc.fabric.api.automation.steps"},
        features = {"target/parallel/features/[CUCABLE:FEATURE].feature"},
        plugin = {"json:target/cucumber-report/[CUCABLE:RUNNER].json","pretty","html:target/html-report",
                "io.qameta.allure.cucumber5jvm.AllureCucumber5Jvm"},
        tags = "not @wip",
        monochrome = true
)
public class RuntimeRunnerGenerator {
}
