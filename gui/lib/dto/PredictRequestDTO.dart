class PredictRequestDTO {
  final int age;
  final double cgpa;
  final int suicidalThoughts;
  final int workStudyHours;
  final int familyHistoryOfMentalIllness;
  final int sleepDurationLessThan5Hours;
  final int dietaryHabitsUnhealthy;
  final int dietaryHabitsHealthy;
  final int degreeGroupBachelor;
  final int degreeGroupMaster;
  final int degreeGroupSchool;
  final int financialStressCategoryLow;
  final int financialStressCategoryHigh;
  final int financialStressCategoryVeryHigh;
  final int regionSouth;
  final int regionEast;
  final int regionNorth;
  final int regionWest;
  final int studySatisfactionCategoryNeutral;
  final int studySatisfactionCategoryVeryDissatisfied;
  final int studySatisfactionCategoryVerySatisfied;
  final int academicPressureCategoryHighPressure;
  final int academicPressureCategoryVeryHighPressure;
  final int academicPressureCategoryLowPressure;

  PredictRequestDTO({
    required this.age,
    required this.cgpa,
    required this.suicidalThoughts,
    required this.workStudyHours,
    required this.familyHistoryOfMentalIllness,
    required this.sleepDurationLessThan5Hours,
    required this.dietaryHabitsUnhealthy,
    required this.dietaryHabitsHealthy,
    required this.degreeGroupBachelor,
    required this.degreeGroupMaster,
    required this.degreeGroupSchool,
    required this.financialStressCategoryLow,
    required this.financialStressCategoryHigh,
    required this.financialStressCategoryVeryHigh,
    required this.regionSouth,
    required this.regionEast,
    required this.regionNorth,
    required this.regionWest,
    required this.studySatisfactionCategoryNeutral,
    required this.studySatisfactionCategoryVeryDissatisfied,
    required this.studySatisfactionCategoryVerySatisfied,
    required this.academicPressureCategoryHighPressure,
    required this.academicPressureCategoryVeryHighPressure,
    required this.academicPressureCategoryLowPressure,
  });

  Map<String, dynamic> toJson() => {
        "Age": age,
        "CGPA": cgpa,
        "Suicidal_thoughts": suicidalThoughts,
        "Work_Study_Hours": workStudyHours,
        "Family_History_of_Mental_Illness": familyHistoryOfMentalIllness,
        "Sleep_Duration_Less_than_5_hours": sleepDurationLessThan5Hours,
        "Dietary_Habits_Unhealthy": dietaryHabitsUnhealthy,
        "Dietary_Habits_Healthy": dietaryHabitsHealthy,
        "degree_group_Bachelor": degreeGroupBachelor,
        "degree_group_Master": degreeGroupMaster,
        "degree_group_School": degreeGroupSchool,
        "Financial_Stress_Category_Low": financialStressCategoryLow,
        "Financial_Stress_Category_High": financialStressCategoryHigh,
        "Financial_Stress_Category_Very_High": financialStressCategoryVeryHigh,
        "region_South": regionSouth,
        "region_East": regionEast,
        "region_North": regionNorth,
        "region_West": regionWest,
        "Study_Satisfaction_Category_Neutral": studySatisfactionCategoryNeutral,
        "Study_Satisfaction_Category_Very_Dissatisfied":
            studySatisfactionCategoryVeryDissatisfied,
        "Study_Satisfaction_Category_Very_Satisfied":
            studySatisfactionCategoryVerySatisfied,
        "Academic_Pressure_Category_High_Pressure":
            academicPressureCategoryHighPressure,
        "Academic_Pressure_Category_Very_High_Pressure":
            academicPressureCategoryVeryHighPressure,
        "Academic_Pressure_Category_Low_Pressure":
            academicPressureCategoryLowPressure,
      };
}
