Import_CSV

% current index location of data
% 1: time (seconds)
% 2: dc current (battery)
% 3: phase a current (motor)


time_index = 1;
i_dc_index = 2;  % battery current
i_a_index = 3;  % motor phase a current

t = powerqualitydata(:,time_index);
i_dc = powerqualitydata(:,i_dc_index);
i_a = powerqualitydata(:,i_a_index);

figure(1)
fft_pq(i_dc,t,2000,45000);

figure(2)
fft_pq(i_a,t,50,1000);

figure(3)
fft_pq(i_a,t,500,25000);


function Y = fft_pq(X,time,freq_bar_width,freq_max)
    
    % do a standard fft on the full dataset
    ts = time(2)-time(1);
    Fs = 1/ts;
    L = length(time);
    Y = fft(X);
    P2 = abs(Y/L);
    n = round(L/2);
    P1 = P2(1:n+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    f = Fs/L*(0:n);
    
    subplot(2,2,1)
    inds = find(f<freq_max);
    plot(f(inds)/1000,P1(inds),"LineWidth",3)
    ylabel('Magnitude')
    xlabel('Frequency (kHz)')
    title('Frequency Response for Full Dataset')

    subplot(2,2,2)
    plot(time,X,"LineWidth",3)
    ylabel('Magnitude')
    xlabel('Time (s)')
    title('TTime Domain Response of Full Dataset')
    
    % redo for a smaller window size to get larger "buckets" for 
    % frequency content

    num_samples = 1/freq_bar_width/ts;
    
    time2 = time(end-num_samples:end);
    X = X(end-num_samples:end);
    Fs = 1/ts;
    L = length(time2);
    Y = fft(X);
    P2 = abs(Y/L);
    n = round(L/2);
    P1 = P2(1:n+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    f = Fs/L*(0:n);
    subplot(2,2,3)
    inds = find(f<freq_max);
    bar(f(inds)/1000,P1(inds),"LineWidth",3)
    ylabel('Magnitude')
    xlabel('Frequency (kHz)')
    title('Frequency Response for Subset of Data')
    
    subplot(2,2,4)
    plot(time2,X,"LineWidth",3)
    ylabel('Magnitude')
    xlabel('Time (s)')
    title('Time Domain Response for Subset of Data')

end