# Java Collections, Generics & Java 8 Features - Complete Study Guide

## Table of Contents
1. [Java Collections Framework](#java-collections-framework)
2. [Java Generics](#java-generics)
3. [Java 8 Features](#java-8-features)
4. [Case Studies](#case-studies)
5. [Practice Assignments](#practice-assignments)

---

## Java Collections Framework

### Overview
The Java Collections Framework provides a unified architecture for storing and manipulating groups of objects. It includes interfaces, implementations, and algorithms.

### Core Interfaces Hierarchy

```
Collection (Interface)
├── List (Interface)
│   ├── ArrayList (Class)
│   ├── LinkedList (Class)
│   └── Vector (Class)
├── Set (Interface)
│   ├── HashSet (Class)
│   ├── LinkedHashSet (Class)
│   └── TreeSet (Class)
└── Queue (Interface)
    ├── PriorityQueue (Class)
    └── Deque (Interface)
        └── ArrayDeque (Class)

Map (Interface)
├── HashMap (Class)
├── LinkedHashMap (Class)
├── TreeMap (Class)
└── Hashtable (Class)
```

### 1. List Interface

Lists are ordered collections that allow duplicate elements.

#### ArrayList
- Dynamic array implementation
- Good for random access
- Not thread-safe

```java
import java.util.*;

public class ArrayListExample {
    public static void main(String[] args) {
        List<String> fruits = new ArrayList<>();
        
        // Adding elements
        fruits.add("Apple");
        fruits.add("Banana");
        fruits.add("Orange");
        fruits.add("Apple"); // Duplicates allowed
        
        // Accessing elements
        System.out.println("First fruit: " + fruits.get(0));
        System.out.println("Size: " + fruits.size());
        
        // Iterating
        for (String fruit : fruits) {
            System.out.println(fruit);
        }
        
        // Removing elements
        fruits.remove("Banana");
        fruits.remove(0); // Remove by index
        
        System.out.println("After removal: " + fruits);
    }
}
```

#### LinkedList
- Doubly-linked list implementation
- Good for frequent insertions/deletions
- Implements both List and Deque interfaces

```java
import java.util.*;

public class LinkedListExample {
    public static void main(String[] args) {
        LinkedList<Integer> numbers = new LinkedList<>();
        
        // Adding elements
        numbers.add(10);
        numbers.addFirst(5);
        numbers.addLast(20);
        numbers.add(1, 15); // Insert at index 1
        
        System.out.println("LinkedList: " + numbers);
        
        // Accessing elements
        System.out.println("First: " + numbers.getFirst());
        System.out.println("Last: " + numbers.getLast());
        
        // Queue operations
        numbers.offer(25); // Add to end
        Integer polled = numbers.poll(); // Remove from beginning
        System.out.println("Polled: " + polled);
        System.out.println("After poll: " + numbers);
    }
}
```

### 2. Set Interface

Sets are collections that do not allow duplicate elements.

#### HashSet
- Hash table implementation
- No ordering guarantee
- O(1) average time complexity for basic operations

```java
import java.util.*;

public class HashSetExample {
    public static void main(String[] args) {
        Set<String> colors = new HashSet<>();
        
        colors.add("Red");
        colors.add("Blue");
        colors.add("Green");
        colors.add("Red"); // Duplicate - won't be added
        
        System.out.println("Colors: " + colors);
        System.out.println("Size: " + colors.size());
        
        // Check if element exists
        if (colors.contains("Blue")) {
            System.out.println("Blue is present");
        }
        
        // Remove element
        colors.remove("Green");
        System.out.println("After removal: " + colors);
    }
}
```

#### TreeSet
- Red-Black tree implementation
- Maintains sorted order
- O(log n) time complexity for basic operations

```java
import java.util.*;

public class TreeSetExample {
    public static void main(String[] args) {
        TreeSet<Integer> numbers = new TreeSet<>();
        
        numbers.add(30);
        numbers.add(10);
        numbers.add(50);
        numbers.add(20);
        numbers.add(40);
        
        System.out.println("Sorted numbers: " + numbers);
        
        // Navigation methods
        System.out.println("First: " + numbers.first());
        System.out.println("Last: " + numbers.last());
        System.out.println("Lower than 25: " + numbers.lower(25));
        System.out.println("Higher than 25: " + numbers.higher(25));
        
        // Subset operations
        System.out.println("Numbers < 30: " + numbers.headSet(30));
        System.out.println("Numbers >= 20: " + numbers.tailSet(20));
        System.out.println("Numbers 15-35: " + numbers.subSet(15, 35));
    }
}
```

### 3. Map Interface

Maps store key-value pairs with unique keys.

#### HashMap
- Hash table implementation
- No ordering guarantee
- Allows one null key and multiple null values

```java
import java.util.*;

public class HashMapExample {
    public static void main(String[] args) {
        Map<String, Integer> studentGrades = new HashMap<>();
        
        // Adding key-value pairs
        studentGrades.put("Alice", 85);
        studentGrades.put("Bob", 92);
        studentGrades.put("Charlie", 78);
        studentGrades.put("Diana", 96);
        
        // Accessing values
        System.out.println("Alice's grade: " + studentGrades.get("Alice"));
        
        // Check if key exists
        if (studentGrades.containsKey("Bob")) {
            System.out.println("Bob's grade found: " + studentGrades.get("Bob"));
        }
        
        // Iterating through map
        for (Map.Entry<String, Integer> entry : studentGrades.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
        
        // Get all keys and values
        System.out.println("Students: " + studentGrades.keySet());
        System.out.println("Grades: " + studentGrades.values());
    }
}
```

#### TreeMap
- Red-Black tree implementation
- Maintains sorted order of keys
- O(log n) time complexity

```java
import java.util.*;

public class TreeMapExample {
    public static void main(String[] args) {
        TreeMap<String, String> capitals = new TreeMap<>();
        
        capitals.put("India", "New Delhi");
        capitals.put("USA", "Washington D.C.");
        capitals.put("France", "Paris");
        capitals.put("Japan", "Tokyo");
        capitals.put("Australia", "Canberra");
        
        System.out.println("Capitals (sorted by country): " + capitals);
        
        // Navigation methods
        System.out.println("First entry: " + capitals.firstEntry());
        System.out.println("Last entry: " + capitals.lastEntry());
        
        // Range operations
        System.out.println("Countries A-I: " + capitals.headMap("J"));
        System.out.println("Countries J-Z: " + capitals.tailMap("J"));
    }
}
```

### 4. Queue Interface

#### PriorityQueue
- Heap-based priority queue
- Elements are ordered according to natural ordering or comparator

```java
import java.util.*;

public class PriorityQueueExample {
    public static void main(String[] args) {
        // Natural ordering (min-heap)
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        minHeap.offer(30);
        minHeap.offer(10);
        minHeap.offer(50);
        minHeap.offer(20);
        
        System.out.println("Min Heap polling:");
        while (!minHeap.isEmpty()) {
            System.out.println(minHeap.poll());
        }
        
        // Custom ordering (max-heap)
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        maxHeap.offer(30);
        maxHeap.offer(10);
        maxHeap.offer(50);
        maxHeap.offer(20);
        
        System.out.println("Max Heap polling:");
        while (!maxHeap.isEmpty()) {
            System.out.println(maxHeap.poll());
        }
    }
}
```

---

## Java Generics

### Overview
Generics provide type safety at compile time and eliminate the need for type casting. They were introduced in Java 5.

### Benefits of Generics
1. **Type Safety**: Compile-time type checking
2. **Elimination of Type Casting**: No need for explicit casting
3. **Code Reusability**: Write generic algorithms

### Generic Classes

```java
// Generic class example
public class Box<T> {
    private T content;
    
    public void setContent(T content) {
        this.content = content;
    }
    
    public T getContent() {
        return content;
    }
    
    public static void main(String[] args) {
        // String box
        Box<String> stringBox = new Box<>();
        stringBox.setContent("Hello Generics");
        String stringContent = stringBox.getContent(); // No casting needed
        
        // Integer box
        Box<Integer> intBox = new Box<>();
        intBox.setContent(42);
        Integer intContent = intBox.getContent();
        
        System.out.println("String box: " + stringContent);
        System.out.println("Integer box: " + intContent);
    }
}
```

### Generic Methods

```java
public class GenericMethods {
    
    // Generic method to swap array elements
    public static <T> void swap(T[] array, int i, int j) {
        T temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    
    // Generic method to find maximum
    public static <T extends Comparable<T>> T findMax(T[] array) {
        if (array.length == 0) return null;
        
        T max = array[0];
        for (int i = 1; i < array.length; i++) {
            if (array[i].compareTo(max) > 0) {
                max = array[i];
            }
        }
        return max;
    }
    
    public static void main(String[] args) {
        String[] names = {"Alice", "Bob", "Charlie", "Diana"};
        System.out.println("Before swap: " + Arrays.toString(names));
        swap(names, 0, 2);
        System.out.println("After swap: " + Arrays.toString(names));
        
        Integer[] numbers = {45, 23, 67, 12, 89, 34};
        System.out.println("Maximum number: " + findMax(numbers));
        
        String[] words = {"apple", "zebra", "banana", "orange"};
        System.out.println("Maximum word: " + findMax(words));
    }
}
```

### Wildcards

#### Upper Bounded Wildcards (? extends)

```java
import java.util.*;

public class WildcardExample {
    
    // Method that accepts List of Number or its subtypes
    public static double sumNumbers(List<? extends Number> numbers) {
        double sum = 0.0;
        for (Number num : numbers) {
            sum += num.doubleValue();
        }
        return sum;
    }
    
    // Method that adds numbers to a list (lower bounded)
    public static void addNumbers(List<? super Integer> numbers) {
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
    }
    
    public static void main(String[] args) {
        // Upper bounded wildcard example
        List<Integer> integers = Arrays.asList(1, 2, 3, 4, 5);
        List<Double> doubles = Arrays.asList(1.1, 2.2, 3.3, 4.4, 5.5);
        
        System.out.println("Sum of integers: " + sumNumbers(integers));
        System.out.println("Sum of doubles: " + sumNumbers(doubles));
        
        // Lower bounded wildcard example
        List<Number> numberList = new ArrayList<>();
        addNumbers(numberList);
        System.out.println("Numbers added: " + numberList);
    }
}
```

### Bounded Type Parameters

```java
// Interface for shapes
interface Shape {
    double getArea();
}

// Rectangle class implementing Shape
class Rectangle implements Shape {
    private double width, height;
    
    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }
    
    @Override
    public double getArea() {
        return width * height;
    }
    
    @Override
    public String toString() {
        return "Rectangle(" + width + "x" + height + ")";
    }
}

// Circle class implementing Shape
class Circle implements Shape {
    private double radius;
    
    public Circle(double radius) {
        this.radius = radius;
    }
    
    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
    
    @Override
    public String toString() {
        return "Circle(r=" + radius + ")";
    }
}

// Generic class with bounded type parameter
public class ShapeContainer<T extends Shape> {
    private List<T> shapes;
    
    public ShapeContainer() {
        this.shapes = new ArrayList<>();
    }
    
    public void addShape(T shape) {
        shapes.add(shape);
    }
    
    public double getTotalArea() {
        return shapes.stream().mapToDouble(Shape::getArea).sum();
    }
    
    public void displayShapes() {
        shapes.forEach(System.out::println);
    }
    
    public static void main(String[] args) {
        ShapeContainer<Rectangle> rectangles = new ShapeContainer<>();
        rectangles.addShape(new Rectangle(5, 10));
        rectangles.addShape(new Rectangle(3, 7));
        
        ShapeContainer<Circle> circles = new ShapeContainer<>();
        circles.addShape(new Circle(5));
        circles.addShape(new Circle(3));
        
        System.out.println("Rectangles:");
        rectangles.displayShapes();
        System.out.println("Total area: " + rectangles.getTotalArea());
        
        System.out.println("\nCircles:");
        circles.displayShapes();
        System.out.println("Total area: " + circles.getTotalArea());
    }
}
```

---

## Java 8 Features

### 1. Lambda Expressions

Lambda expressions provide a concise way to represent anonymous functions.

**Syntax**: `(parameters) -> expression` or `(parameters) -> { statements; }`

```java
import java.util.*;
import java.util.function.*;

public class LambdaExamples {
    public static void main(String[] args) {
        List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "Diana", "Eve");
        
        // Traditional approach with anonymous class
        Collections.sort(names, new Comparator<String>() {
            @Override
            public int compare(String a, String b) {
                return a.compareTo(b);
            }
        });
        
        // Lambda expression approach
        Collections.sort(names, (a, b) -> a.compareTo(b));
        // Or even simpler
        Collections.sort(names, String::compareTo);
        
        System.out.println("Sorted names: " + names);
        
        // Lambda with forEach
        System.out.println("Names with forEach:");
        names.forEach(name -> System.out.println("Hello, " + name));
        
        // Lambda with filtering
        System.out.println("Names starting with 'A':");
        names.stream()
             .filter(name -> name.startsWith("A"))
             .forEach(System.out::println);
        
        // Lambda with custom functional interface
        Calculator add = (a, b) -> a + b;
        Calculator multiply = (a, b) -> a * b;
        
        System.out.println("5 + 3 = " + add.calculate(5, 3));
        System.out.println("5 * 3 = " + multiply.calculate(5, 3));
    }
}

@FunctionalInterface
interface Calculator {
    int calculate(int a, int b);
}
```

### 2. Functional Interfaces

Functional interfaces have exactly one abstract method and can be used with lambda expressions.

```java
import java.util.function.*;
import java.util.*;

public class FunctionalInterfaceExamples {
    public static void main(String[] args) {
        // Predicate<T> - takes one argument and returns boolean
        Predicate<Integer> isEven = num -> num % 2 == 0;
        Predicate<String> isLongString = str -> str.length() > 5;
        
        System.out.println("Is 4 even? " + isEven.test(4));
        System.out.println("Is 'Hello World' long? " + isLongString.test("Hello World"));
        
        // Function<T, R> - takes one argument and returns a result
        Function<String, Integer> stringLength = str -> str.length();
        Function<Integer, String> intToHex = num -> Integer.toHexString(num);
        
        System.out.println("Length of 'Java': " + stringLength.apply("Java"));
        System.out.println("255 in hex: " + intToHex.apply(255));
        
        // Consumer<T> - takes one argument and returns no result
        Consumer<String> printer = str -> System.out.println("Processing: " + str);
        List<String> items = Arrays.asList("apple", "banana", "cherry");
        items.forEach(printer);
        
        // Supplier<T> - takes no arguments and returns a result
        Supplier<Double> randomSupplier = () -> Math.random();
        System.out.println("Random number: " + randomSupplier.get());
        
        // BiFunction<T, U, R> - takes two arguments and returns a result
        BiFunction<Integer, Integer, Integer> power = (base, exp) -> {
            int result = 1;
            for (int i = 0; i < exp; i++) {
                result *= base;
            }
            return result;
        };
        
        System.out.println("2^3 = " + power.apply(2, 3));
    }
}
```

### 3. Stream API

Streams provide a functional approach to processing collections of data.

```java
import java.util.*;
import java.util.stream.*;

class Employee {
    private String name;
    private String department;
    private double salary;
    private int age;
    
    public Employee(String name, String department, double salary, int age) {
        this.name = name;
        this.department = department;
        this.salary = salary;
        this.age = age;
    }
    
    // Getters
    public String getName() { return name; }
    public String getDepartment() { return department; }
    public double getSalary() { return salary; }
    public int getAge() { return age; }
    
    @Override
    public String toString() {
        return String.format("Employee{name='%s', dept='%s', salary=%.2f, age=%d}", 
                           name, department, salary, age);
    }
}

public class StreamAPIExamples {
    public static void main(String[] args) {
        List<Employee> employees = Arrays.asList(
            new Employee("Alice Johnson", "IT", 75000, 28),
            new Employee("Bob Smith", "HR", 65000, 35),
            new Employee("Charlie Brown", "IT", 80000, 32),
            new Employee("Diana Prince", "Finance", 70000, 29),
            new Employee("Eve Adams", "IT", 85000, 26),
            new Employee("Frank Miller", "HR", 60000, 40),
            new Employee("Grace Lee", "Finance", 72000, 31)
        );
        
        System.out.println("=== Stream API Examples ===\n");
        
        // 1. Filter employees in IT department
        System.out.println("IT Department Employees:");
        employees.stream()
                 .filter(emp -> emp.getDepartment().equals("IT"))
                 .forEach(System.out::println);
        
        // 2. Find employees with salary > 70000
        System.out.println("\nEmployees with salary > 70000:");
        employees.stream()
                 .filter(emp -> emp.getSalary() > 70000)
                 .map(Employee::getName)
                 .forEach(System.out::println);
        
        // 3. Average salary by department
        System.out.println("\nAverage salary by department:");
        Map<String, Double> avgSalaryByDept = employees.stream()
                .collect(Collectors.groupingBy(
                    Employee::getDepartment,
                    Collectors.averagingDouble(Employee::getSalary)
                ));
        avgSalaryByDept.forEach((dept, avg) -> 
            System.out.printf("%s: $%.2f%n", dept, avg));
        
        // 4. Top 3 highest paid employees
        System.out.println("\nTop 3 highest paid employees:");
        employees.stream()
                 .sorted((e1, e2) -> Double.compare(e2.getSalary(), e1.getSalary()))
                 .limit(3)
                 .forEach(System.out::println);
        
        // 5. Count employees by department
        System.out.println("\nEmployee count by department:");
        Map<String, Long> countByDept = employees.stream()
                .collect(Collectors.groupingBy(
                    Employee::getDepartment,
                    Collectors.counting()
                ));
        countByDept.forEach((dept, count) -> 
            System.out.printf("%s: %d employees%n", dept, count));
        
        // 6. Find youngest employee in each department
        System.out.println("\nYoungest employee in each department:");
        Map<String, Optional<Employee>> youngestByDept = employees.stream()
                .collect(Collectors.groupingBy(
                    Employee::getDepartment,
                    Collectors.minBy(Comparator.comparing(Employee::getAge))
                ));
        youngestByDept.forEach((dept, emp) -> 
            System.out.printf("%s: %s%n", dept, emp.orElse(null)));
        
        // 7. Total salary expense
        double totalSalary = employees.stream()
                .mapToDouble(Employee::getSalary)
                .sum();
        System.out.printf("\nTotal salary expense: $%.2f%n", totalSalary);
        
        // 8. Check if any employee is over 35
        boolean hasEmployeeOver35 = employees.stream()
                .anyMatch(emp -> emp.getAge() > 35);
        System.out.println("Any employee over 35? " + hasEmployeeOver35);
        
        // 9. Parallel stream example
        System.out.println("\nProcessing with parallel stream:");
        employees.parallelStream()
                 .filter(emp -> emp.getSalary() > 70000)
                 .map(emp -> emp.getName().toUpperCase())
                 .sorted()
                 .forEach(System.out::println);
    }
}
```

### 4. Method References

Method references provide a shorthand syntax for lambda expressions.

```java
import java.util.*;
import java.util.function.*;

public class MethodReferenceExamples {
    public static void main(String[] args) {
        List<String> names = Arrays.asList("alice", "bob", "charlie", "diana");
        
        // 1. Static method reference
        System.out.println("=== Static Method Reference ===");
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
        
        // Lambda: numbers.forEach(n -> System.out.println(n));
        numbers.forEach(System.out::println);
        
        // Lambda: numbers.stream().map(n -> String.valueOf(n))
        List<String> stringNumbers = numbers.stream()
                .map(String::valueOf)
                .collect(Collectors.toList());
        System.out.println("String numbers: " + stringNumbers);
        
        // 2. Instance method reference
        System.out.println("\n=== Instance Method Reference ===");
        
        // Lambda: names.stream().map(name -> name.toUpperCase())
        List<String> upperNames = names.stream()
                .map(String::toUpperCase)
                .collect(Collectors.toList());
        System.out.println("Upper case names: " + upperNames);
        
        // Lambda: names.stream().mapToInt(name -> name.length())
        IntSummaryStatistics stats = names.stream()
                .mapToInt(String::length)
                .summaryStatistics();
        System.out.println("Name length statistics: " + stats);
        
        // 3. Constructor reference
        System.out.println("\n=== Constructor Reference ===");
        
        // Lambda: names.stream().map(name -> new StringBuilder(name))
        List<StringBuilder> builders = names.stream()
                .map(StringBuilder::new)
                .collect(Collectors.toList());
        
        builders.forEach(sb -> sb.append(" - processed"));
        builders.forEach(System.out::println);
        
        // 4. Method reference with custom class
        System.out.println("\n=== Custom Class Method Reference ===");
        
        List<Person> people = Arrays.asList(
            new Person("Alice", 25),
            new Person("Bob", 30),
            new Person("Charlie", 22)
        );
        
        // Lambda: people.stream().map(person -> person.getName())
        people.stream()
               .map(Person::getName)
               .forEach(System.out::println);
        
        // Lambda: people.sort((p1, p2) -> p1.getName().compareTo(p2.getName()))
        people.sort(Comparator.comparing(Person::getName));
        System.out.println("Sorted people: " + people);
        
        // 5. Instance method reference of particular object
        System.out.println("\n=== Instance Method of Particular Object ===");
        
        StringProcessor processor = new StringProcessor();
        
        // Lambda: names.stream().map(name -> processor.process(name))
        List<String> processedNames = names.stream()
                .map(processor::process)
                .collect(Collectors.toList());
        System.out.println("Processed names: " + processedNames);
    }
}

class Person {
    private String name;
    private int age;
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public String getName() { return name; }
    public int getAge() { return age; }
    
    @Override
    public String toString() {
        return "Person{name='" + name + "', age=" + age + "}";
    }
}

class StringProcessor {
    public String process(String input) {
        return "[" + input.toUpperCase() + "]";
    }
}
```

### 5. Optional Class

Optional helps avoid NullPointerException and makes null-handling explicit.

```java
import java.util.*;

public class OptionalExamples {
    
    static class User {
        private String name;
        private String email;
        private Address address;
        
        public User(String name, String email, Address address) {
            this.name = name;
            this.email = email;
            this.address = address;
        }
        
        public String getName() { return name; }
        public String getEmail() { return email; }
        public Optional<Address> getAddress() { return Optional.ofNullable(address); }
    }
    
    static class Address {
        private String street;
        private String city;
        private String zipCode;
        
        public Address(String street, String city, String zipCode) {
            this.street = street;
            this.city = city;
            this.zipCode = zipCode;
        }
        
        public String getStreet() { return street; }
        public String getCity() { return city; }
        public String getZipCode() { return zipCode; }
        
        @Override
        public String toString() {
            return street + ", " + city + " " + zipCode;
        }
    }
    
    public static void main(String[] args) {
        List<User> users = Arrays.asList(
            new User("Alice", "alice@email.com", new Address("123 Main St", "New York", "10001")),
            new User("Bob", "bob@email.com", null),
            new User("Charlie", null, new Address("456 Oak Ave", "Boston", "02101"))
        );
        
        System.out.println("=== Optional Examples ===\n");
        
        // 1. Creating Optional instances
        Optional<String> nonEmptyOptional = Optional.of("Hello");
        Optional<String> nullableOptional = Optional.ofNullable(null);
        Optional<String> emptyOptional = Optional.empty();
        
        System.out.println("Non-empty optional: " + nonEmptyOptional);
        System.out.println("Nullable optional: " + nullableOptional);
        System.out.println("Empty optional: " + emptyOptional);
        
        // 2. Checking if value is present
        System.out.println("\n=== Checking Presence ===");
        users.forEach(user -> {
            Optional<String> email = Optional.ofNullable(user.getEmail());
            if (email.isPresent()) {
                System.out.println(user.getName() + " has email: " + email.get());
            } else {
                System.out.println(user.getName() + " has no email");
            }
        });
        
        // 3. Using ifPresent
        System.out.println("\n=== Using ifPresent ===");
        users.forEach(user -> {
            Optional.ofNullable(user.getEmail())
                   .ifPresent(email -> System.out.println("Sending email to: " + email));
        });
        
        // 4. Using orElse and orElseGet
        System.out.println("\n=== Using orElse and orElseGet ===");
        users.forEach(user -> {
            String email = Optional.ofNullable(user.getEmail())
                                 .orElse("no-email@example.com");
            System.out.println(user.getName() + " -> " + email);
            
            String emailFromSupplier = Optional.ofNullable(user.getEmail())
                                             .orElseGet(() -> generateDefaultEmail(user.getName()));
            System.out.println(user.getName() + " (generated) -> " + emailFromSupplier);
        });
        
        // 5. Using orElseThrow
        System.out.println("\n=== Using orElseThrow ===");
        try {
            String email = Optional.ofNullable(users.get(1).getEmail())
                                 .orElseThrow(() -> new RuntimeException("Email not found"));
            System.out.println("Email found: " + email);
        } catch (RuntimeException e) {
            System.out.println("Exception caught: " + e.getMessage());
        }
        
        // 6. Chaining with map and flatMap
        System.out.println("\n=== Chaining with map and flatMap ===");
        users.forEach(user -> {
            // Get city from user's address
            String city = user.getAddress()
                            .map(Address::getCity)
                            .orElse("Unknown City");
            System.out.println(user.getName() + " lives in: " + city);
            
            // Chain multiple operations
            String addressInfo = user.getAddress()
                                   .map(addr -> addr.getCity() + ", " + addr.getZipCode())
                                   .map(String::toUpperCase)
                                   .orElse("NO ADDRESS");
            System.out.println(user.getName() + " address info: " + addressInfo);
        });
        
        // 7. Filtering with Optional
        System.out.println("\n=== Filtering with Optional ===");
        users.forEach(user -> {
            user.getAddress()
                .filter(addr -> addr.getZipCode().startsWith("1"))
                .ifPresent(addr -> System.out.println(user.getName() + " has zip starting with 1: " + addr.getZipCode()));
        });
        
        // 8. Finding first match
        System.out.println("\n=== Finding First Match ===");
        Optional<User> userWithGmail = users.stream()
                .filter(user -> Optional.ofNullable(user.getEmail())
                                      .map(email -> email.contains("gmail"))
                                      .orElse(false))
                .findFirst();
        
        userWithGmail.ifPresentOrElse(
            user -> System.out.println("Found Gmail user: " + user.getName()),
            () -> System.out.println("No Gmail user found")
        );
    }
    
    private static String generateDefaultEmail(String name) {
        return name.toLowerCase().replace(" ", ".") + "@company.com";
    }
}
```

### 6. Date and Time API (java.time)

Java 8 introduced a comprehensive date and time API that's immutable and thread-safe.

```java
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;

public class DateTimeExamples {
    public static void main(String[] args) {
        System.out.println("=== Java 8 Date and Time API ===\n");
        
        // 1. LocalDate - Date without time
        System.out.println("=== LocalDate Examples ===");
        LocalDate today = LocalDate.now();
        LocalDate specificDate = LocalDate.of(2024, 12, 25);
        LocalDate parsedDate = LocalDate.parse("2024-06-15");
        
        System.out.println("Today: " + today);
        System.out.println("Christmas 2024: " + specificDate);
        System.out.println("Parsed date: " + parsedDate);
        
        // Date calculations
        LocalDate nextWeek = today.plusWeeks(1);
        LocalDate lastMonth = today.minusMonths(1);
        System.out.println("Next week: " + nextWeek);
        System.out.println("Last month: " + lastMonth);
        
        // 2. LocalTime - Time without date
        System.out.println("\n=== LocalTime Examples ===");
        LocalTime now = LocalTime.now();
        LocalTime specificTime = LocalTime.of(14, 30, 45);
        LocalTime parsedTime = LocalTime.parse("09:15:30");
        
        System.out.println("Current time: " + now);
        System.out.println("Specific time: " + specificTime);
        System.out.println("Parsed time: " + parsedTime);
        
        // Time calculations
        LocalTime inTwoHours = now.plusHours(2);
        LocalTime thirtyMinutesAgo = now.minusMinutes(30);
        System.out.println("In 2 hours: " + inTwoHours);
        System.out.println("30 minutes ago: " + thirtyMinutesAgo);
        
        // 3. LocalDateTime - Date and time together
        System.out.println("\n=== LocalDateTime Examples ===");
        LocalDateTime currentDateTime = LocalDateTime.now();
        LocalDateTime specificDateTime = LocalDateTime.of(2024, 12, 25, 18, 30, 0);
        LocalDateTime combined = LocalDateTime.of(today, specificTime);
        
        System.out.println("Current date-time: " + currentDateTime);
        System.out.println("Christmas evening: " + specificDateTime);
        System.out.println("Combined: " + combined);
        
        // 4. ZonedDateTime - Date-time with timezone
        System.out.println("\n=== ZonedDateTime Examples ===");
        ZonedDateTime nowInUTC = ZonedDateTime.now(ZoneId.of("UTC"));
        ZonedDateTime nowInNY = ZonedDateTime.now(ZoneId.of("America/New_York"));
        ZonedDateTime nowInTokyo = ZonedDateTime.now(ZoneId.of("Asia/Tokyo"));
        
        System.out.println("UTC: " + nowInUTC);
        System.out.println("New York: " + nowInNY);
        System.out.println("Tokyo: " + nowInTokyo);
        
        // 5. Duration and Period
        System.out.println("\n=== Duration and Period Examples ===");
        LocalTime start = LocalTime.of(9, 0);
        LocalTime end = LocalTime.of(17, 30);
        Duration workDuration = Duration.between(start, end);
        System.out.println("Work duration: " + workDuration.toHours() + " hours " + 
                          (workDuration.toMinutes() % 60) + " minutes");
        
        LocalDate birthDate = LocalDate.of(1990, 5, 15);
        Period age = Period.between(birthDate, today);
        System.out.println("Age: " + age.getYears() + " years " + 
                          age.getMonths() + " months " + age.getDays() + " days");
        
        // 6. Formatting and parsing
        System.out.println("\n=== Formatting Examples ===");
        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy");
        
        String formatted1 = currentDateTime.format(formatter1);
        String formatted2 = today.format(formatter2);
        
        System.out.println("Formatted date-time: " + formatted1);
        System.out.println("Formatted date: " + formatted2);
        
        // Parse formatted strings
        LocalDateTime parsed = LocalDateTime.parse("25-12-2024 18:30:45", formatter1);
        System.out.println("Parsed date-time: " + parsed);
        
        // 7. Temporal adjusters
        System.out.println("\n=== Temporal Adjusters Examples ===");
        LocalDate firstDayOfMonth = today.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate lastDayOfMonth = today.with(TemporalAdjusters.lastDayOfMonth());
        LocalDate nextMonday = today.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        
        System.out.println("First day of month: " + firstDayOfMonth);
        System.out.println("Last day of month: " + lastDayOfMonth);
        System.out.println("Next Monday: " + nextMonday);
        
        // 8. Calculating differences
        System.out.println("\n=== Calculating Differences ===");
        LocalDate startDate = LocalDate.of(2024, 1, 1);
        LocalDate endDate = LocalDate.of(2024, 12, 31);
        
        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
        long weeksBetween = ChronoUnit.WEEKS.between(startDate, endDate);
        long monthsBetween = ChronoUnit.MONTHS.between(startDate, endDate);
        
        System.out.println("Days in 2024: " + daysBetween);
        System.out.println("Weeks in 2024: " + weeksBetween);
        System.out.println("Months between: " + monthsBetween);
    }
}
```

---

## Case Studies

### Case Study 1: Student Management System

```java
import java.util.*;
import java.util.stream.Collectors;

class Student {
    private String id;
    private String name;
    private String department;
    private double cgpa;
    private List<String> subjects;
    
    public Student(String id, String name, String department, double cgpa, List<String> subjects) {
        this.id = id;
        this.name = name;
        this.department = department;
        this.cgpa = cgpa;
        this.subjects = new ArrayList<>(subjects);
    }
    
    // Getters
    public String getId() { return id; }
    public String getName() { return name; }
    public String getDepartment() { return department; }
    public double getCgpa() { return cgpa; }
    public List<String> getSubjects() { return subjects; }
    
    @Override
    public String toString() {
        return String.format("Student{id='%s', name='%s', dept='%s', cgpa=%.2f, subjects=%s}", 
                           id, name, department, cgpa, subjects);
    }
}

public class StudentManagementSystem {
    private List<Student> students;
    
    public StudentManagementSystem() {
        this.students = new ArrayList<>();
        initializeData();
    }
    
    private void initializeData() {
        students.add(new Student("S001", "Alice Johnson", "Computer Science", 3.8, 
                               Arrays.asList("Java", "Database", "Algorithms")));
        students.add(new Student("S002", "Bob Smith", "Electrical Engineering", 3.6, 
                               Arrays.asList("Circuits", "Signals", "Control Systems")));
        students.add(new Student("S003", "Charlie Brown", "Computer Science", 3.9, 
                               Arrays.asList("Java", "Web Development", "Machine Learning")));
        students.add(new Student("S004", "Diana Prince", "Mechanical Engineering", 3.7, 
                               Arrays.asList("Thermodynamics", "Mechanics", "Design")));
        students.add(new Student("S005", "Eve Adams", "Computer Science", 3.5, 
                               Arrays.asList("Database", "Networks", "Security")));
    }
    
    // Find student by ID using Optional
    public Optional<Student> findStudentById(String id) {
        return students.stream()
                      .filter(student -> student.getId().equals(id))
                      .findFirst();
    }
    
    // Get students by department using Stream API
    public List<Student> getStudentsByDepartment(String department) {
        return students.stream()
                      .filter(student -> student.getDepartment().equals(department))
                      .collect(Collectors.toList());
    }
    
    // Get top N students by CGPA
    public List<Student> getTopStudents(int n) {
        return students.stream()
                      .sorted(Comparator.comparing(Student::getCgpa).reversed())
                      .limit(n)
                      .collect(Collectors.toList());
    }
    
    // Group students by department
    public Map<String, List<Student>> groupByDepartment() {
        return students.stream()
                      .collect(Collectors.groupingBy(Student::getDepartment));
    }
    
    // Calculate average CGPA by department
    public Map<String, Double> getAverageCgpaByDepartment() {
        return students.stream()
                      .collect(Collectors.groupingBy(
                          Student::getDepartment,
                          Collectors.averagingDouble(Student::getCgpa)
                      ));
    }
    
    // Find students taking specific subject
    public List<Student> getStudentsBySubject(String subject) {
        return students.stream()
                      .filter(student -> student.getSubjects().contains(subject))
                      .collect(Collectors.toList());
    }
    
    // Get all unique subjects
    public Set<String> getAllSubjects() {
        return students.stream()
                      .flatMap(student -> student.getSubjects().stream())
                      .collect(Collectors.toSet());
    }
    
    public static void main(String[] args) {
        StudentManagementSystem sms = new StudentManagementSystem();
        
        System.out.println("=== Student Management System ===\n");
        
        // Find student by ID
        System.out.println("=== Find Student by ID ===");
        sms.findStudentById("S003")
           .ifPresentOrElse(
               student -> System.out.println("Found: " + student),
               () -> System.out.println("Student not found")
           );
        
        // Get students by department
        System.out.println("\n=== Computer Science Students ===");
        sms.getStudentsByDepartment("Computer Science")
           .forEach(System.out::println);
        
        // Get top 3 students
        System.out.println("\n=== Top 3 Students ===");
        sms.getTopStudents(3)
           .forEach(System.out::println);
        
        // Group by department
        System.out.println("\n=== Students Grouped by Department ===");
        sms.groupByDepartment()
           .forEach((dept, studentList) -> {
               System.out.println(dept + ":");
               studentList.forEach(student -> System.out.println("  " + student.getName()));
           });
        
        // Average CGPA by department
        System.out.println("\n=== Average CGPA by Department ===");
        sms.getAverageCgpaByDepartment()
           .forEach((dept, avg) -> System.out.printf("%s: %.2f%n", dept, avg));
        
        // Students taking Java
        System.out.println("\n=== Students Taking Java ===");
        sms.getStudentsBySubject("Java")
           .forEach(student -> System.out.println(student.getName()));
        
        // All unique subjects
        System.out.println("\n=== All Subjects ===");
        sms.getAllSubjects()
           .stream()
           .sorted()
           .forEach(System.out::println);
    }
}
```

### Case Study 2: E-commerce Order Processing System

```java
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

enum OrderStatus {
    PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
}

class Product {
    private String id;
    private String name;
    private String category;
    private double price;
    
    public Product(String id, String name, String category, double price) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
    }
    
    // Getters
    public String getId() { return id; }
    public String getName() { return name; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
    
    @Override
    public String toString() {
        return String.format("Product{id='%s', name='%s', category='%s', price=$%.2f}", 
                           id, name, category, price);
    }
}

class OrderItem {
    private Product product;
    private int quantity;
    
    public OrderItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
    
    public Product getProduct() { return product; }
    public int getQuantity() { return quantity; }
    
    public double getTotalPrice() {
        return product.getPrice() * quantity;
    }
    
    @Override
    public String toString() {
        return String.format("OrderItem{product=%s, quantity=%d, total=$%.2f}", 
                           product.getName(), quantity, getTotalPrice());
    }
}

class Order {
    private String orderId;
    private String customerId;
    private LocalDateTime orderDate;
    private OrderStatus status;
    private List<OrderItem> items;
    
    public Order(String orderId, String customerId, List<OrderItem> items) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.orderDate = LocalDateTime.now();
        this.status = OrderStatus.PENDING;
        this.items = new ArrayList<>(items);
    }
    
    // Getters
    public String getOrderId() { return orderId; }
    public String getCustomerId() { return customerId; }
    public LocalDateTime getOrderDate() { return orderDate; }
    public OrderStatus getStatus() { return status; }
    public List<OrderItem> getItems() { return items; }
    
    public void setStatus(OrderStatus status) { this.status = status; }
    
    public double getTotalAmount() {
        return items.stream()
                   .mapToDouble(OrderItem::getTotalPrice)
                   .sum();
    }
    
    public int getTotalItems() {
        return items.stream()
                   .mapToInt(OrderItem::getQuantity)
                   .sum();
    }
    
    @Override
    public String toString() {
        return String.format("Order{id='%s', customer='%s', date=%s, status=%s, total=$%.2f, items=%d}", 
                           orderId, customerId, orderDate.toLocalDate(), status, getTotalAmount(), getTotalItems());
    }
}

public class ECommerceOrderSystem {
    private List<Product> products;
    private List<Order> orders;
    
    public ECommerceOrderSystem() {
        this.products = new ArrayList<>();
        this.orders = new ArrayList<>();
        initializeData();
    }
    
    private void initializeData() {
        // Initialize products
        products.addAll(Arrays.asList(
            new Product("P001", "Laptop", "Electronics", 999.99),
            new Product("P002", "Mouse", "Electronics", 29.99),
            new Product("P003", "Keyboard", "Electronics", 79.99),
            new Product("P004", "Book - Java Programming", "Books", 49.99),
            new Product("P005", "Desk Chair", "Furniture", 199.99),
            new Product("P006", "Monitor", "Electronics", 299.99),
            new Product("P007", "Coffee Mug", "Kitchen", 12.99),
            new Product("P008", "Notebook", "Stationery", 5.99)
        ));
        
        // Create sample orders
        createSampleOrders();
    }
    
    private void createSampleOrders() {
        // Order 1
        List<OrderItem> items1 = Arrays.asList(
            new OrderItem(products.get(0), 1), // Laptop
            new OrderItem(products.get(1), 2)  // Mouse x2
        );
        Order order1 = new Order("ORD001", "CUST001", items1);
        order1.setStatus(OrderStatus.DELIVERED);
        orders.add(order1);
        
        // Order 2
        List<OrderItem> items2 = Arrays.asList(
            new OrderItem(products.get(2), 1), // Keyboard
            new OrderItem(products.get(3), 3), // Books x3
            new OrderItem(products.get(6), 2)  // Coffee Mug x2
        );
        Order order2 = new Order("ORD002", "CUST002", items2);
        order2.setStatus(OrderStatus.SHIPPED);
        orders.add(order2);
        
        // Order 3
        List<OrderItem> items3 = Arrays.asList(
            new OrderItem(products.get(4), 1), // Desk Chair
            new OrderItem(products.get(5), 2)  // Monitor x2
        );
        Order order3 = new Order("ORD003", "CUST001", items3);
        order3.setStatus(OrderStatus.PROCESSING);
        orders.add(order3);
        
        // Order 4
        List<OrderItem> items4 = Arrays.asList(
            new OrderItem(products.get(7), 5)  // Notebook x5
        );
        Order order4 = new Order("ORD004", "CUST003", items4);
        orders.add(order4);
    }
    
    // Find orders by customer
    public List<Order> getOrdersByCustomer(String customerId) {
        return orders.stream()
                    .filter(order -> order.getCustomerId().equals(customerId))
                    .collect(Collectors.toList());
    }
    
    // Get orders by status
    public List<Order> getOrdersByStatus(OrderStatus status) {
        return orders.stream()
                    .filter(order -> order.getStatus() == status)
                    .collect(Collectors.toList());
    }
    
    // Calculate total revenue
    public double getTotalRevenue() {
        return orders.stream()
                    .filter(order -> order.getStatus() == OrderStatus.DELIVERED)
                    .mapToDouble(Order::getTotalAmount)
                    .sum();
    }
    
    // Get most popular products
    public Map<Product, Integer> getMostPopularProducts() {
        return orders.stream()
                    .flatMap(order -> order.getItems().stream())
                    .collect(Collectors.groupingBy(
                        OrderItem::getProduct,
                        Collectors.summingInt(OrderItem::getQuantity)
                    ));
    }
    
    // Get revenue by category
    public Map<String, Double> getRevenueByCategory() {
        return orders.stream()
                    .filter(order -> order.getStatus() == OrderStatus.DELIVERED)
                    .flatMap(order -> order.getItems().stream())
                    .collect(Collectors.groupingBy(
                        item -> item.getProduct().getCategory(),
                        Collectors.summingDouble(OrderItem::getTotalPrice)
                    ));
    }
    
    // Get top customers by total spent
    public Map<String, Double> getTopCustomers() {
        return orders.stream()
                    .filter(order -> order.getStatus() == OrderStatus.DELIVERED)
                    .collect(Collectors.groupingBy(
                        Order::getCustomerId,
                        Collectors.summingDouble(Order::getTotalAmount)
                    ))
                    .entrySet().stream()
                    .sorted(Map.Entry.<String, Double>comparingByValue().reversed())
                    .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (e1, e2) -> e1,
                        LinkedHashMap::new
                    ));
    }
    
    // Find high-value orders
    public List<Order> getHighValueOrders(double minAmount) {
        return orders.stream()
                    .filter(order -> order.getTotalAmount() >= minAmount)
                    .sorted(Comparator.comparing(Order::getTotalAmount).reversed())
                    .collect(Collectors.toList());
    }
    
    public static void main(String[] args) {
        ECommerceOrderSystem system = new ECommerceOrderSystem();
        
        System.out.println("=== E-Commerce Order Processing System ===\n");
        
        // Display all orders
        System.out.println("=== All Orders ===");
        system.orders.forEach(System.out::println);
        
        // Orders by customer
        System.out.println("\n=== Orders by Customer CUST001 ===");
        system.getOrdersByCustomer("CUST001")
              .forEach(System.out::println);
        
        // Orders by status
        System.out.println("\n=== Pending Orders ===");
        system.getOrdersByStatus(OrderStatus.PENDING)
              .forEach(System.out::println);
        
        // Total revenue
        System.out.printf("\n=== Total Revenue ===\nTotal Revenue: $%.2f%n", 
                         system.getTotalRevenue());
        
        // Most popular products
        System.out.println("\n=== Most Popular Products ===");
        system.getMostPopularProducts()
              .entrySet().stream()
              .sorted(Map.Entry.<Product, Integer>comparingByValue().reversed())
              .forEach(entry -> System.out.printf("%s: %d units%n", 
                                entry.getKey().getName(), entry.getValue()));
        
        // Revenue by category
        System.out.println("\n=== Revenue by Category ===");
        system.getRevenueByCategory()
              .entrySet().stream()
              .sorted(Map.Entry.<String, Double>comparingByValue().reversed())
              .forEach(entry -> System.out.printf("%s: $%.2f%n", 
                                entry.getKey(), entry.getValue()));
        
        // Top customers
        System.out.println("\n=== Top Customers ===");
        system.getTopCustomers()
              .forEach((customer, amount) -> System.out.printf("%s: $%.2f%n", customer, amount));
        
        // High-value orders
        System.out.println("\n=== High-Value Orders (>$500) ===");
        system.getHighValueOrders(500.0)
              .forEach(System.out::println);
    }
}
```

---

## Practice Assignments

### Assignment 1: Library Management System (Collections & Generics)

**Objective**: Create a library management system using various collections and generics.

**Requirements**:
1. Create classes for `Book`, `Author`, and `Member`
2. Implement a `Library` class with the following operations:
   - Add/remove books and members
   - Search books by title, author, or genre
   - Issue and return books
   - Track overdue books
   - Generate reports

**Tasks**:
```java
// Your implementation should include:

class Book {
    // Fields: id, title, author, genre, isbn, isIssued, issueDate, returnDate
    // Constructor and getter/setter methods
}

class Author {
    // Fields: id, name, nationality, birthYear
    // Constructor and getter/setter methods
}

class Member {
    // Fields: id, name, email, phone, joinDate, issuedBooks
    // Constructor and getter/setter methods
}

class Library<T extends Book> {
    // Use appropriate collections to store books, authors, and members
    // Implement all required operations using generics where appropriate
}
```

**Expected Features**:
- Use `HashMap` for quick book/member lookups
- Use `TreeSet` for sorted book listings
- Use `ArrayList` for member's issued books
- Implement generic methods for searching and filtering
- Use wildcards appropriately

### Assignment 2: Banking System (Java 8 Features)

**Objective**: Create a banking system that extensively uses Java 8 features.

**Requirements**:
1. Create classes for `Account`, `Transaction`, and `Customer`
2. Implement various account types (Savings, Checking, Credit)
3. Use Stream API for all data processing operations
4. Use Optional for null-safe operations
5. Use functional interfaces and lambda expressions

**Tasks**:
```java
// Sample structure:

enum TransactionType {
    DEPOSIT, WITHDRAWAL, TRANSFER, INTEREST
}

class Transaction {
    // Fields: id, accountId, type, amount, date, description
}

class Account {
    // Fields: accountNumber, customerId, balance, accountType, transactions
    // Methods should use Optional for safe operations
}

class Customer {
    // Fields: id, name, email, accounts, registrationDate
}

class BankingSystem {
    // Implement using Stream API:
    // - Find customers by criteria
    // - Calculate total balances
    // - Generate transaction reports
    // - Find top customers by balance
    // - Monthly/yearly transaction summaries
}
```

**Expected Features**:
- Use `Optional` for safe account/customer retrieval
- Use Stream API for all filtering, mapping, and reduction operations
- Implement lambda expressions for custom sorting and filtering
- Use method references where appropriate
- Implement custom functional interfaces for banking operations

### Assignment 3: Employee Payroll System (Comprehensive)

**Objective**: Create a comprehensive payroll system combining all learned concepts.

**Requirements**:
1. Use collections to manage employees, departments, and payroll records
2. Implement generics for type-safe operations
3. Use Java 8 features for data processing and reporting
4. Include date/time operations for payroll calculations

**Tasks**:
```java
// Sample structure to implement:

enum EmployeeType {
    FULL_TIME, PART_TIME, CONTRACT
}

class Employee {
    // Fields: id, name, department, type, salary, hireDate, benefits
}

class Department {
    // Fields: id, name, manager, employees, budget
}

class PayrollRecord {
    // Fields: employeeId, month, year, baseSalary, overtime, deductions, netPay
}

class PayrollSystem {
    // Implement comprehensive payroll operations using all Java 8 features
}
```

**Expected Deliverables**:
1. Complete source code with proper documentation
2. Unit tests for all major operations
3. Performance analysis comparing different collection types
4. Report on benefits of using Java 8 features

### Assignment 4: Social Media Analytics (Advanced)

**Objective**: Build a social media analytics system to process and analyze large datasets.

**Requirements**:
1. Create classes for `User`, `Post`, `Comment`, and `Interaction`
2. Use parallel streams for performance optimization
3. Implement complex aggregations and data mining operations
4. Use advanced generics with multiple type parameters

**Challenges**:
- Process millions of posts efficiently
- Real-time analytics using streaming operations
- Memory-efficient data structures
- Complex relationship mapping between users

### Assignment 5: File Processing System

**Objective**: Create a system that processes various file types using Java 8 features.

**Requirements**:
1. Read and process CSV, JSON, and XML files
2. Use Stream API for file processing
3. Implement error handling with Optional
4. Create custom collectors for data aggregation

**Sample Tasks**:
- Parse log files and generate statistics
- Process sales data from multiple sources
- Generate reports in different formats
- Implement file watching and real-time processing

---

## Additional Practice Problems

### Problem Set 1: Collections Mastery

1. **Implement a LRU Cache** using LinkedHashMap
2. **Create a custom ArrayList** with additional methods
3. **Implement a ThreadSafe HashMap** wrapper
4. **Design a PriorityQueue-based Task Scheduler**
5. **Build a Graph data structure** using Maps and Sets

### Problem Set 2: Generics Challenges

1. **Create a generic Tree data structure** with traversal methods
2. **Implement a type-safe Event System** using generics
3. **Design a generic Repository pattern** for data access
4. **Buil