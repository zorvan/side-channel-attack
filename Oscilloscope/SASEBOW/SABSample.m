function Cipher = SASEBO(Key,Plain)
Key 	= [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
Plain 	= [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

C10 = SABOpen();
% Set SASEBO-W Key
SABSetKey(C10,Key);

% Encrypt 
Cipher = SABEncrypt(C10,Plain);

SABClose(C10);
