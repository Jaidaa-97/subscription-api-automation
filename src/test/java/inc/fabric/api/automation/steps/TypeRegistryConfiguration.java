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
                } else {

                }
            } else if ("Date".equalsIgnoreCase(parameter1)) {
                try {
                    convertedValue = getDate(parameter2);
                } catch (Error e) {
                }
            } else {
                try {
                    if (parameter2.contains("env_")) {
                        parameter2 = CommonUtils.getEnv().toLowerCase() + "_" + parameter2.split("_")[1];
                    }
                    if (FileHandler.readPropertyFile(parameter1 + ".properties", parameter2) != null) {
                        convertedValue = FileHandler.readPropertyFile(parameter1 + ".properties", parameter2);
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
        String[]dd = dateFormat[1].split(";");
        for(String d1 : dd) {
            if(d1.contains("d")){
                long days = Long.parseLong(d1.split("=")[1]);
                localDate = localDate.plusDays(days);
            }
            if(d1.contains("M")){
                long days = Long.parseLong(d1.split("=")[1]);
                localDate = localDate.plusMonths(days);
            }
            if(d1.contains("Y")){
                long days = Long.parseLong(d1.split("=")[1]);
                localDate = localDate.plusYears(days);
            }
        }

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

    /**
     * This method parses a String in the format DateFormatPattern::DateModifiers, or simply DateformatPattern,
     * and returns a String which represents a Date in the desired format.
     *
     * <br>The DateFormatPattern is any pattern that could be passed as an argument to {@link DateTimeFormatter#ofPattern(String)}
     * <br>The DateModifiers is a semi-colon (;) separated list of values that specifies how the the returned date should be adjusted
     * relative to the current date
     * <br><br>Each modifier must be the format "ModifierChar ModfierAction Integer"
     * <br>The following characters may be used as ModifierChars:
     * <ul>
     *     <li>n - Changes the nanosecond of the returned date</li>
     *     <li>s - Changes the second of the returned date</li>
     *     <li>m - Changes the minute of the returned date</li>
     *     <li>H or h - Changes the hour of the returned date</li>
     *     <li>D or d - Changes the day of the returned date</li>
     *     <li>M or L - Changes the month of the returned date</li>
     *     <li>Y, y, or u - Changes the year of the returned date</li>
     * </ul>
     * The following characters can be used as ModifierActions:
     * <ul>
     *     <li>'+': Adds the given number to the specified ModifierChar</li>
     *     <li>'-': Subtrats the given number from the specified ModifierChar</li>
     *     <li>'=': Sets the specified ModifierChar to the given number</li>
     * </ul>
     *
     * <br>The date is modified using the current date as the initial date, and modifiers are applied from left to right.
     * <br>Thus, "D=1;M+1;D-1" will set the day to the first of the month, add one to the month, and subtract 1
     * from the day, resulting in the last day of the current month.
     *
     * @param dateFormatter The String that will be used to format the date.
     * @return A String representation of a Date, modified as desired, and formatted as specified.
     */
    private String parseDate(String dateFormatter) {
        String[] qwe = dateFormatter.split(":::", 2);

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern(qwe[0]);
        LocalDateTime ldt = LocalDateTime.now();
        if (qwe.length > 1) {
            for (String modifier : qwe[1].split(";")) {
                modifier = modifier.replaceAll(" ", "");

                if (!CHRONO_FIELDS.containsKey(modifier.substring(0, 1))) {
                    throw new Error(String.format("'%s' is not a valid format specifier.%nValid specifiers are %s", modifier.substring(0, 1), CHRONO_FIELDS.keySet().toString()));
                }

                if (modifier.substring(1, 2).contentEquals("=")) {
                    ldt = ldt.with(CHRONO_FIELDS.get(modifier.substring(0, 1)), Long.parseLong(modifier.substring(2)));
                } else if (modifier.substring(1, 2).contentEquals("+") || modifier.substring(1, 2).contentEquals("-")) {
                    ldt = ldt.plus(Long.parseLong(modifier.substring(1)), CHRONO_UNITS.get(modifier.substring(0, 1)));
                } else {
                    throw new Error(String.format("'%s' is not formatted correctly.%nSecond character must be '=', '-', or '+'.", modifier));
                }
            }
        }
        return ldt.format(dtf);
    }

    private static final Map<String, ChronoField> CHRONO_FIELDS = Map.ofEntries(
            Map.entry("n", ChronoField.NANO_OF_SECOND),
            Map.entry("s", ChronoField.SECOND_OF_MINUTE),
            Map.entry("m", ChronoField.MINUTE_OF_HOUR),
            Map.entry("H", ChronoField.HOUR_OF_DAY),
            Map.entry("h", ChronoField.HOUR_OF_DAY),
            Map.entry("D", ChronoField.DAY_OF_MONTH),
            Map.entry("d", ChronoField.DAY_OF_MONTH),
            Map.entry("M", ChronoField.MONTH_OF_YEAR),
            Map.entry("L", ChronoField.MONTH_OF_YEAR),
            Map.entry("Y", ChronoField.YEAR),
            Map.entry("y", ChronoField.YEAR),
            Map.entry("u", ChronoField.YEAR)
    );
    private static final Map<String, ChronoUnit> CHRONO_UNITS = Map.ofEntries(
            Map.entry("n", ChronoUnit.NANOS),
            Map.entry("s", ChronoUnit.SECONDS),
            Map.entry("m", ChronoUnit.MINUTES),
            Map.entry("H", ChronoUnit.HOURS),
            Map.entry("h", ChronoUnit.HOURS),
            Map.entry("D", ChronoUnit.DAYS),
            Map.entry("d", ChronoUnit.DAYS),
            Map.entry("M", ChronoUnit.MONTHS),
            Map.entry("L", ChronoUnit.MONTHS),
            Map.entry("Y", ChronoUnit.YEARS),
            Map.entry("y", ChronoUnit.YEARS),
            Map.entry("u", ChronoUnit.YEARS)
    );
}
