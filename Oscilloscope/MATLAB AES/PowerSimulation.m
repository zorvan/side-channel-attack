function PowerSimulation()

Key     = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];% Correct Key
N       = 10000;

SimPow = zeros(N,1200);
[s_box, inv_s_box]          = s_box_gen ();
[poly_mat, inv_poly_mat]    = poly_mat_gen ();
rcon                        = rcon_gen();
w                           = key_expansion (Key, s_box, rcon);

SimPowPath  = 'Y:/Projects/3-Rasad/Implementation/SASEBO-W/SimPower/';
fp      = fopen(strcat(SimPowPath , 'PlainCipher.txt'), 'r');
PICI    = fscanf(fp,'%x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x',[16 inf]);
PICI    = PICI';
selO    = 1:2:2*N;
selE    = 2:2:2*N;
Plain   = PICI(selO,:);
Cipher  = PICI(selE,:);
clear PICI;
clear selO;
clear selE;
fclose(fp);

for i=1:N
    str = strcat(SimPowPath,'SimPow',num2str(i-1),'.txt');
    fw = fopen(str, 'w');
    [ciphertext,SimPow] = cipher (Plain(i,:), w, s_box, poly_mat);
    
    if(~isequal(Cipher(i,:),ciphertext))
        disp('Ciphers are not equal');
        break;
    else
        fprintf(fw,'%f ',SimPow);
        fprintf(fw,'\n');
    end
    
    fclose(fw);
end