package inc.fabric.api.automation.steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import inc.fabric.api.automation.pages.BasePage;
import inc.fabric.api.automation.utility.CommonUtils;
import inc.fabric.api.automation.utility.FileHandler;
import io.cucumber.core.api.TypeRegistry;
import io.cucumber.core.api.TypeRegistryConfigurer;
import io.cucumber.core.stepexpression.StepTypeRegistry;
import io.cucumber.cucumberexpressions.ParameterType;
import io.cucumber.cucumberexpressions.ParameterTypeRegistry;
import io.cucumber.datatable.DataTable;
import io.cucumber.docstring.DocStringTypeRegistry;
import io.cucumber.java.DataTableType;
import io.cucumber.java.DefaultParameterTransformer;
import io.cucumber.java.DocStringType;

import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoField;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static java.util.Collections.singletonList;

public class TypeRegistryConfiguration implements TypeRegistryConfigurer {
    private static final Pattern parameterPattern1 = Pattern.compile("\\{([^:}]+)::([^}]+)}");
    private static final Pattern parameterPattern2 = Pattern.compile("---((?:(?!:-:).)*):-:((?:(?!---).)*)---");
    private static final Pattern parameterPattern3 = Pattern.compile("\\{([^:}]+):::([^}]+)}");


    /*
     * Given a step defined by:
     * @When("I convert a table to a datatable :")
     * public void convert(DataTable table) {
     *   // Implementation
     * }
     *
     * When I convert a table to a datatable :
     *    | {PropertiesFile:Property} |
     *
     *           Becomes
     *
     * When I convert a table to a datatable :
     *   | Converted Value |
     */
    @DataTableType
    public DataTable convertDataTable(DataTable table) {
        return DataTable.create(
                table.cells().stream().map(
                        row -> row.stream().map(this::convertString).collect(Collectors.toList())
                ).collect(Collectors.toList()));
    }

    /*
     * Given a step defined by:
     * @When("I convert a table to a list of lists :")
     * public void convert(List<List<String>> table) {
     *   // Implementation
     * }
     *
     * When I convert a table to a list of lists :
     *    | {PropertiesFile:Property} |
     *
     *           Becomes
     *
     * When I convert a table to a list of lists :
     *   | Converted Value |
     */
    @DataTableType
    public String convertStringInDataTable(String cell) {
        return convertString(cell);
    }

    /*
     * Given a step defined by:
     * @When("I convert a table to a list :")
     * public void convert(List<String> table) {
     *   // Implementation
     * }
     *
     * When I convert a table to a list :
     *    | {PropertiesFile:Property} |
     *
     *           Becomes
     *
     * When I convert a table to a list :
     *   | Converted Value |
     */
    @DataTableType
    public List<String> convertDataTableToListOfString(DataTable table) {
        return table.asList().stream().map(this::convertString).collect(Collectors.toList());
    }

    /*
     * Given a step defined by:
     * @When("I convert a docstring to a json element :")
     * public void convert(JsonElement table) {
     *   // Implementation
     * }
     *
     * When I convert a docstring to a json element :
     *   """
     *   {PropertiesFile:Property}
     *   """
     *
     *           Becomes
     *
     * When I convert a docstring to a json element :
     *   """
     *   Converted Value
     *   """
     */
    @DocStringType
    public JsonElement json(String docString) {
        return new Gson().toJsonTree(convertString(docString), String.class);
    }

    /*
     * Given a step defined by:
     * @When("I convert {string} to a string")
     * public void convert(JsonElement table) {
     *   // Implementation
     * }
     *
     * When I convert "{PropertiesFile:Property}" to a string
     *
     *           Becomes
     *
     * When I convert "Converted Value" to a string
     */
    @DefaultParameterTransformer
    public Object convertStringParameter(String inputString, Type targetType) {
        if (String.class == targetType) {
            if (inputString == null) {
                return null;
            } else {
                return convertString(inputString);
            }
        } else {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.convertValue(inputString, mapper.constructType(targetType));
        }
    }

    /**
     * Parses a String for values that can be interpolated from various sources.
     * <br>
     * {@link #convertStringUsingPattern} is called using the following patterns:
     * <ul>
     *     <li>{Key:Value}</li>
     *     <li>---Key:-:Value---</li>
     * </ul>
     *
     * @param fromValue The String to parse for values to interpolate.
     * @return The input String, with all possible values interpolated.
     */
    private String convertString(String fromValue) {
        // Do not try to process null inputs
        if (fromValue == null) {
            return "";
        } else if ("[null]".equalsIgnoreCase(fromValue)) {
            return null;
        }

        fromValue = convertStringUsingPattern(fromValue, parameterPattern1);
        fromValue = convertStringUsingPattern(fromValue, parameterPattern2);
        fromValue = convertStringUsingPattern(fromValue, parameterPattern3);

        return fromValue;
    }

    private String convertStringUsingPattern(String fromValue, Pattern pattern) {
        StringBuilder sb = new StringBuilder();
        Matcher matcher = pattern.matcher(fromValue);
        int last = 0;
        while (matcher.find()) {
            String toConvert = matcher.group(0);
            String parameter1 = matcher.group(1);
            String parameter2 = matcher.group(2);
            String convertedValue = toConvert;

            sb.append(fromValue, last, matcher.start());

            if ("SavedValue".equalsIgnoreCase(parameter1)) {
                if (BasePage.savedValues.get(parameter2) != null) {
                    convertedValue = BasePage.savedValues.get(parameter2);
                    BasePage.scenario.write("Converted value :" + convertedValue);
                } else {

                }
            } else if ("Date".equalsIgnoreCase(parameter1)) {
                try {
                    convertedValue = getDate(parameter2);
                    BasePage.scenario.write("Converted value :" + convertedValue);
                } catch (Error e) {
                }
            } else if ("RandomNumber".equalsIgnoreCase(parameter1)) {
                convertedValue = String.valueOf(CommonUtils.getRandomNumberFourDigit());
                BasePage.scenario.write("Converted value :" + convertedValue);
            } else {
                try {
                    if (parameter2.contains("env_")) {
                        parameter2 = CommonUtils.getEnv().toLowerCase() + "_" + parameter2.split("_")[1];
                    }
                    if (FileHandler.readPropertyFile(parameter1 + ".properties", parameter2) != null) {
                        convertedValue = FileHandler.readPropertyFile(parameter1 + ".properties", parameter2);
                        BasePage.scenario.write("Converted value :" + convertedValue);
                    } else {

                    }
                } catch (Exception e) {

                }
            }
            sb.append(convertedValue);
            last = matcher.end();
        }

        sb.append(fromValue, last, fromValue.length());

        return sb.toString();
    }

    public String getDate(String dateFormatter) {
        String dateFormat[] = dateFormatter.split(":::");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern(dateFormat[0]);
        LocalDate localDate = LocalDate.now();
        String[] dd = dateFormat[1].split(";");
        for (String d1 : dd) {
            if (d1.contains("d")) {
                long days = Long.parseLong(d1.split("=")[1]);
                localDate = localDate.plusDays(days);
            }
            if (d1.contains("M")) {
                long days = Long.parseLong(d1.split("=")[1]);
                localDate = localDate.plusMonths(days);
            }
            if (d1.contains("Y")) {
                long days = Long.parseLong(d1.split("=")[1]);
                localDate = localDate.plusYears(days);
            }
        }

        BasePage.scenario.write("Date :" + localDate.format(dtf));

        return localDate.format(dtf);
    }

    /**
     * Necessary function to implement TypeRegistryConfigurer.
     * Can be more or less ignored.
     */
    @Override
    public Locale locale() {
        return Locale.ENGLISH;
    }

    /**
     * This method sets up how Gherkins steps are to be parsed by Cucumber.
     * <p>
     * In particular, all String parameters, and all DataTable cells, are parsed by
     * {@link #convertStringUsingPattern}.
     * <p>
     * The two patterns that are used by the parser are {Key:Value} and ---Key:-:Value---
     *
     * @param typeRegistry Standard parameter, provided by Cucumber.
     * @author jitendra.pisal
     */
    @Override
    public void configureTypeRegistry(TypeRegistry typeRegistry) {
        if (typeRegistry instanceof StepTypeRegistry) {
            // Allows DocString parameters to be processed
            redefineDefaultDocStringProcessing((StepTypeRegistry) typeRegistry);

            // Allow {string} parameters to be processed
            redefineDefaultParameterProcessing((StepTypeRegistry) typeRegistry);
        }
    }

    /**
     * This method removes the already defined {string} ParameterType
     * <br>It then uses defineParameterType to add our own processing.
     * <br>Since the fields and methods are private or protected, we are using Reflection to get access to them.
     */
    private void redefineDefaultParameterProcessing(StepTypeRegistry typeRegistry) {

        try {
            // Get the DataTableRegistry field from the TypeRegistry
            // This field defines the default types in a map
            Field dataTableRegistryField = StepTypeRegistry.class.getDeclaredField("parameterTypeRegistry");
            dataTableRegistryField.setAccessible(true);
            ParameterTypeRegistry parameterRegistry = (ParameterTypeRegistry) dataTableRegistryField.get(typeRegistry);

            // Get the underlying map from the ParameterTypeRegistry
            // It is a map from String to Object
            Field typeMapField = ParameterTypeRegistry.class.getDeclaredField("parameterTypeByName");
            typeMapField.setAccessible(true);
            @SuppressWarnings("unchecked")
            Map<String, Object> typeMap = (Map<String, Object>) typeMapField.get(parameterRegistry);

            // Remove the old
            typeMap.remove("string");
        } catch (Exception e) {
        }

        typeRegistry.defineParameterType(new ParameterType<>("string", singletonList(Pattern.compile("\"([^\"\\\\]*(\\\\.[^\"\\\\]*)*)\"|'([^'\\\\]*(\\\\.[^'\\\\]*)*)'").pattern()), String.class,
                this::convertString, true, true)
        );
    }

    /**
     * This method removes the already defined String.class DataTableType
     * <br>It then uses defineDataTableType to add our own processing.
     * <br>Since the fields and methods are private or protected, we are using Reflection to get access to them.
     */
    private void redefineDefaultDocStringProcessing(StepTypeRegistry typeRegistry) {

        try {
            // Get the DataTableRegistry field from the TypeRegistry
            // This field defines the default types in a map
            Field dataTableRegistryField = StepTypeRegistry.class.getDeclaredField("docStringTypeRegistry");
            dataTableRegistryField.setAccessible(true);
            DocStringTypeRegistry dataTableRegistry = (DocStringTypeRegistry) dataTableRegistryField.get(typeRegistry);

            // Get the underlying map from the DataTableRegistry
            // It is a map from JavaType to DataTableType
            Field typeMapByContentField = DocStringTypeRegistry.class.getDeclaredField("docStringTypesByContentType");
            typeMapByContentField.setAccessible(true);
            @SuppressWarnings("unchecked")
            Map<String, io.cucumber.docstring.DocStringType> typeMapByContent = (Map<String, io.cucumber.docstring.DocStringType>) typeMapByContentField.get(dataTableRegistry);

            // Get the underlying map from the DataTableRegistry
            // It is a map from JavaType to DataTableType
            Field typeMapByClassField = DocStringTypeRegistry.class.getDeclaredField("docStringTypesByType");
            typeMapByClassField.setAccessible(true);
            @SuppressWarnings("unchecked")
            Map<Type, io.cucumber.docstring.DocStringType> typeMapByClass = (Map<Type, io.cucumber.docstring.DocStringType>) typeMapByClassField.get(dataTableRegistry);

            // Remove the default String DataTable processing
            typeMapByContent.remove("");
            typeMapByClass.remove(String.class);
        } catch (Exception e) {
        }

        typeRegistry.defineDocStringType(new io.cucumber.docstring.DocStringType(String.class, "", this::convertString));
    }
}
