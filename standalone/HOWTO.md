## How to use the standalone model framework

### Standalone models

Standalone models can be used to run simulations which only require a subset of modules coming with the model. It can also be used to run a module isolated from the rest of the code.

A new standalone model is created by copying the template.gms within the standalone folder to a gms file with the name of the new model. The new model file needs to include all modules relevant for the calculation (done by adding a line for each module in the "MODULE SETUP" section) and make sure that all interfaces of the modules are properly adressed. Especially, interfaces to modules not part of that reduced model need to be fed with information coming from that new model file.

The standalone model file needs to follow the coding etiquette as any other file, meaning that it is only allowed to interact through interfaces with the modules. This is necessary to allow the reduced model to work with all realizations of a coupled module.

For running a standalone model two options exist:

* **Running using R**: You can start a standalone model in the same manner as the main model by providing a cfg to the start_run function. The only difference is that cfg$model has to be set from "main.gms" to the wanted model (e.g. "standalone/demand_model.gms"). Everything else works as usual (output folder is created, full.gms is written, job is submitted to SLURM,...)

* **Running using GAMS**: You can run a standalone model from the main folder of the MAgPIE model by just providing the path to the model file, e.g. `gams standalone/demand_model.gms`
This will run the model directly in the main folder and is especially useful for testing and debugging

### Unit test models

Test models can be used to check whether certain model components work as expected. They contain small test cases which check for the desired function.

Technically they are identical to standalone models expect of the following:

* test models must be stored in the folder "tests"
* test models must have an abort statement in it for the case that the test fails and should otherwise end without error. This is important as the success of a test will be measured with the exit code of the model run
* test models should run quickly
* test models ideally should not require any additional input files
