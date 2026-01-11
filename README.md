# Fibonacci-number-circuit
Design Fibonacci number circuit using Finite Machine state with datapath


### Command to configure Synopsys using a **Makefile**

![Debouncer simulation](simulation.png)

```bash
setenv GIT_ROOT `git rev-parse --show-toplevel`
setenv UVM_WORK $GIT_ROOT/work/uvm
mkdir -p $UVM_WORK && cd $UVM_WORK
ln -sf $GIT_ROOT/hw/Makefile/Makefile.vcs Makefile
``` 


### Makefile
After completing these steps you will have the environmente ready to work. You can then use the Makefile with the following commands:
- make compile : Compiles the RTL and testbench files
- make sim : Runs the simulation and displays the signals
- make verdi : Opens the graphical interfacee

Of course, if you have any question o any problem you can write make var or make help to see where/what is the problem.
I add my email to connect with me if you requiered : namigtle066@gmail.com :)


