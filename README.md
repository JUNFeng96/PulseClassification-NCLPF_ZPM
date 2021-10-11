# Identification of near-fault pulse-like ground motions based on non-causal low-pass filter and zero-point method
基于非因果滤波和零点法的近断层脉冲型地震动识别方法

by Jun Feng, Boming Zhao, Tianci Zhao

An algorithm for extracting the velocity pulse signal was proposed based on the Butterworth non-causal low-pass filter and the zero-point method, and the cut-off frequency of the filter is determined by the number of extreme points in the pulse signal. 666 records with peak ground velocities above 30 cm/s were utilized as training data. The identification criteria of single-pulse-like and double-pulse-like records based on the relative energy and amplitude of pulse signals were proposed. The pulse period was calculated by the duration of the most effective pulse. 

基于Butterworth非因果低通滤波器和零点法提取地震动速度时程中的脉冲信号，并以脉冲信号中的极值点数量确定滤波器的截止频率。选取666条速度峰值大于30 cm/s的近断层地震记录作为训练数据，以脉冲信号的相对能量和幅值作为量化指标，给出了单脉冲型和双脉冲型地震动的识别标准。

# Contents

1. Main_pulse_classification_script.m: Main pulse classification script.
2. classification_standard.m: Script for the classification standard of pulse-like ground motion.
3. parseAT2.m: Parser for NGA West2 AT2 files.
4. zero_point_method.m: Script for extracting pulse signal based on zero point method.
5. make_plot_comparison.m: kes the plot of extracted pulse(FP) and original ground motion(velocity).
6. 666 records are utilized to calibrate the classification standard,
7. Classification results.txt: Classification results of 666 records.
8. The folder of Ground motion (AT2).
