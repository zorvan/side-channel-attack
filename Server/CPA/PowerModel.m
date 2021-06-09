function [Plains,Waves] = PowerModel()
[s_box, ~, w, poly_mat, ~] = aes_init;
hamming_table = HammingTable();
Plains = zeros(2000,16);
Waves = zeros(2000,1500);
for i=1:2000
    P = randi(256,1,16)-1;
    [~,WF] = cipher(P,w,s_box,poly_mat);
    Plains(i,:) = P;
    Waves(i,:) = WF;
end