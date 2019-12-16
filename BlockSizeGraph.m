clc; clear all; close all;
%%-------------------------------------------------------------------------
%--TT_40x142: Total Time for all blocks of size 40x40 and beach window 142x142 in a whole sequence
%--noBlock_40x142: Total number of blocks of size 40x40 and beach window 142x142 in a whole sequence
%--TPBlock_40x142: Average time per block of size 40x40 and beach window 142x142 

%--TT: Total time for all blocks of all size in a whole sequence
%--noFrame: number of frames in a sequence
%--TPFrame: Average time per frame 
%%-------------------------------------------------------------------------


%--TT_40x142, noBlock_40x142,  TPBlock_40x142, TotalTime, noFrame, TimePerFrame
 mac1=[3206.81, 666141, 0.00481,  4337.55, 8131, 0.53346];
 mac2=[2955.05, 665905, 0.00444,  4000.93, 8131, 0.49206];
 mac3=[2925.04, 665956, 0.00439,  3988.04, 8131, 0.49047];
 mac4=[3366.85, 666016, 0.00506,  4552.82, 8131, 0.55993];
 mac5=[2969.97, 665747, 0.00446,  4025.37, 8131, 0.49506];
 mac6=[2936.64, 665767, 0.00441,  3976.24, 8131, 0.48902];
 mac7=[3421.64, 666185, 0.00514,  4613.57, 8131, 0.56740];
 mac8=[2974.22, 665576, 0.00447,  4029.46, 8131, 0.49557];
 mac9=[2960.01, 666048, 0.00444,  4022.64, 8131, 0.49473];
mac10=[2911.78, 666048, 0.00437,  3962.65, 8131, 0.48735];

mac=[mac1; mac2; mac3; mac4; mac5; mac6; mac7; mac8; mac9; mac10];

%--------------------------------------------------------------------------
 lewis1=[ 11943.42,  665576,   0.01794,  15954.71,  8131,   1.96221  ];
 lewis2=[  7866.21,  665576,   0.01182,  10301.23,  8131,   1.26691  ];
 lewis3=[  8497.47,  665576,   0.01277,  11131.27,  8131,   1.36899  ];
 lewis4=[ 10021.60,  665576,   0.01506,  13256.89,  8131,   1.63041  ];
 lewis5=[  7607.10,  665576,   0.01143,   9958.07,  8131,   1.22470  ];
 lewis6=[  8643.89,  665576,   0.01299,  11329.69,  8131,   1.39339  ];
 lewis7=[  8052.95,  665576,   0.01210,  10579.28,  8131,   1.30110  ];
 lewis8=[  8110.28,  665576,   0.01219,  10621.39,  8131,   1.30628  ];
 lewis9=[ 10454.38,  665576,   0.01571,  13856.35,  8131,   1.70414  ];
lewis10=[ 10394.67,  665576,   0.01562,  13780.89,  8131,   1.69486  ];

lewis=[lewis1; lewis2; lewis3; lewis4; lewis5; lewis6; lewis7; lewis8; lewis9; lewis10 ];

%% per block
avg_mac_block=mean(mac(:,3)); 
avg_lewis_block=mean(lewis(:,3)); 

figure, plot(1:10, mac(:,3),'r--*',1:10,lewis(:,3),'b--o')
title(sprintf('Time per Block (blk size: 40x40, SW=142x142), #frames = 8131 \n AVG(Mac) = %6.5f sec, AVG(Lewis) = %6.5f sec\n Mac is %2.1f times faster than Lewis', avg_mac_block, avg_lewis_block, avg_lewis_block/avg_mac_block));
ylim([0.001 0.020])
xlabel('Iteration')
ylabel('Time (sec)')
legend('Mac CPU','Lewis CPU')
print(sprintf('TPBlock'), '-dpng')

%% per block
avg_mac_frame=mean(mac(:,6)); 
avg_lewis_frame=mean(lewis(:,6)); 

figure, plot(1:10, mac(:,6),'r--*',1:10,lewis(:,6),'b--o')
title('Time per Frame (size: 720x480)');
title(sprintf('Time per Frame (size: 720x480), #frames = 8131 \n AVG(Mac) = %5.4f sec, AVG(Lewis) = %5.4f sec\n Mac is %2.1f times faster than Lewis', avg_mac_frame, avg_lewis_frame, avg_lewis_frame/avg_mac_frame));
ylim([0 2])
xlabel('Iteration')
ylabel('Time (sec)')
legend('Mac CPU','Lewis CPU')
print(sprintf('TPFrame'), '-dpng')


