import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: GradeCalculator(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Student {
  String name;
  int id;
  double grade1;
  double grade2;
  double grade3;

  Student(this.name, this.id, this.grade1, this.grade2, this.grade3);

  void displayInfo() {
    print("Student: $name");
    print("ID Number: $id");
  }
}

double computeGrade(double g1, double g2, double g3) {
  return (g1 + g2 + g3) / 3;
}

class GradeCalculator extends StatefulWidget {
  const GradeCalculator({super.key});

  @override
  State<GradeCalculator> createState() => _GradeCalculatorState();
}

class _GradeCalculatorState extends State<GradeCalculator> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final grade1Controller = TextEditingController();
  final grade2Controller = TextEditingController();
  final grade3Controller = TextEditingController();

  String result = "";

  void calculateGrade() {
    String name = nameController.text;
    int id = int.parse(idController.text);
    double grade1 = double.parse(grade1Controller.text);
    double grade2 = double.parse(grade2Controller.text);
    double grade3 = double.parse(grade3Controller.text);

    Student student = Student(name, id, grade1, grade2, grade3);
    student.displayInfo();

    List<double> grades = [grade1, grade2, grade3];
    double average = computeGrade(grade1, grade2, grade3);

    String status;

    if (average >= 75) {
      status = "Passed";
    } else if (average >= 70) {
      status = "Conditional";
    } else {
      status = "Failed";
    }

    String gradeList = "";

    for (int i = 0; i < grades.length; i++) {
      gradeList += "Subject ${i + 1}: ${grades[i]}\n";
    }

    setState(() {
      result =
          "Student Name: $name\n"
          "ID Number: $id\n\n"
          "$gradeList\n"
          "Average Grade: ${average.toStringAsFixed(2)}\n"
          "Status: $status";
    });
  }

  Widget inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Grade Calculator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            inputField("Full Name", nameController),
            inputField("ID Number", idController),
            inputField("Subject 1 Grade", grade1Controller),
            inputField("Subject 2 Grade", grade2Controller),
            inputField("Subject 3 Grade", grade3Controller),
            ElevatedButton(
              onPressed: calculateGrade,
              child: const Text("Calculate Grade"),
            ),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
