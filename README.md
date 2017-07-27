UDP simulator with library variant framework.  This is a simple example of how to setup SW Modules
so that it can pass MIL, SIL, and HIL testing.

This work is based on the mathworks technical paper ->
https://www.mathworks.com/company/newsletters/articles/design-variant-management-in-model-based-design.html

To do:
a) Create variant libraries for models (using library models rather than model reference)
b) Create scripts to automate the selection of the right modules and dependencies for development, 
testing, and production environments.

I would like to acknowledge Chuck Olosky from MathWorks for help developing the framework.

Version History:
1.0 - MIL testing of UDP simulator.