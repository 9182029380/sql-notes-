# Java Lab Exercises: Trip Management Application
## Complete Guide to Arrays, Strings, and OOP Basics

---

## **Lab Overview**
In this comprehensive lab series, you'll build a **Trip Management Application** that helps users plan and manage their travel itineraries. Through this project, you'll master fundamental Java concepts including Arrays, Strings, and Object-Oriented Programming principles.

---

## **Lab 1: Arrays in Java**

### **Definition**
Arrays in Java are data structures that store multiple elements of the same type in a contiguous memory location. They provide indexed access to elements and have a fixed size once declared.

### **Key Concepts**
- **Declaration**: `dataType[] arrayName` or `dataType arrayName[]`
- **Initialization**: `new dataType[size]` or `{element1, element2, ...}`
- **Access**: `arrayName[index]` (0-based indexing)
- **Length**: `arrayName.length`

### **Example: Basic Trip Destinations Array**
```java
public class TripDestinations {
    public static void main(String[] args) {
        // Declaration and initialization
        String[] destinations = {"Paris", "Tokyo", "New York", "London", "Sydney"};
        
        // Alternative way
        String[] popularDestinations = new String[5];
        popularDestinations[0] = "Rome";
        popularDestinations[1] = "Barcelona";
        popularDestinations[2] = "Amsterdam";
        popularDestinations[3] = "Bangkok";
        popularDestinations[4] = "Dubai";
        
        // Display destinations
        System.out.println("Available Destinations:");
        for(int i = 0; i < destinations.length; i++) {
            System.out.println((i+1) + ". " + destinations[i]);
        }
        
        // Enhanced for loop
        System.out.println("\nPopular Destinations:");
        for(String destination : popularDestinations) {
            System.out.println("- " + destination);
        }
    }
}
```

### **MCQ Questions**

**Question 1:** What is the correct way to declare an array of integers in Java?
A) `int array[];`
B) `int[] array;`
C) `array int[];`
D) Both A and B

**Answer: D** - Both `int array[]` and `int[] array` are valid declarations.

**Question 2:** What will be the output of the following code?
```java
int[] numbers = {10, 20, 30, 40};
System.out.println(numbers.length);
```
A) 3
B) 4
C) 40
D) Compilation error

**Answer: B** - The array has 4 elements, so `length` returns 4.

### **Tasks**

**Task 1: Trip Expense Tracker**
Create a program that:
- Stores daily expenses for a 7-day trip in an array
- Calculates total expenses
- Finds the day with maximum expense
- Calculates average daily expense

**Task 2: Multi-Destination Trip Planner**
Create a program that:
- Uses a 2D array to store trip information (destination, duration in days, estimated cost)
- Allows user to add new trips
- Displays all planned trips in a formatted table
- Calculates total trip duration and cost

---

## **Lab 2: Strings in Java**

### **Definition**
Strings in Java are objects that represent sequences of characters. They are immutable, meaning once created, their value cannot be changed. Java provides extensive methods for string manipulation.

### **Key Concepts**
- **Immutability**: Strings cannot be modified after creation
- **String Pool**: Java maintains a pool of string literals for memory efficiency
- **Common Methods**: `length()`, `charAt()`, `substring()`, `indexOf()`, `toUpperCase()`, `toLowerCase()`, `trim()`, `split()`, `equals()`, `compareTo()`

### **Example: Trip Information Processing**
```java
public class TripStringOperations {
    public static void main(String[] args) {
        String tripInfo = "  Paris-France-5days-1500USD  ";
        
        // Basic operations
        System.out.println("Original: '" + tripInfo + "'");
        System.out.println("Length: " + tripInfo.length());
        System.out.println("Trimmed: '" + tripInfo.trim() + "'");
        
        // Processing trip details
        String cleanInfo = tripInfo.trim();
        String[] details = cleanInfo.split("-");
        
        System.out.println("\nTrip Details:");
        System.out.println("Destination: " + details[0]);
        System.out.println("Country: " + details[1]);
        System.out.println("Duration: " + details[2]);
        System.out.println("Cost: " + details[3]);
        
        // String formatting
        String formattedTrip = String.format("Trip to %s, %s for %s costs %s", 
                                           details[0], details[1], details[2], details[3]);
        System.out.println("\nFormatted: " + formattedTrip);
        
        // String comparison
        String destination1 = "Paris";
        String destination2 = "paris";
        System.out.println("\nCase sensitive comparison: " + destination1.equals(destination2));
        System.out.println("Case insensitive comparison: " + destination1.equalsIgnoreCase(destination2));
    }
}
```

### **MCQ Questions**

**Question 1:** Which method is used to compare two strings for equality in Java?
A) `==`
B) `equals()`
C) `compareTo()`
D) `compare()`

**Answer: B** - `equals()` method compares the actual content of strings.

**Question 2:** What is the result of the following code?
```java
String str = "Hello World";
System.out.println(str.substring(6, 11));
```
A) World
B) Worl
C) orld
D) World!

**Answer: A** - `substring(6, 11)` extracts characters from index 6 to 10 (end index is exclusive).

### **Tasks**

**Task 1: Trip Itinerary Parser**
Create a program that:
- Takes a trip itinerary string like "Day1:Museum,Day2:Beach,Day3:Shopping"
- Parses and displays each day's activities
- Counts total activities
- Allows searching for specific activities

**Task 2: Travel Document Validator**
Create a program that:
- Validates passport numbers (format: 2 letters + 6 digits)
- Checks email format for booking confirmations
- Formats traveler names (proper case)
- Generates booking reference codes

---

## **Lab 3: Object-Oriented Programming Basics**

### **Definition**
Object-Oriented Programming (OOP) is a programming paradigm based on the concept of objects, which contain data (attributes) and code (methods). The four main principles are Encapsulation, Inheritance, Polymorphism, and Abstraction.

### **Key Concepts**
- **Class**: Blueprint for creating objects
- **Object**: Instance of a class
- **Encapsulation**: Bundling data and methods, hiding internal details
- **Inheritance**: Creating new classes based on existing ones
- **Polymorphism**: Same interface, different implementations
- **Abstraction**: Hiding complex implementation details

### **Example: Trip Management System Classes**

```java
// Base class for all trip-related entities
class Trip {
    // Private fields (Encapsulation)
    private String destination;
    private int duration;
    private double cost;
    private String travelerName;
    
    // Constructor
    public Trip(String destination, int duration, double cost, String travelerName) {
        this.destination = destination;
        this.duration = duration;
        this.cost = cost;
        this.travelerName = travelerName;
    }
    
    // Getter methods (Encapsulation)
    public String getDestination() { return destination; }
    public int getDuration() { return duration; }
    public double getCost() { return cost; }
    public String getTravelerName() { return travelerName; }
    
    // Setter methods (Encapsulation)
    public void setDestination(String destination) { this.destination = destination; }
    public void setDuration(int duration) { this.duration = duration; }
    public void setCost(double cost) { this.cost = cost; }
    public void setTravelerName(String travelerName) { this.travelerName = travelerName; }
    
    // Method to display trip information
    public void displayTripInfo() {
        System.out.println("=== Trip Information ===");
        System.out.println("Traveler: " + travelerName);
        System.out.println("Destination: " + destination);
        System.out.println("Duration: " + duration + " days");
        System.out.println("Cost: $" + cost);
    }
    
    // Method to calculate cost per day
    public double getCostPerDay() {
        return cost / duration;
    }
}

// Specialized trip class (Inheritance)
class BusinessTrip extends Trip {
    private String company;
    private boolean isReimbursable;
    
    public BusinessTrip(String destination, int duration, double cost, 
                       String travelerName, String company, boolean isReimbursable) {
        super(destination, duration, cost, travelerName); // Call parent constructor
        this.company = company;
        this.isReimbursable = isReimbursable;
    }
    
    public String getCompany() { return company; }
    public boolean isReimbursable() { return isReimbursable; }
    
    // Method overriding (Polymorphism)
    @Override
    public void displayTripInfo() {
        super.displayTripInfo(); // Call parent method
        System.out.println("Company: " + company);
        System.out.println("Reimbursable: " + (isReimbursable ? "Yes" : "No"));
    }
}

// Another specialized trip class
class VacationTrip extends Trip {
    private String[] activities;
    private String accommodationType;
    
    public VacationTrip(String destination, int duration, double cost, 
                       String travelerName, String[] activities, String accommodationType) {
        super(destination, duration, cost, travelerName);
        this.activities = activities;
        this.accommodationType = accommodationType;
    }
    
    public String[] getActivities() { return activities; }
    public String getAccommodationType() { return accommodationType; }
    
    @Override
    public void displayTripInfo() {
        super.displayTripInfo();
        System.out.println("Accommodation: " + accommodationType);
        System.out.print("Activities: ");
        for(int i = 0; i < activities.length; i++) {
            System.out.print(activities[i]);
            if(i < activities.length - 1) System.out.print(", ");
        }
        System.out.println();
    }
}

// Main class to demonstrate OOP concepts
public class TripManagementSystem {
    public static void main(String[] args) {
        // Creating objects
        Trip generalTrip = new Trip("London", 5, 2000.0, "John Doe");
        BusinessTrip businessTrip = new BusinessTrip("Tokyo", 3, 3000.0, 
                                                     "Jane Smith", "TechCorp", true);
        
        String[] activities = {"Sightseeing", "Beach", "Museum", "Local Cuisine"};
        VacationTrip vacationTrip = new VacationTrip("Bali", 7, 1800.0, 
                                                     "Mike Johnson", activities, "Resort");
        
        // Demonstrating polymorphism
        Trip[] allTrips = {generalTrip, businessTrip, vacationTrip};
        
        for(Trip trip : allTrips) {
            trip.displayTripInfo(); // Calls appropriate overridden method
            System.out.println("Cost per day: $" + String.format("%.2f", trip.getCostPerDay()));
            System.out.println();
        }
    }
}
```

### **MCQ Questions**

**Question 1:** Which OOP principle is demonstrated when a class hides its internal data and provides public methods to access it?
A) Inheritance
B) Polymorphism
C) Encapsulation
D) Abstraction

**Answer: C** - Encapsulation involves hiding internal data and providing controlled access through methods.

**Question 2:** In Java, what keyword is used to inherit from a parent class?
A) implements
B) extends
C) inherits
D) super

**Answer: B** - The `extends` keyword is used for class inheritance in Java.

### **Tasks**

**Task 1: Complete Trip Booking System**
Create a comprehensive system with:
- `Traveler` class with personal information
- `Booking` class that manages trip reservations
- `Hotel` and `Flight` classes for different services
- Methods to calculate total booking cost
- Booking confirmation and cancellation features

**Task 2: Trip Review and Rating System**
Develop a system that includes:
- `Review` class with rating, comment, and reviewer details
- `Destination` class that aggregates reviews
- Methods to calculate average ratings
- Feature to filter reviews by rating
- Display top-rated destinations

---

## **Integration Project: Complete Trip Management Application**

### **Final Challenge**
Combine all concepts learned to create a complete Trip Management Application that includes:

1. **Array Management**: Store multiple trips, travelers, and destinations
2. **String Processing**: Handle user input, format outputs, validate data
3. **OOP Implementation**: Use proper class design with inheritance and polymorphism

### **Application Features**
- Add new trips (business or vacation)
- View all trips with formatted display
- Search trips by destination or traveler
- Calculate trip statistics (total cost, average duration)
- Generate trip reports
- Manage traveler profiles

### **Sample Output**
```
=== Trip Management System ===
1. Add New Trip
2. View All Trips  
3. Search Trips
4. Trip Statistics
5. Generate Report
6. Exit

Enter your choice: 2

=== All Trips ===
Trip #1:
Traveler: John Doe
Destination: London
Duration: 5 days
Cost: $2000.00
Cost per day: $400.00
Type: General Trip

Trip #2:
Traveler: Jane Smith  
Destination: Tokyo
Duration: 3 days
Cost: $3000.00
Cost per day: $1000.00
Type: Business Trip
Company: TechCorp
Reimbursable: Yes
```

---

## **Learning Outcomes**
After completing these labs, students will be able to:

1. **Arrays**: Declare, initialize, and manipulate single and multi-dimensional arrays
2. **Strings**: Perform string operations, parsing, and validation
3. **OOP Basics**: Design classes, implement inheritance, and use polymorphism
4. **Integration**: Combine multiple concepts to build real-world applications
5. **Problem Solving**: Break down complex problems into manageable components

---

## **Best Practices Learned**
- Proper naming conventions
- Code organization and structure
- Error handling techniques
- Memory management considerations
- Documentation and commenting
- Testing and debugging strategies

---

## **Next Steps**
- Advanced OOP concepts (Abstract classes, Interfaces)
- Exception handling
- File I/O operations
- Collections Framework
- GUI development with Swing/JavaFX