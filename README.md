# Identification of near-fault pulse-like ground motions based on non-causal low-pass filter and zero-point method
基于非因果滤波和零点法的近断层脉冲型地震动识别方法

by Jun Feng, Boming Zhao, Tianci Zhao

Abstract: An algorithm for extracting the velocity pulse signal was proposed based on the Butterworth non-causal low-pass filter and the zero-point method, and the cut-off frequency of the filter is determined by the number of extreme points in the pulse signal. 666 records with peak ground velocities above 30 cm/s were utilized as training data. The identification criteria of single-pulse-like and double-pulse-like records based on the relative energy and amplitude of pulse signals were proposed. The pulse period was calculated by the duration of the most effective pulse. The comparison with the reference methods shows that the proposed pulse extraction method has a high fitting effect and can be used to extract asymmetric pulse signal and double-pulse signal; The proposed quantitative identification criteria can effectively identify single-pulse-like and double-pulse-like ground motions; The proposed pulse period calculation method can calculate the pulse periods of s single-pulse-like and double-pulse-like records.

摘 要：基于Butterworth非因果低通滤波器和零点法提取地震动速度时程中的脉冲信号，并以脉冲信号中的极值点数量确定滤波器的截止频率。选取666条速度峰值大于30 cm/s的近断层地震记录作为训练数据，以脉冲信号的相对能量和幅值作为量化指标，给出了单脉冲型和双脉冲型地震动的识别标准。还提出了以最显著脉冲信号的持续时间为依据的脉冲周期计算方法。通过与既有方法比较表明：基于Butterworth非因果低通滤波器和零点法的脉冲提取方法的拟合效果较好，可用于提取非对称脉冲信号和双脉冲信号；提出的定量识别标准可以有效地识别单脉冲型和双脉冲型地震动；所提的脉冲周期计算方法可以用于确定单脉冲型和双脉冲型地震动的脉冲周期。

# Contents

1. Main_pulse_classification_script.m: Main pulse classification script.
2. parseAT2.m: Parser for NGA West2 AT2 files.
3. zero_point_method.m: Script for extracting pulse signal based on zero point method.
4. make_plot_comparison.m: kes the plot of extracted pulse(FP) and original ground motion(velocity).
5. 666 records are utilized to calibrate the classification standard,
6. Classification results.txt: Classification results of 666 records.
7. The folder of Ground motion (AT2).
