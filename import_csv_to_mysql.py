
import mysql.connector
import pandas as pd
import os

# Database connectie
conn = mysql.connector.connect(
    host="localhost",
    user="root",  # <-- Pas aan
    password="root",  # <-- Pas aan
    database="EurocapsLP",
    port=8889
)

cursor = conn.cursor()

# Pad naar je map met CSV-bestanden
csv_folder = "/Users/lukepeeks/Downloads/Eurocaps./"

# Eerst alle tabellen leegmaken in de juiste volgorde i.v.m. foreign keys
tables_to_clear = [
    "Grinding_Product", "Filling_Product", "Packaging_Product",
    "Grinding", "Filling", "Packaging",
    "ProductieBatch", "LeveringRegel", "Levering",
    "Product", "PartnerContact", "Partner",
    "SoortProduct", "SoortPartner"
]

tables = [
    "SoortPartner", "SoortProduct",
    "Partner", "PartnerContact",
    "Product", "Levering",
    "LeveringRegel", "ProductieBatch",
    "Grinding", "Filling", "Packaging",
    "Grinding_Product", "Filling_Product", "Packaging_Product"
]

# Loop door alle tabellen
for table in tables:
    csv_path = os.path.join(csv_folder, f"{table}.csv")

    # Debugging: Print het pad dat je probeert te openen
    print(f"Probeer bestand te openen: {csv_path}")

    # 👉 Check of het bestand wel bestaat
    if not os.path.exists(csv_path):
        print(f"⚠️ Bestand niet gevonden: {csv_path}, overslaan.")
        continue

    df = pd.read_csv(csv_path)

    placeholders = "(" + ", ".join(["%s"] * len(df.columns)) + ")"
    query = f"INSERT INTO {table} VALUES {placeholders}"

    print(f"Invoegen in: {table}")
    for row in df.itertuples(index=False, name=None):
        try:
            cursor.execute(query, row)
        except mysql.connector.IntegrityError as e:
            print(f"Fout in {table}: {e}")

# Commit de gegevens
conn.commit()

cursor.close()
conn.close()

print("✅ Alle CSV-data succesvol geïmporteerd!")
