# Workflow of Simulation
## Simulation code
The simulations/run_simulation.R file is used to generate simulations to compare wald, bootstrap non-parametric and bootstrap t interval in estimating parameters in linear model.
The code is based on functions from source/01_simulate_data.R to generate simulation data, source/02_apply_method.R to implement 3 methods above and source/03_extract_estimates.R to clean results.
The simulated results are stored as .rds in data folder by default.

## Data Analysis
analysis/HW1_simulation.Rmd is used to check the performance of the 3 methods by a series of tables and plots.
