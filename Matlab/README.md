# MATLAB® code

The MATLAB® section of this workflow has been developed to facilitate model building and rapid iteration between different versions of a model. In this workflow we use one main script, "Run_main.m", that calls all the relevant functions to be used.

## Getting Started

To run the MATLAB® code, the Subcellular Workflow repository should be added to the MATLAB® path. Running the script "Run_main.m" generates a prompt in the MATLAB® terminal, which requires user input to choose between the numbered options.

These prompts allow you to choose:

### 1. Model Selection

Choose the model to use from all the models in the "Matlab/model" folder.

The first time you run a model, you need to add the folder for a specific model from its home repository (e.g., copy the folder "Model_nair_2016" from its repository to "Matlab/model/").

Implemented models are available at:
- [Fujita_2010 model](https://github.com/jpgsantos/Model_Fujita_2010/)
- [Nair_2016 model](https://github.com/jpgsantos/Model_Nair_2016/)
- [Viswan_2018 model](https://github.com/jpgsantos/Model_Viswan_2018/)

### 2. Analysis Selection

Choose the analysis to be performed:

1. **Diagnostics** - [Documentation](https://subcellular-workflow.readthedocs.io/en/development/Diagnostics.html)
   Basic model evaluation and validation.

2. **Parameter Estimation** - [Documentation](https://subcellular-workflow.readthedocs.io/en/development/param_ext.html)
   Optimization of model parameters using multiple algorithms.

3. **Global Sensitivity Analysis** - [Documentation](https://subcellular-workflow.readthedocs.io/en/development/gsa.html)
   Evaluates parameter sensitivity across the parameter space.

4. **Reproduction of a Previous Analysis**
   Re-do an analysis that has previously been performed. Useful for reproducibility and when code gets updated with extra functionalities. The user should specify the analysis file they want to use; examples are provided in each model repository.

5. **Reproduction of the Plots of a Previous Analysis**
   Similar to option 4 but only regenerates the plots.

### 3. Settings Selection

Choose the [settings file](https://subcellular-workflow.readthedocs.io/en/master/Settings_file.html) to use on the model.

Settings files can be found in:
- The respective model repository in "Matlab/Settings"
- The example model from our main repository in "Matlab/model/Model_Example/Matlab/Settings"
- Direct links to settings files:
  - [Example model settings](https://github.com/jpgsantos/Subcellular_workflow/tree/master/Matlab/Model/Model_Example/Matlab/Settings)
  - [Fujita_2010 model settings](https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab/Settings)
  - [Nair_2016 model settings](https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab/Settings)
  - [Viswan_2018 model settings](https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab/Settings)

## Example Results

Examples of the output received when different models are run through the workflow can be found in the respective model repository in "Matlab/Results/Results/Examples", or at these links:

- [Fujita_2010 model example results](https://github.com/jpgsantos/Model_Fujita_2010/tree/master/Matlab/Results/Examples)
- [Nair_2016 model example results](https://github.com/jpgsantos/Model_Nair_2016/tree/master/Matlab/Results/Examples)
- [Viswan_2018 model example results](https://github.com/jpgsantos/Model_Viswan_2018/tree/master/Matlab/Results/Examples)

## Documentation

To gain a better understanding of how the code works, please refer to our [online documentation](https://subcellular-workflow.readthedocs.io/).