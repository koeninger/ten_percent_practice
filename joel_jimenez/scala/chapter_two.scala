
object Solution {
    def solution(n: Int): Int = {
        var max_gap = 0;
        var gap = 0;
        
        //   Get int as binary string
        var bin_string = getBinaryString(n);
        
        //  Loop through chars (binary digits)
        for(x <- bin_string){
            if(x == '0'){
                // Count zeroes
                gap += 1;
                
            } else{
                // When a '1' is found, calculate max gap
                if(gap > max_gap){
                    max_gap = gap
                }
                
                // Reset gap
                gap = 0;
            }
        }
        
        return max_gap;
    }
  
  
    def getBinaryString(n: Int) : String = {
        var x = n;
        var result = "";
        
        while(x > 0){
            var remainder = x % 2;
            result = remainder.toString.concat(result);
            x = math.floor(x / 2).toInt;
        }
        
        return result;
    }
}