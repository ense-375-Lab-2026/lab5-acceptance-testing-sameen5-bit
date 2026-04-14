## User Acceptance Test Matrix for BMI Calculator (Imperial)

The following table outlines a set of test cases for the imperial BMI calculator
implemented in this repository. Each test includes a unique identifier, the
objective of the test, the steps a user should perform, the expected result and
classification, a column for recording the actual result once the test is run,
and a pass/fail indicator. The matrix covers both happy‑path scenarios and
unhappy paths involving missing or invalid input.

| ID | Objective | Steps | Expected Result | Actual Result | Pass |
|---|---|---|---|---|---|
| **1** | Calculate BMI – Healthy Range | Select **5 ft** in the feet dropdown, **9 in** in the inches dropdown, enter **165** in the weight field, then press **Calculate**. | The app computes a BMI of approximately **24.35** and displays “Healthy Weight Range”. The numeric result is rounded to two decimal places. | | |
| **2** | Calculate BMI – Underweight | Select **5 ft** and **9 in**, enter **120** lbs, press **Calculate**. | The app computes a BMI of approximately **17.72** and displays “Underweight”. | | |
| **3** | Calculate BMI – Overweight | Select **5 ft** and **9 in**, enter **190** lbs, press **Calculate**. | The app computes a BMI of approximately **28.07** and displays “Overweight”. | | |
| **4** | Calculate BMI – Severely Overweight | Select **5 ft 4 in**, enter **210** lbs, press **Calculate**. | The app computes a BMI greater than **30** (≈ **36.03**) and displays “Severely Overweight”. | | |
| **5** | Missing feet value | Leave the feet dropdown unselected, select any inches value and enter any weight, then press **Calculate**. | An error message appears containing **“enter feet”**. No BMI is computed. | | |
| **6** | Missing inches value | Select a feet value and leave the inches dropdown unselected, enter any weight, press **Calculate**. | An error message appears containing **“enter inches”**. No BMI is computed. | | |
| **7** | Missing weight value | Select feet and inches, leave the weight field empty, press **Calculate**. | An error message appears containing **“enter weight”**. No BMI is computed. | | |
| **8** | Multiple missing values | Leave all fields blank and press **Calculate**. | The error message lists all missing fields: “enter feet”, “enter inches”, and “enter weight”. | | |