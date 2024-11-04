void swap(int* xp, int* yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

// An optimized version of Bubble Sort
void bubbleSort(int arr[], int n)
{
    int swapped;
    for (int i = 0; i < n-1; i++) {
        swapped = 0;
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(&arr[j], &arr[j + 1]);
                swapped = 1; 
            }
          
        }
        // If no two elements were  swapped by inner loop,
        // then break
        
    
        if (swapped == 0) {
            break;
        }
    }
}

int main()
{
    int A[1000] = {135, 1732, 1097, 1215, 623, 816, 565, 1431, 1030, 1163, 546, 496, 1927, 54, 1641, 944, 773, 971, 245, 773, 448, 193, 1859, 1582, 493, 164, 207, 305, 1106, 1182, 420, 1776, 1868, 1980, 135, 1373, 178, 1017, 435, 1615, 20, 321, 1368, 501, 1558, 1975, 1446, 172, 195, 643, 1376, 1536, 1630, 1066, 1481, 1440, 131, 1326, 1440, 714, 1657, 1138, 1213, 114, 1105, 1528, 1698, 71, 1636, 1845, 553, 678, 320, 1828, 514, 1364, 24, 1568, 798, 385, 1577, 1332, 1086, 1368, 411, 247, 805, 340, 1534, 1171, 1308, 215, 40, 1283, 439, 36, 457, 124, 879, 1603, 1427, 1159, 307, 1916, 1153, 1912, 400, 871, 255, 1472, 1959, 1591, 1332, 1617, 1348, 1713, 1282, 1251, 1804, 1031, 1315, 1340, 1570, 1827, 1401, 1212, 972, 1889, 1034, 194, 757, 564, 1059, 1974, 1050, 1535, 1418, 1445, 52, 1494, 1927, 1406, 813, 1205, 672, 24, 338, 471, 106, 1497, 1452, 1506, 690, 1410, 759, 498, 1817, 1151, 1069, 958, 591, 1548, 667, 1035, 438, 393, 261, 672, 866, 15, 376, 1892, 1827, 339, 1804, 773, 1894, 1842, 1666, 772, 376, 1156, 1125, 1904, 33, 1377, 1709, 977, 1908, 590, 396, 1715, 735, 1666, 877, 1036, 210, 1563, 1441, 239, 193, 576, 1703, 1850, 1702, 689, 644, 668, 1013, 22, 1672, 184, 114, 678, 1584, 821, 648, 682, 430, 81, 662, 1174, 1239, 1873, 537, 773, 239, 1603, 1757, 167, 1803, 396, 69, 1952, 1126, 559, 1733, 843, 1550, 1644, 1570, 420, 1292, 138, 1014, 1127, 497, 1004, 1004, 1123, 1018, 1057, 1871, 1339, 1039, 1927, 174, 930, 82, 64, 1124, 1184, 654, 317, 500, 785, 1170, 468, 754, 1839, 1604, 1488, 1812, 172, 829, 214, 194, 1284, 1231, 1316, 1210, 1651, 670, 233, 909, 225, 833, 457, 508, 75, 998, 1515, 1727, 1701, 941, 511, 1519, 1445, 752, 1703, 302, 527, 325, 1877, 78, 1059, 1451, 1925, 976, 1494, 1791, 1173, 1353, 1540, 1067, 107, 1656, 1723, 260, 1334, 551, 964, 573, 1000, 1315, 146, 1624, 572, 1513, 1764, 674, 1129, 683, 59, 849, 1985, 1666, 694, 560, 1219, 1341, 731, 940, 298, 684, 1411, 1403, 1150, 622, 53, 1856, 782, 962, 1228, 1766, 1404, 382, 1503, 1728, 751, 1427, 785, 1872, 1448, 851, 1945, 658, 746, 1564, 602, 597, 926, 1423, 1465, 1574, 1955, 1699, 1094, 1112, 701, 479, 1048, 1976, 866, 1998, 364, 1262, 204, 582, 1097, 185, 312, 1227, 416, 1316, 881, 57, 393, 131, 1736, 1773, 665, 1790, 772, 1277, 304, 1864, 1212, 1915, 346, 254, 1118, 1012, 428, 1965, 437, 1175, 818, 392, 1225, 1545, 1750, 770, 915, 1428, 1924, 609, 168, 1376, 950, 1799, 1100, 1333, 686, 136, 815, 218, 1045, 116, 52, 1691, 390, 911, 1031, 419, 117, 1393, 1373, 1830, 1793, 397, 368, 351, 978, 1511, 704, 1669, 888, 1364, 1887, 42, 70, 1794, 1996, 323, 926, 869, 177, 429, 1270, 16, 399, 1807, 310, 574, 1304, 998, 77, 1477, 1294, 747, 705, 338, 699, 797, 1220, 298, 447, 450, 1085, 516, 872, 359, 998, 1139, 1538, 1178, 1653, 968, 1363, 1134, 62, 274, 1297, 574, 1629, 106, 565, 1764, 567, 18, 1175, 1360, 29, 1531, 1187, 1943, 1632, 528, 1968, 866, 1835, 890, 969, 1548, 1199, 1606, 107, 1149, 1890, 456, 925, 40, 1095, 486, 525, 1356, 553, 227, 1263, 253, 1673, 1894, 176, 9, 1097, 1358, 1525, 1413, 695, 1952, 690, 1679, 1211, 1086, 903, 1492, 1591, 1306, 617, 1193, 1515, 356, 1727, 1862, 1265, 486, 548, 1512, 458, 372, 1132, 900, 1769, 449, 728, 1930, 1592, 1978, 493, 1016, 638, 1812, 352, 1614, 1926, 1816, 611, 873, 794, 1030, 1037, 1937, 272, 1542, 326, 817, 345, 770, 675, 863, 1091, 1303, 1548, 507, 505, 980, 1232, 110, 1082, 659, 1724, 1783, 1876, 1327, 1141, 1315, 1761, 1468, 1782, 1692, 1061, 1059, 485, 1067, 1362, 1317, 1117, 1544, 1609, 1407, 772, 907, 198, 1995, 1218, 35, 1323, 212, 881, 1007, 1307, 884, 1765, 1284, 285, 588, 1695, 1550, 1274, 1087, 1095, 969, 1142, 690, 1059, 1012, 781, 726, 1765, 1576, 1180, 1482, 1213, 750, 453, 290, 521, 1393, 1602, 1536, 1747, 144, 1418, 41, 1232, 543, 993, 512, 1978, 10, 854, 1049, 246, 1135, 1837, 695, 545, 783, 1474, 45, 476, 543, 721, 151, 522, 1813, 1696, 9, 558, 1186, 472, 1407, 910, 1215, 1995, 1886, 1604, 105, 852, 610, 1612, 1085, 1400, 1197, 1104, 1187, 1723, 1365, 821, 1089, 496, 1722, 1812, 203, 1807, 1861, 971, 1175, 868, 293, 1980, 1829, 1206, 1469, 293, 678, 1510, 152, 187, 1119, 1614, 1605, 1417, 734, 1186, 1713, 1824, 1142, 416, 1255, 717, 1949, 1830, 1444, 1555, 740, 1228, 689, 1847, 400, 1444, 1024, 1884, 1819, 350, 565, 1437, 1391, 233, 1383, 707, 1591, 1031, 860, 307, 55, 674, 1859, 1132, 342, 1834, 1260, 1999, 633, 1989, 1422, 180, 1283, 998, 1106, 1399, 1650, 750, 679, 1337, 1934, 1240, 1387, 1937, 916, 433, 775, 1461, 1906, 1664, 1860, 1249, 202, 1648, 575, 90, 221, 78, 711, 1103, 1237, 27, 970, 1635, 1514, 64, 1178, 326, 323, 1237, 903, 1001, 68, 1879, 1871, 1431, 271, 821, 1311, 287, 1162, 466, 1282, 1337, 438, 1162, 960, 588, 208, 1575, 676, 1885, 466, 1663, 1448, 109, 389, 1663, 1906, 1368, 742, 1190, 383, 1482, 1658, 338, 1717, 1310, 1150, 1066, 212, 770, 1086, 1696, 1324, 684, 761, 1066, 1049, 1732, 1202, 1291, 1915, 1071, 1749, 1940, 763, 493, 352, 1645, 5, 786, 1213, 708, 1064, 1757, 1006, 1952, 964, 501, 566, 23, 598, 1347, 1654, 1785, 724, 1615, 1424, 1914, 1480, 1881, 1682, 1669, 615, 977, 633, 221, 836, 34, 1229, 504, 1952, 934, 407, 1384, 855, 531, 514, 682, 703, 179, 1280, 566, 960, 656, 412, 1530, 1713, 1350, 971, 1077, 394, 970, 1171, 955, 773, 649, 117, 1969, 1358, 1875, 850, 1587, 228, 1955, 1251, 211, 1882, 964, 378, 1039, 1492, 1224, 1843, 326, 1858, 784, 1674, 546, 1508, 1691, 943, 1451, 1134, 1222, 1906, 911, 849, 295, 1723, 1811, 19, 113, 1581, 1289, 773, 350, 642, 1734, 940, 30, 1245, 1205, 156, 1725, 85, 1326, 563, 790, 100, 1210, 1874, 1732};
	int n = sizeof(A)/4;

    bubbleSort(A, n);
    return A[0];
}