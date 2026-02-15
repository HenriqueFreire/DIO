import argparse
import os
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
import matplotlib.pyplot as plt

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--data-path", type=str, help="Path to input data")
    parser.add_argument("--model-output", type=str, default="./outputs", help="Path to save output model")
    args = parser.parse_args()

    # Create dummy data if no path provided (for testing/automation setup)
    if args.data_path is None or not os.path.exists(args.data_path):
        print("Data path not provided or not found. Generating dummy DAILY data for corn prices...")
        dates = pd.date_range(start='2023-01-01', periods=200, freq='B')
        prices = 70 + np.cumsum(np.random.normal(0, 1.5, 200)) 
        df = pd.DataFrame({
            'Data': dates, 
            'Preco_Real_R$': prices, 
            'Dia': dates.day,
            'Mes': dates.month, 
            'Ano': dates.year,
            'Dia_Semana': dates.dayofweek
        })
    else:
        df = pd.read_csv(args.data_path)

    # Feature engineering for daily data
    day_col = 'Dia' if 'Dia' in df.columns else 'Day'
    month_col = 'Mes' if 'Mes' in df.columns else 'Month'
    year_col = 'Ano' if 'Ano' in df.columns else 'Year'
    weekday_col = 'Dia_Semana' if 'Dia_Semana' in df.columns else 'DayOfWeek'
    price_col = 'Preco_Real_R$' if 'Preco_Real_R$' in df.columns else 'Price'

    # Filter available columns to avoid errors if some are missing
    features = [f for f in [day_col, month_col, year_col, weekday_col] if f in df.columns]
    X = df[features]
    y = df[price_col]

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Train model
    model = LinearRegression()
    model.fit(X_train, y_train)

    # Evaluate
    y_pred = model.predict(X_test)
    mse = mean_squared_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)

    print(f"MSE: {mse}")
    print(f"R2: {r2}")

    # Save outputs
    os.makedirs(args.model_output, exist_ok=True)
    # In a real scenario, you'd save the model using joblib.dump()
    print(f"Model trained and metrics calculated. Saving to {args.model_output}")

if __name__ == "__main__":
    main()
