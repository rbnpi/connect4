#supporting file for connect4b.rb by Robin Newman, Oct 2021
#activeated by run_file from connect4b.rb
#each function checks for a range of win conditions
#p holds "r" or "g", gm is the internal board data array
define :hwin do |p,gm| #horizontal win conditions
  (gm[0][0]==p and gm[1][0]==p and gm[2][0]==p and gm[3][0]==p) or \
    (gm[1][0]==p and gm[2][0]==p and gm[3][0]==p and gm[4][0]==p) or \
    (gm[2][0]==p and gm[3][0]==p and gm[4][0]==p and gm[5][0]==p) or \
    (gm[3][0]==p and gm[4][0]==p and gm[5][0]==p and gm[6][0]==p) or \
    
  (gm[0][1]==p and gm[1][1]==p and gm[2][1]==p and gm[3][1]==p) or \
    (gm[1][1]==p and gm[2][1]==p and gm[3][1]==p and gm[4][1]==p) or \
    (gm[2][1]==p and gm[3][1]==p and gm[4][1]==p and gm[5][1]==p) or \
    (gm[3][1]==p and gm[4][1]==p and gm[5][1]==p and gm[6][1]==p) or \
    
  (gm[0][2]==p and gm[1][2]==p and gm[2][2]==p and gm[3][2]==p) or \
    (gm[1][2]==p and gm[2][2]==p and gm[3][2]==p and gm[4][2]==p) or \
    (gm[2][2]==p and gm[3][2]==p and gm[4][2]==p and gm[5][2]==p) or \
    (gm[3][2]==p and gm[4][2]==p and gm[5][2]==p and gm[6][2]==p) or \
    
  (gm[0][3]==p and gm[1][3]==p and gm[2][3]==p and gm[3][3]==p) or \
    (gm[1][3]==p and gm[2][3]==p and gm[3][3]==p and gm[4][3]==p) or \
    (gm[2][3]==p and gm[3][3]==p and gm[4][3]==p and gm[5][3]==p) or \
    (gm[3][3]==p and gm[4][3]==p and gm[5][3]==p and gm[6][3]==p) or \
    
  (gm[0][4]==p and gm[1][4]==p and gm[2][4]==p and gm[3][4]==p) or \
    (gm[1][4]==p and gm[2][4]==p and gm[3][4]==p and gm[4][4]==p) or \
    (gm[2][4]==p and gm[3][4]==p and gm[4][4]==p and gm[5][4]==p) or \
    (gm[3][4]==p and gm[4][4]==p and gm[5][4]==p and gm[6][4]==p) or \
    
  (gm[0][5]==p and gm[1][5]==p and gm[2][5]==p and gm[3][5]==p) or \
    (gm[1][5]==p and gm[2][5]==p and gm[3][5]==p and gm[4][5]==p) or \
    (gm[2][5]==p and gm[3][5]==p and gm[4][5]==p and gm[5][5]==p) or \
    (gm[3][5]==p and gm[4][5]==p and gm[5][5]==p and gm[6][5]==p)
end
define :vwin do |p,gm| #vertical win conditions
  (gm[0][0]==p and gm[0][1]==p and gm[0][2]==p and gm[0][3]==p) or \
    (gm[0][1]==p and gm[0][2]==p and gm[0][3]==p and gm[0][4]==p) or \
    (gm[0][2]==p and gm[0][3]==p and gm[0][4]==p and gm[0][5]==p) or \
    
  (gm[1][0]==p and gm[1][1]==p and gm[1][2]==p and gm[1][3]==p) or \
    (gm[1][1]==p and gm[1][2]==p and gm[1][3]==p and gm[1][4]==p) or \
    (gm[1][2]==p and gm[1][3]==p and gm[1][4]==p and gm[1][5]==p) or \
    
  (gm[2][0]==p and gm[2][1]==p and gm[2][2]==p and gm[2][3]==p) or \
    (gm[2][1]==p and gm[2][2]==p and gm[2][3]==p and gm[2][4]==p) or \
    (gm[2][2]==p and gm[2][3]==p and gm[2][4]==p and gm[2][5]==p) or \
    
  (gm[3][0]==p and gm[3][1]==p and gm[3][2]==p and gm[3][3]==p) or \
    (gm[3][1]==p and gm[3][2]==p and gm[3][3]==p and gm[3][4]==p) or \
    (gm[3][2]==p and gm[3][3]==p and gm[3][4]==p and gm[3][5]==p) or \
    
  (gm[4][0]==p and gm[4][1]==p and gm[4][2]==p and gm[4][3]==p) or \
    (gm[4][1]==p and gm[4][2]==p and gm[4][3]==p and gm[4][4]==p) or \
    (gm[4][2]==p and gm[4][3]==p and gm[4][4]==p and gm[4][5]==p) or \
    
  (gm[5][0]==p and gm[5][1]==p and gm[5][2]==p and gm[5][3]==p) or \
    (gm[5][1]==p and gm[5][2]==p and gm[5][3]==p and gm[5][4]==p) or \
    (gm[5][2]==p and gm[5][3]==p and gm[5][4]==p and gm[5][5]==p) or \
    
  (gm[6][0]==p and gm[6][1]==p and gm[6][2]==p and gm[6][3]==p) or \
    (gm[6][1]==p and gm[6][2]==p and gm[6][3]==p and gm[6][4]==p) or \
    (gm[6][2]==p and gm[6][3]==p and gm[6][4]==p and gm[6][5]==p)
end

define :dfwin do |p,gm| #forward slope diagonal win conditions
  (gm[0][0]==p and gm[1][1]==p and gm[2][2]==p and gm[3][3]==p) or \
    (gm[1][0]==p and gm[2][1]==p and gm[3][2]==p and gm[4][3]==p) or \
    (gm[2][0]==p and gm[3][1]==p and gm[4][2]==p and gm[5][3]==p) or \
    (gm[3][0]==p and gm[4][1]==p and gm[5][2]==p and gm[6][3]==p) or \
    
  (gm[0][1]==p and gm[1][2]==p and gm[2][3]==p and gm[3][4]==p) or \
    (gm[1][1]==p and gm[2][2]==p and gm[3][3]==p and gm[4][4]==p) or \
    (gm[2][1]==p and gm[3][2]==p and gm[4][3]==p and gm[5][4]==p) or \
    (gm[3][1]==p and gm[4][2]==p and gm[5][3]==p and gm[6][4]==p) or \
    
  (gm[0][2]==p and gm[1][3]==p and gm[2][4]==p and gm[3][5]==p) or \
    (gm[1][2]==p and gm[2][3]==p and gm[3][4]==p and gm[4][5]==p) or \
    (gm[2][2]==p and gm[3][3]==p and gm[4][4]==p and gm[5][5]==p) or \
    (gm[3][2]==p and gm[4][3]==p and gm[5][4]==p and gm[6][5]==p)
end

define :dbwin do |p,gm| #backward slope diagonal win conditions
  (gm[6][0]==p and gm[5][1]==p and gm[4][2]==p and gm[3][3]==p) or \
    (gm[5][0]==p and gm[4][1]==p and gm[3][2]==p and gm[2][3]==p) or \
    (gm[4][0]==p and gm[3][1]==p and gm[2][2]==p and gm[1][3]==p) or \
    (gm[3][0]==p and gm[2][1]==p and gm[1][2]==p and gm[0][3]==p) or \
    
  (gm[6][1]==p and gm[5][2]==p and gm[4][3]==p and gm[3][4]==p) or \
    (gm[5][1]==p and gm[4][2]==p and gm[3][3]==p and gm[2][4]==p) or \
    (gm[4][1]==p and gm[3][2]==p and gm[2][3]==p and gm[1][4]==p) or \
    (gm[3][1]==p and gm[2][2]==p and gm[1][3]==p and gm[0][4]==p) or \
    
  (gm[6][2]==p and gm[5][3]==p and gm[4][4]==p and gm[3][5]==p) or \
    (gm[5][2]==p and gm[4][3]==p and gm[3][4]==p and gm[2][5]==p) or \
    (gm[4][2]==p and gm[3][3]==p and gm[2][4]==p and gm[1][5]==p) or \
    (gm[3][2]==p and gm[2][3]==p and gm[1][4]==p and gm[0][5]==p)
end
