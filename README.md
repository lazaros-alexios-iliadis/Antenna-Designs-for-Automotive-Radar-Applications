# Antenna-Design
Antenna designs for automotive radar applications using different evolutionary and swarm intelligence algorithms.
The scripts are written in MATLAB, and the MATLAB-HFSS api is utilized with few modifications.
The Antennas folder contains a bowtie patch antenna with an aperture coupled feed for automotive radar applications (79 GHz). This work was presented in iWAT 2023 conference, L. A. Iliadis, A. D. Boursianis, V. P. Rekkas, Z. D. Zaharis, S. Koulouridis and S. K. Goudos, "Aperture-coupled Bowtie Patch Antenna Design for Autonomous Driving Applications," 2023 International Workshop on Antenna Technology (iWAT), Aalborg, Denmark, 2023, pp. 1-4, doi: 10.1109/iWAT57058.2023.10171621
The second design is an 1x5 array with U-shaped patches and aperture coupled feed for automotive radar applications (79 GHz). This work has been accepted for presentation in the EuCAP 2024 conference.

The antennas were designed using the following algorithms, which have been partially rewritten for our purposes:
1) RUN beyond metaphor algorithm
  Ahmadianfar, Iman, Ali Asghar Heidari, Amir H. Gandomi, Xuefeng Chu, and Huiling Chen. "RUN beyond the metaphor: an efficient optimization algorithm based on Runge Kutta method." 
  Expert Systems with Applications 181 (2021): 115079. DOI: https://doi.org/10.1016/j.eswa.2021.115079
2) jSO algorithm
  J. Brest, M. S. Maučec and B. Bošković, "Single objective real-parameter optimization: Algorithm jSO," 2017 IEEE Congress on Evolutionary Computation (CEC),
  Donostia, Spain, 2017, pp. 1311-1318, doi: 10.1109/CEC.2017.7969456.

The .aedt files contain examples of the results obtained from the optimization algorithms.
