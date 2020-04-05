%------------- Put a Marker on predicted sector ------------
switch testsite
    case 1
        switch actual_sector
            case 1
                plot(477.78,116.18,'b*', 'MarkerSize', 5);
            case 2
                plot(475.54,293,'b*', 'MarkerSize', 5);
            case 3
                plot(492.31,468.28,'b*', 'MarkerSize', 5);
            case 4
                plot(264,472.75,'b*', 'MarkerSize', 5);
            case 5
                plot(264,292.79,'b*', 'MarkerSize', 5);
            case 6
                plot(264,116.18,'b*', 'MarkerSize', 5);
            case 7
                plot(88,210,'b*', 'MarkerSize', 5);
            case 8
                plot(34,189,'b*', 'MarkerSize', 5);
            otherwise
        end
    case 2
        switch actual_sector
            case 1
                plot(511.31,108,'b*', 'MarkerSize', 5);
            case 2
                plot(428.60,97.18,'b*', 'MarkerSize', 5);
            case 3
                plot(499,241.37,'b*', 'MarkerSize', 5);
            case 4 
                plot(435,249.21,'b*', 'MarkerSize', 5);
            case 5
                plot(513.55,399,'b*', 'MarkerSize', 5);
            case 6
                plot(437.54,401.21,'b*', 'MarkerSize', 5);
            case 7
                plot(512.43,512.99,'b*', 'MarkerSize', 5);
            case 8
                plot(428,503,'b*', 'MarkerSize', 5);
            case 9
                plot(323.53,103.89,'b*', 'MarkerSize', 5);
            case 10
                plot(247.52,102.77,'b*', 'MarkerSize', 5);
            case 11
                plot(328,239,'b*', 'MarkerSize', 5);
            case 12
                plot(248.64,245.84,'b*', 'MarkerSize', 5);
            case 13
                plot(316.82,397.86,'b*', 'MarkerSize', 5);
            case 14
                plot(243,393.39,'b*', 'MarkerSize', 5);
                case 15
                plot(107.80,109.48,'b*', 'MarkerSize', 5);
                case 16
                plot(27.32,96.06,'b*', 'MarkerSize', 5);
                case 17
                plot(96.62,244.75,'b*', 'MarkerSize', 5);
                case 18
                plot(32.91,254.79,'b*', 'MarkerSize', 5);
                case 19
                plot(104.45,386.68,'b*', 'MarkerSize', 5);
                case 20
                plot(26.60,396.74,'b*', 'MarkerSize', 5);
            otherwise 
        end
    case 3
        switch actual_sector
            case 1
              plot(42.97,243.61,'b*', 'MarkerSize', 5);
            case 2
              plot(34.05,160.89,'b*', 'MarkerSize', 5);
            case 3
              plot(49.68,60.32,'b*', 'MarkerSize', 5);
              case 4
              plot(113.40,71.47,'b*', 'MarkerSize', 5);
              case 5
              plot(187.17,62.53,'b*', 'MarkerSize', 5);
              case 6
              plot(254.23,73.71,'b*', 'MarkerSize', 5);
              case 7
              plot(321.29,71.47,'b*', 'MarkerSize', 5);
              case 8
              plot(393.95,72.59,'b*', 'MarkerSize', 5);
              case 9
              plot(460,69.26,'b*', 'MarkerSize', 5);
              case 10
              plot(316.82,163.13,'b*', 'MarkerSize', 5);
            otherwise
        end
    otherwise
end