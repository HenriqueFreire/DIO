import br.com.dio.challenge.domain.Course;

public class Main {
    public static void main(String[] args) {
        // Create a new Course object
        Course course1 = new Course();

        // Use setter methods to set the attributes
        // The data is protected, we can't access it directly
        course1.setTitle("Java Basics");
        course1.setDescription("A course for beginners in Java.");
        course1.setWorkload(8);

        // Use getter methods to retrieve and print the data
        System.out.println("Course Title: " + course1.getTitle());
        System.out.println("Description: " + course1.getDescription());
        System.out.println("Workload: " + course1.getWorkload() + " hours");
    }
}
