<!DOCTYPE html>
<html>
<body>
<?php
/*
 * Note: Previously, you solved this problem in JavaScript.
 *       Observe your implementation in JavaScript and in PHP. 
 *       What are different? What are common?  
 */

function computeAvg($val1, $val2,$val3,$val4,$val5,$val6,$valb)  {
    $score1 = $val1/30;
    echo "$score1 <br>";
} 
echo "computeAvg(15, 55, 55, 55, 25, 55, true) = " . computeAvg(15, 55, 55, 55, 25, 55, true) . "<br/>";      // expected 54
echo "computeAvg(15, 55, 55, 55, 25, 55, false) = " . computeAvg(15, 55, 55, 55, 25, 55, false) . "<br/>";    // expected 53.33 
echo "computeAvg(15, 55, 55, 55, 27.5, 50, true) = " . computeAvg(15, 55, 55, 55, 25, 55, true) . "<br/>";      // expected 54
echo "computeAvg(15, 55, 55, 55, 27.5, 50, false) = " . computeAvg(15, 55, 55, 55, 25, 55, false) . "<br/>";    // expected 53.33
?> 
</body>
</html>