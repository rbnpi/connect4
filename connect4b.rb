#Connect4b for TouchOSC and SonicPi by Robin Newman Oct 2021 (two players)
#adjust path of next file to suit your setup

run_file "~/Documents/SPfromXML/windefs.rb"
#Install TouchOSC on same computer as Sonic Pi
use_osc "localhost",9000
use_osc_logging false
use_cue_logging false
use_debug false
gm= Array.new(7){Array.new(6)} #internal board image

define :pos do |x,y| #calc index from x,y
  return x+1+y*7
end

define :gmClear do #clear all discs
  7.times do |x|
    6.times do |y|
      gm[x][y] = "-"
      osc "/circ/"+pos(x,y).to_s,0,"000000ff"
    end
  end
end

define :gmPrint do #print screen representation in SP log
  6.times do |y|
    sh=""
    7.times do |x|
      sh+="|"+gm[x][5-y]+"|"
    end
    puts sh
  end
end

define :aimerClear do #reset aimer position
  6.times do |x|
    osc "/aimer/"+(x+2).to_s,0,"00000000"
  end
  osc "/aimer/1",1,"ff0000ff" if get(:turn)=="r"
  osc "/aimer/1",1,"00ff00ff" if get(:turn)=="g"
end

define :cancel do |on| #adjust restart button visibility
  if on then
    osc "/cancel",1
    osc "/labelCancel",1
  else
    osc "/cancel",0
    osc "/labelCancel",0
  end
end

define :setup do #initialise items for new game
  use_random_seed (Time.now.to_i) #reset seed every setup
  osc "/resultMsg","",0,"00000000"
  osc "/another",0;osc "/restart",0
  set :winFlag,false
  set :result,""
  set:turn,["r","g"].choose
  set :numTurns,0
  set :dropPos,1
  aimerClear
  gmClear
  cancel true
end

setup

define :checkWin do #test logic for a win condition nusing defines in windefs.rb file
  result="Draw"
  result="Red Wins!" if(hwin("r",gm) or vwin("r",gm) or dfwin("r",gm) or dbwin("r",gm))
  result="Green Wins!" if(hwin("g",gm) or vwin("g",gm) or dfwin("g",gm) or dbwin("g",gm))
  if result !="Draw"
    set :result,result #store result
    set :winFlag,true #flag it is a win
  end
end

#check a column for next empty slot (if any)
define :rowEmptyNum do |n| #rows numbered from bottom 0->5
  i=0
  while true
    break if gm[n][i]=="-"
    i  += 1
    break if i==6 #i will be 6 if no postions left in column
  end
  return i
end

define :updateAimer do #colour dropper disk
  use_real_time
  colour="ff0000ff" if get(:turn)=="r"
  colour="00ff00ff" if get(:turn)=="g"
  dp=get(:dropPos)
  osc"/aimer/"+dp.to_s,1,colour
end

define :flash do |x,y,colour| #flash winning "disk"
  in_thread do
    10.times do
      osc "/circ/"+pos(x,y).to_s,0,"00000000"
      sleep 0.2
      osc "/circ/"+pos(x,y).to_s,1,colour
      sleep 0.2
    end
  end
end

#dropper is main functional process
define :dropper do |nExt,colour| # drop coloured disk into column n
  n=nExt-1 #adjust column as array numbers from 0 not 1
  if colour=="r" #select synth  and start note for user
    cset="ff0000ff";use_synth :prophet;nt=:c4
  elsif colour=="g"
    cset="00ff00ff";use_synth :tb303;nt=:c5
  end
  rn=rowEmptyNum(n) #get next free position in column
  if rn==6
    sample  :misc_crow #no empty positions in column
    return false #no drop so quit function
  end
  5.downto(rn) do |i| #animate the drop
    osc "/circ/"+pos(n,i).to_s,1,cset
    play note(nt)+2*i,release: 0.1
    sleep 0.05
    osc "/circ/"+pos(n,i).to_s,0,"000000ff" if i!=rn
    sleep 0.05
  end
  sample  :bd_sone,amp:2 #"bong" end of drop
  gm[n][rn]=colour # update the internal gameboard
  set :numTurns,(get(:numTurns) + 1) #bump number of turns
  checkWin
  if get(:winFlag)
    puts "turns #{get(:numTurns)}" #print turns to log
    gmPrint #print local board in log
    result= get(:result)
    if result=="Red Wins!"
      cancel false #switch off cancel button
      osc "/resultMsg","Red Wins!",1,"ff0000ff" #display result
      flash n,rn,"ff0000ff" #flash winning disk
    elsif result=="Green Wins!"
      cancel false #switch off cancel button
      osc "/resultMsg","Green Wins!",1,"00ff00ff" #display result
      flash n,rn,"00ff00ff" #flash winning disk
    end
    sample :loop_amen #game end sound
    sleep 4
    restart true #enable restart button
    sleep 0.1
    sync "/osc*/restart";restart false #wait for restart button press, then disable button
    setup #for next game
  end
  if get(:numTurns)==42 #all discs used
    puts "turns #{get(:numTurns)}" #print turns to log
    gmPrint #print local board to log
    cancel false #disable cancel button
    osc "/resultMsg","It's a Draw!",1,"ffff00ff" #announce a draw
    sample :loop_amen #game end sound
    sleep 4
    restart true #enable restart button
    sleep 0.1
    sync "/osc*/restart";restart false #wait for restart button press then disable it
    setup #for next game
  end
  return true #successful drop
end

define :restart do |on| #adjust restart button visibility
  if on then
    osc "/another",1
    osc "/restart",1
  else
    osc "/another",0
    osc "/restart",0
  end
end

live_loop :leftBtn do #used to move dropper disk left
  use_real_time
  l = sync "/osc*/left"
  dp=get(:dropPos)
  osc "/aimer/"+dp.to_s,0,"00000000" #clear existing
  set :dropPos, ([dp-1,1].max) if l[0]>0 #move 1 place but limit position
  updateAimer
end

live_loop :rightBtn do #used to move dropper disk right
  use_real_time
  l = sync "/osc*/right"
  if l[0]>0
    dp=get(:dropPos)
    osc "/aimer/"+dp.to_s,0,"00000000" #clear existing
    set :dropPos, ([dp+1,7].min) if l[0]>0 #move 1 place but limit position
    updateAimer #update display
  end
end

live_loop :dropDisk do #initiate drop when button pressed
  use_real_time
  dr = sync "/osc*/drop"
  if dr[0]>0
    turn=get(:turn) #update turn colour
    res=dropper get(:dropPos),turn #intiate drop and check if OK (res = true)
    puts "turns #{get(:numTurns)}" #print turns to log
    #only update if dropper result was true
    set :turn,"g" if (turn=="r" and res)
    set :turn,"r" if (turn=="g" and res)
    gmPrint if res #print local board to log if valid drop
    sleep 0.1
    updateAimer #updcate dropper colour
  end
end

live_loop :cancelgame do #deal with cancel button pus => setup for new game
  use_real_time
  k=sync "/osc*/cancel"
  setup if k[1] > 0
end
