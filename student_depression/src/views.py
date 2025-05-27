# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# import json
# from .utils import predict_depression

# @csrf_exempt
# def predict_view(request):
#     if request.method == 'POST':
#         try:
#             data = json.loads(request.body)
#             result = predict_depression(data)
#             return JsonResponse({'prediction': int(result)})
#         except Exception as e:
#             return JsonResponse({'error': str(e)}, status=400)
#     return JsonResponse({'message': 'Only POST method allowed'}, status=405)

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
import pandas as pd

from .serializers import PredictInputSerializer

# Giả sử bạn đã load model sẵn
import joblib
import os

model_path = os.path.join(os.path.dirname(__file__), 'best_random_forest_model.pkl')
model = joblib.load(model_path)
MAP_FIELDS = {
    'Age': 'Age',
    'CGPA': 'CGPA',
    'Suicidal_thoughts': 'Suicidal thoughts',
    'Work_Study_Hours': 'Work/Study Hours',
    'Family_History_of_Mental_Illness': 'Family History of Mental Illness',
    'Sleep_Duration_Less_than_5_hours': 'Sleep Duration_Less than 5 hours',
    'Dietary_Habits_Unhealthy': 'Dietary Habits_Unhealthy',
    'Dietary_Habits_Healthy': 'Dietary Habits_Healthy',
    'degree_group_Bachelor': 'degree_group_Bachelor',
    'degree_group_Master': 'degree_group_Master',
    'degree_group_School': 'degree_group_School',
    'Financial_Stress_Category_Low': 'Financial_Stress_Category_Low',
    'Financial_Stress_Category_High': 'Financial_Stress_Category_High',
    'Financial_Stress_Category_Very_High': 'Financial_Stress_Category_Very High',
    'region_South': 'region_South',
    'region_East': 'region_East',
    'region_North': 'region_North',
    'region_West': 'region_West',
    'Study_Satisfaction_Category_Neutral': 'Study_Satisfaction_Category_Neutral',
    'Study_Satisfaction_Category_Very_Dissatisfied': 'Study_Satisfaction_Category_Very Dissatisfied',
    'Study_Satisfaction_Category_Very_Satisfied': 'Study_Satisfaction_Category_Very Satisfied',
    'Academic_Pressure_Category_High_Pressure': 'Academic_Pressure_Category_High Pressure',
    'Academic_Pressure_Category_Very_High_Pressure': 'Academic_Pressure_Category_Very High Pressure',
    'Academic_Pressure_Category_Low_Pressure': 'Academic_Pressure_Category_Low Pressure',
}
class PredictView(APIView):
    def post(self, request):
        serializer = PredictInputSerializer(data=request.data)
        if serializer.is_valid():
            data = serializer.validated_data
            data_renamed = {MAP_FIELDS[k]: v for k, v in data.items()}
            # Tạo DataFrame đúng format model
            df = pd.DataFrame([data_renamed])
            # Đảm bảo thứ tự cột đúng
            df = df[model.feature_names_in_]

            prediction = model.predict(df)[0]
            prob = model.predict_proba(df)[0]

            return Response({
                "prediction": int(prediction),
                "prob_no_depression": float(prob[0]),
                "prob_depression": float(prob[1]),
            })
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
