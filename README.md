# Data-Science

A collection of Jupyter notebooks and datasets covering core data science workflows — from data cleaning and feature engineering to exploratory analysis, visualization, and SQL querying.

## 📁 Repository Structure

```
Data-Science/
├── Dataset/                        # Raw and supporting datasets
├── SQL/                             # SQL scripts/queries
├── Analysis.ipynb                   # Exploratory data analysis
├── Conditional Filtering.ipynb      # Filtering data with conditions
├── Data Cleaning.ipynb              # Data cleaning workflows
├── Feature Engineering.ipynb        # Creating and transforming features
├── NumPy.ipynb                      # NumPy fundamentals and exercises
├── Pandas.ipynb                     # Pandas fundamentals and exercises
├── visualization.ipynb              # Data visualization examples
├── hr_cleaned_data.csv              # Cleaned HR dataset (CSV)
├── hr_cleaned_data.json             # Cleaned HR dataset (JSON)
├── hr_cleaned_data.xlsx             # Cleaned HR dataset (Excel)
└── salary_bonus.png                 # Visualization output (salary vs. bonus)
```

## 📌 Overview

This repository is a practical, hands-on collection of notebooks built around an **HR dataset**, walking through a typical data science pipeline:

1. **Data Cleaning** — Handling missing values, duplicates, and inconsistent formatting (`Data Cleaning.ipynb`).
2. **Conditional Filtering** — Slicing and filtering data based on business logic (`Conditional Filtering.ipynb`).
3. **Feature Engineering** — Deriving new features to support analysis and modeling (`Feature Engineering.ipynb`).
4. **Exploratory Analysis** — Summary statistics and insights from the cleaned dataset (`Analysis.ipynb`).
5. **Visualization** — Charts and plots (e.g., salary vs. bonus) to communicate findings (`visualization.ipynb`, `salary_bonus.png`).
6. **NumPy & Pandas Practice** — Standalone notebooks for practicing core library operations (`NumPy.ipynb`, `Pandas.ipynb`).
7. **SQL** — Querying and analyzing data using SQL (`SQL/`).

The cleaned dataset is provided in three formats (`.csv`, `.json`, `.xlsx`) for flexibility depending on the tool being used.

## 🛠️ Tech Stack

- **Python** (NumPy, Pandas, Matplotlib/Seaborn or similar for visualization)
- **Jupyter Notebook**
- **SQL**

## 🚀 Getting Started

### Prerequisites

- Python 3.x
- Jupyter Notebook or JupyterLab
- Recommended packages:
  ```bash
  pip install numpy pandas matplotlib seaborn openpyxl jupyter
  ```

### Running the Notebooks

1. Clone the repository:
   ```bash
   git clone https://github.com/BIDUR2062/Data-Science.git
   cd Data-Science
   ```
2. Launch Jupyter:
   ```bash
   jupyter notebook
   ```
3. Open any notebook (e.g., `Data Cleaning.ipynb`) and run the cells in order.

## 📊 Dataset

The core dataset used across these notebooks is an **HR dataset**, available in the `Dataset/` folder as raw data and at the repository root as cleaned output (`hr_cleaned_data.csv`, `.json`, `.xlsx`).

## 📈 Sample Output

`salary_bonus.png` shows a visualization exploring the relationship between salary and bonus from the analysis notebooks.

## 🤝 Contributing

This is primarily a personal learning/practice repository. Suggestions and improvements are welcome via issues or pull requests.

## 📄 License

No license has been specified for this repository. Feel free to reach out to the repository owner for usage permissions.
