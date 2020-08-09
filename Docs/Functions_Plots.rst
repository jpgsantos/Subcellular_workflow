Plots
-----

.. _f_plot:

f_plot
^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Plots/f_plot.m
 	   :linenos:
	   :language: matlab

The function that calls all the custom plot functions when appropriate
Plots diagnosis that are important to understand if everything is working as it was supposed, it , expected outputs, observed outputs and scores for the models and conditions specified.

- **Inputs** - :ref:`rst<rst>`, :ref:`stg<stg>`
- **Outputs**

   .. toggle-header::
       :header: **Figure Scores**
 
 	.. image:: ../Docs/Images/Scores_example.png
	
   Total scores and scores per dataset given the parameters specified in :ref:`stg.pa<stg.pa>`
   
   .. toggle-header::
       :header: **Code Figure Scores**
  
  	 .. literalinclude:: ../Matlab/Code/Plots/f_plot_scores.m
 		:linenos:
 		:language: matlab
		
   |
   
   .. toggle-header::
       :header: **Figure Inputs**
 
 	.. image:: ../Docs/Images/Inputs_example.png
	
   Checks inputs to the model
   
   .. toggle-header::
       :header: **Code Figure Inputs**
   
    	 .. literalinclude:: ../Matlab/Code/Plots/f_plot_inputs.m
 		:linenos:
 		:language: matlab
				
   |

   .. toggle-header::
       :header: **Figure Outputs**
 
 	.. image:: ../Docs/Images/Outputs_example.png
   
   Expected outputs, observed outputs
   
   .. toggle-header::
       :header: **Code Figure Outputs**
 	  
       .. literalinclude:: ../Matlab/Code/Plots/f_plot_outputs.m
          :linenos:
          :language: matlab
		  		
   | 

   .. toggle-header::
       :header: **Figure Input and Outputs per experiment**
 
 	.. image:: ../Docs/Images/Inputs_Outputs_example.png
	
   Combined figure of the inputs and outputs for each experiment, on the left side we have the inputs of the experiment and on the right side the outputs
   
   .. toggle-header::
       :header: **Code Figure Input and Outputs**
 	  
       .. literalinclude:: ../Matlab/Code/Plots/f_plot_in_out.m
          :linenos:
          :language: matlab
		  		
   | 
  
   .. toggle-header::
       :header: **Figure Sensitivity Analysis** :math:`S_{i}`
 
 	.. image:: ../Docs/Images/SA_SI_sd_example.png

   :math:`S_{i}`

   .. toggle-header::
       :header: **Figure Sensitivity Analysis** :math:`S_{Ti}`
	   
	.. image:: ../Docs/Images/SA_STI_sd_example.png

   :math:`S_{Ti}`

   .. toggle-header::
       :header: **Figure Sensitivity Analysis** :math:`S_{Ti}-S_{i}`
	   
	.. image:: ../Docs/Images/SA_STI-SI_sd_example.png

   :math:`S_{Ti}-S_{i}`
   
   .. toggle-header::
       :header: **Code figures SA**
 	  
       .. literalinclude:: ../Matlab/Code/Plots/f_plot_SA_sensitivities.m
          :linenos:
          :language: matlab		 		  
	  
- **Calls**
- **Loads** - :ref:`data.mat<data.mat>`

.. _f_get_subplot:

f_get_subplot
^^^^^^^^^^^^^^

 .. toggle-header::
     :header: **Code**
 
 	.. literalinclude:: ../Matlab/Code/Plots/f_get_subplot.m
 	   :linenos:
	   :language: matlab

- **Inputs**
- **Outputs**
- **Calls**
- **Loads**