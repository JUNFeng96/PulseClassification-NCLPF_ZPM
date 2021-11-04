% Makes the plot of extracted pulse(FP) and original ground motion(velocity)  

function [] = make_plot_comparison(FP,velocity,t)
 figure('Name', 'comparison');
 plot(t,FP,'r','LineWidth',3);
 hold on;
 plot(t,velocity,'k');                  
end