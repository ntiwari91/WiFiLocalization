%------------- Put a Marker on predicted sector ------------

switch testsite
    case 1
        switch pred_sector
            case 1
                plot(475,69,'r+', 'MarkerSize', 5);
            case 2
                plot(475,247,'r+', 'MarkerSize', 5);
            case 3
                plot(468,420,'r+', 'MarkerSize', 5);
            case 4
                plot(243,424,'r+', 'MarkerSize', 5);
            case 5
                plot(243,244,'r+', 'MarkerSize', 5);
            case 6
                plot(243,60,'r+', 'MarkerSize', 5);
            case 7
                plot(80,110,'r+', 'MarkerSize', 5);
            case 8
                plot(27,94,'r+', 'MarkerSize', 5);
            otherwise
        end
    case 2
        switch pred_sector
            case 1
                plot(508,43.53,'r+', 'MarkerSize', 5);
            case 2
                plot(428.60,43.53,'r+', 'MarkerSize', 5);
            case 3
                plot(508,191,'r+', 'MarkerSize', 5);
            case 4 
                plot(428,191,'r+', 'MarkerSize', 5);
            case 5
                plot(508,338,'r+', 'MarkerSize', 5);
            case 6
                plot(428,338,'r+', 'MarkerSize', 5);
            case 7
                plot(508,484,'r+', 'MarkerSize', 5);
            case 8
                plot(428,484,'r+', 'MarkerSize', 5);
            case 9
                plot(315,43.53,'r+', 'MarkerSize', 5);
            case 10
                plot(243,43.53,'r+', 'MarkerSize', 5);
            case 11
                plot(316,192,'r+', 'MarkerSize', 5);
            case 12
                plot(243,200,'r+', 'MarkerSize', 5);
            case 13
                plot(314,340,'r+', 'MarkerSize', 5);
            case 14
                plot(244,340,'r+', 'MarkerSize', 5);
                case 15
                plot(104,52,'r+', 'MarkerSize', 5);
                case 16
                plot(29.56,46.88,'r+', 'MarkerSize', 5);
                case 17
                plot(109,202.25,'r+', 'MarkerSize', 5);
                case 18
                plot(30,203,'r+', 'MarkerSize', 5);
                case 19
                plot(118,341,'r+', 'MarkerSize', 5);
                case 20
                plot(37.38,344.21,'r+', 'MarkerSize', 5);
            otherwise 
        end
    case 3
        switch pred_sector
            case 1
              plot(38.5,212.31,'r+', 'MarkerSize', 5);
            case 2
              plot(38.5,133,'r+', 'MarkerSize', 5);
            case 3
              plot(39.6,36.82,'r+', 'MarkerSize', 5);
              case 4
              plot(120,25.76,'r+', 'MarkerSize', 5);
              case 5
              plot(181.57,25.76,'r+', 'MarkerSize', 5);
              case 6
              plot(253.11,25.76,'r+', 'MarkerSize', 5);
              case 7
              plot(322.41,25.76,'r+', 'MarkerSize', 5);
              case 8
              plot(391.71,25.76,'r+', 'MarkerSize', 5);
              case 9
              plot(462.13,25.76,'r+', 'MarkerSize', 5);
              case 10
              plot(317.94,136.30,'r+', 'MarkerSize', 5);
            otherwise
        end
    otherwise
end