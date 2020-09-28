Using file input to parse out an array                                                                          
                                                                                                                
  Problem                                                                                                       
     Create the array b1-b5 by skipping over the five missing elements in a1-a10                                
                                                                                                                
     Given                                                                                                      
                                                                                                                
         A1    A2    A3    A4    A5    A6    A7    A8    A9    A10                                              
          .     .     1     0     1     0     1     .     .      .                                              
                                                                                                                
      Create                                                                                                    
                                                                                                                
         B1    B2    B3    B4    B5                                                                             
          1     0     1     0     1                                                                             
                                                                                                                
github                                                                                                          
https://tinyurl.com/y3gr7s5z                                                                                    
https://github.com/rogerjdeangelis/utl-using-file-input-to-parse-out-an-array                                   
                                                                                                                
SAS Forum                                                                                                       
https://tinyurl.com/yywqw9v5                                                                                    
https://communities.sas.com/t5/SAS-Programming/SAS-array-Create-a-new-array-with-nonmissing-value/m-p/687014    
                                                                                                                
/*                   _                                                                                          
(_)_ __  _ __  _   _| |_                                                                                        
| | `_ \| `_ \| | | | __|                                                                                       
| | | | | |_) | |_| | |_                                                                                        
|_|_| |_| .__/ \__,_|\__|                                                                                       
        |_|                                                                                                     
*/                                                                                                              
                                                                                                                
data have;                                                                                                      
input a1 - a10;                                                                                                 
datalines;                                                                                                      
. . 1 0 1 0 1 . . .                                                                                             
. 0 0 1 1 1 . . . .                                                                                             
. . . 1 1 0 0 0 . .                                                                                             
1 1 1 1 0 . . . . .                                                                                             
;;;;                                                                                                            
run;quit;                                                                                                       
                                                                                                                
WORK.HAVE total obs=4                                                                                           
                                                                                                                
 A1    A2    A3    A4    A5    A6    A7    A8    A9    A10                                                      
                                                                                                                
              1     0     1     0     1                                                                         
        0     0     1     1     1                                                                               
                    1     1     0     0     0                                                                   
  1     1     1     1     0                                                                                     
                                                                                                                
/*           _               _                                                                                  
  ___  _   _| |_ _ __  _   _| |_                                                                                
 / _ \| | | | __| `_ \| | | | __|                                                                               
| (_) | |_| | |_| |_) | |_| | |_                                                                                
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                               
                |_|                                                                                             
*/                                                                                                              
                                                                                                                
WORK.WANT total obs=4                                                                                           
                                                                                                                
  B1    B2    B3    B4    B5                                                                                    
                                                                                                                
   1     0     1     0     1                                                                                    
   0     0     1     1     1                                                                                    
   1     1     0     0     0                                                                                    
   1     1     1     1     0                                                                                    
                                                                                                                
/*         _       _   _                                                                                        
 ___  ___ | |_   _| |_(_) ___  _ __                                                                             
/ __|/ _ \| | | | | __| |/ _ \| `_ \                                                                            
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                           
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                           
                                                                                                                
*/                                                                                                              
                                                                                                                
options missing=" ";                                                                                            
                                                                                                                
proc datasets lib=work nolist;                                                                                  
  delete want;                                                                                                  
run;quit;                                                                                                       
                                                                                                                
filename tmp temp;                                                                                              
%utlfkil(%sysfunc(pathname(tmp)));                                                                              
                                                                                                                
data want;                                                                                                      
  if _n_=0 then do; %dosubl('                                                                                   
    * compress out missing values and send to file;                                                             
    data _null_;                                                                                                
       file tmp;                                                                                                
       set have;                                                                                                
       shrink=catx(' ',of a1-a10);                                                                              
       put shrink;                                                                                              
       putlog shrink;                                                                                           
    run;quit;                                                                                                   
    ');                                                                                                         
  end;                                                                                                          
  infile tmp;                                                                                                   
  input b1 - b5;                                                                                                
run;quit;                                                                                                       
                                                                                                                
* this is what the temp file looks like;                                                                        
                                                                                                                
1 0 1 0 1                                                                                                       
0 0 1 1 1                                                                                                       
1 1 0 0 0                                                                                                       
1 1 1 1 0                                                                                                       
                                                                                                                
